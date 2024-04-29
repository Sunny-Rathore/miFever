import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/verification_screen/models/verification_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

class VerificationController extends GetxController with CodeAutoFill {
  Rx<TextEditingController> otpController = TextEditingController().obs;

  Rx<VerificationModel> verificationModelObj = VerificationModel().obs;

  RxBool isButtonDisable = RxBool(true);
  RxString enteredOtp = ''.obs;
  RxInt minutes = 1.obs;
  RxInt seconds = 30.obs;
  late Timer timer;
  var email = ''.obs;
  var route = ''.obs;

  @override
  void codeUpdated() {
    otpController.value.text = code ?? '';
  }

  void startTimer() {
    minutes.value = 1;
    seconds.value = 30;
    const oneSec = const Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (seconds.value == 0) {
          if (minutes.value == 0) {
            timer.cancel();
            // Timer is up, you can perform any action here
            print('Timer is up!');
          } else {
            minutes.value--;
            seconds.value = 59;
          }
        } else {
          seconds.value--;
        }
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    listenForCode();
    startTimer();
    email.value = Get.parameters['email'] ?? '';
    route.value = Get.parameters['route'] ?? '';
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }
}
