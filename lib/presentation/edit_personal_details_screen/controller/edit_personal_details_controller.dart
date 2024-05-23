import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// A controller class for the ProflieDetailsEditPersonalDetailsScreen.
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/progress_dialog_utils.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/presentation/edit_personal_details_screen/models/edit_personal_details_model.dart';

import '../../../data/sevices/media_services/audio_services.dart';

class EditPersonalDetailsController extends GetxController {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  Rx<EditPersonalDetailsModel> proflieDetailsEditPersonalDetailsModelObj =
      EditPersonalDetailsModel().obs;

  var selectedGender = 'Male'.obs;
  var isCurrentLocation = PrefUtils.getIsCurrentLocation().obs;
  Rx<DateTime> initialDateTime =
      DateTime.now().subtract(Duration(days: 18 * 366)).obs;
  var selectedDate =
      DateTime.now().subtract(Duration(days: 18 * 366)).format().obs;
  var previousSelected =
      DateTime.now().subtract(Duration(days: 18 * 366)).format().obs;
  Rx<UserModel> user = UserModel().obs;

  void onTapContinue() async {
    ProgressDialogUtils.showProgressDialog();
    bool isAudioNotChange = recordedFilePath.value == user.value.nameAudio;
    UserModel userModel = UserModel(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        dob: selectedDate.value,
        locationText: locationController.text,
        gender: selectedGender.value,
        audioDuration:
            isAudioNotChange ? user.value.audioDuration ?? 0 : timerCount.value,
        nameAudio: isAudioNotChange
            ? user.value.nameAudio ?? ''
            : await FirebaseServices.uploadFile(
                filePath: recordedFilePath.value, contentType: '.mp3'));

    await FirebaseServices.updateUser(userModel).then((value) {
      if (value) {
        Fluttertoast.showToast(msg: 'Success');
        PrefUtils.setGender(selectedGender.value);
        PrefUtils.setUserName(nameController.text.trim());
      }
    });
    ProgressDialogUtils.hideProgressDialog();
    Get.back();
  }

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
              incrementTimerCount.value / ((timerCount.value + 1) * 1000);
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
  void onInit() {
    FirebaseServices.getCurrentUser().then((user) {
      if (user != null) {
        nameController.text = user.name ?? '';
        emailController.text = user.email ?? '';
        selectedDate.value = user.dob ?? '';
        selectedGender.value = user.gender ?? '';
        locationController.text = user.locationText ?? '';
        recordedFilePath.value = user.nameAudio ?? '';
        timerCount.value = user.audioDuration ?? 3;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    timer.cancel();
    nameController.dispose();
    emailController.dispose();
    locationController.dispose();
  }
}
