import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/question_one_screen/models/question_one_two_model.dart';

import '../../../data/sevices/media_services/audio_services.dart';

class QuestionOneController extends GetxController {
  TextEditingController nameController = TextEditingController();

  Rx<QuestionOneTwoModel> questionOneTwoModelObj = QuestionOneTwoModel().obs;

  var isButtonDisable = true.obs;
  var recordedFilePath = ''.obs;
  RxDouble progress = 0.0.obs;
  late Timer timer;
  RxBool isPlaying = false.obs;
  RxDouble timingSeconds = 0.0.obs;

  RxDouble incrementTimerCount = 0.0.obs;

  void startTimer() async {
    progress.value = 0;
    incrementTimerCount.value = 0.0;
    timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      incrementTimerCount.value = incrementTimerCount.value + 10;
      if (isPlaying.value) {
        if (progress.value < 1) {
          progress.value =
              incrementTimerCount.value / (timerCount.value * 1000);
        } else {
          isPlaying.value = false;
          progress.value = 0.0;
          timer.cancel();
        }
      }
    });
  }

  RxInt timerCount = 0.obs;

  var isStop = false.obs;

  var isVoiceCancel = false.obs;

  var isRecording = RxBool(false);

  void startRecordTimer() {
    timerCount.value = 0;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerCount.value < 10) {
        if (isStop.value) {
          timer.cancel();
          isStop.value = false;
        } else {
          timerCount.value++;
        }
      } else {
        isRecordingOn(false);
        isRecording(false);
        stopRecodeTimer();
        if (isVoiceCancel.value) {
          VoiceRecorderController.stopRecording();
          recordedFilePath.value = VoiceRecorderController.recordingPath.value;
        }
      }
    });
  }

// Function to stop the timer
  void stopRecodeTimer() {
    isStop.value = true;
    // timerCount.value = 0;
  }

  // Function to format the timer count as "mm:ss"
  String formatTime() {
    int minutes = timerCount.value ~/ 60;
    int seconds = timerCount.value % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  var isRecordingOn = RxBool(false);
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
    timer.cancel();
    nameController.dispose();
  }
}
