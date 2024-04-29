// ignore_for_file: sdk_version_since

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/presentation/chat_screen/models/chat_model.dart';

import '../../../data/models/notification/notification.dart';
import '../../../data/models/thermometer_model/thermometer_model.dart';
import '../models/translation_model.dart';

class ChatController extends GetxController {
  TextEditingController messageOneController = TextEditingController();

  TextEditingController messageController = TextEditingController();

  ScrollController listScrollController = ScrollController();

  Rx<ChatModel> chatModelObj = ChatModel().obs;

  RxInt timerCount = 0.obs;

  var isStop = false.obs;

  var isVoiceCancel = false.obs;

  var isRecording = RxBool(false);

  var isRecordingOn = RxBool(false);

  var userName = ''.obs;

  var emojiShowing = false.obs;

  List<TranslationModel> translationList = <TranslationModel>[].obs;

// implement scroll
  scrollDown() {
    if (listScrollController.hasClients) {
      final position = listScrollController.position.minScrollExtent;
      listScrollController.jumpTo(position);
    }
  }

  doFakeEntry(receiverId) async {
    /* check real match user */
    var isRealMatchUser = await FirebaseServices.isRealMatched(receiverId);
    if (!isRealMatchUser) {
      /* subtract text counts */
      textTries.value--;
      FirebaseServices.updateTextTries("${textTries.value} Chances");
      FirebaseServices.makeMatchFromChat(receiverId);
      ThermometerModel thermometerModel = ThermometerModel(
        timestamp: DateTime.now().toString(),
        roomId: FirebaseServices.createChatRoomId(receiverId),
        userIds: [receiverId, PrefUtils.getId()],
        percentageValue: 20,
      );
      await FirebaseServices.addThermometerValue(thermometerModel);
    }
  }

  void senMessage(String receiverId) async {
    if (messageController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Cant't send empty message");
    } else {
      ChatModel chat = ChatModel(
        roomId: FirebaseServices.createChatRoomId(receiverId),
        message: messageController.text.trim(),
        senderId: PrefUtils.getId(),
        receiverId: receiverId,
        timestamp: DateTime.now().toString(),
        type: MessageType.Text.name,
        linkCount: 0,
        isSeen: false,
      );
      await FirebaseServices.sendMessage(chat: chat);
      scrollDown();
      FirebaseServices.sendChatNotification(
          type: NotificationType.Chat.name,
          id: receiverId,
          message: messageController.text.trim());
      messageController.clear();

      doFakeEntry(receiverId);
    }
  }

  sendVoiceMessage(
      {required String receiverId,
      required String path,
      required timerValue}) async {
    // String url =
    //     await FirebaseServices.uploadFile(filePath: path, contentType: '.mp3');
    ChatModel chat = ChatModel(
      roomId: FirebaseServices.createChatRoomId(receiverId),
      senderId: PrefUtils.getId(),
      receiverId: receiverId,
      timestamp: DateTime.now().toString(),
      type: MessageType.Voice.name,
      url: '',
      voiceDuration: timerValue,
      isSeen: false,
    );
    await FirebaseServices.sendVoiceChat(chat: chat, path: path);
    scrollDown();
    doFakeEntry(receiverId);
  }

// Function to stop the timer
  void stopTimer() {
    isStop.value = true;
    timerCount.value = 0;
  }

  // Function to start the timer
  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isStop.value) {
        timer.cancel();
        isStop.value = false;
      } else {
        timerCount.value++;
      }
    });
  }

  // Function to format the timer count as "mm:ss"
  String formatTime() {
    int minutes = timerCount.value ~/ 60;
    int seconds = timerCount.value % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  var textTries = 0.obs;
  var isRequested = false.obs;

  checkIsRequested(String receiverId) async {
    isRequested.value = await FirebaseServices.isRequested(receiverId);
  }

  @override
  void onInit() {
    super.onInit();
    FirebaseServices.getCurrentTexTriesSubscription().then((value) {
      textTries.value = int.parse(value.replaceFirst(" Chances", ""));
    });
  }

  @override
  void onClose() {
    super.onClose();
    messageOneController.dispose();
    messageController.dispose();
  }
}

enum MessageType { Text, Voice, Media, Video, Travel }
