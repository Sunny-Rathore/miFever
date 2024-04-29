import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/forgot_password_verification_two_screen/models/forgot_password_verification_two_model.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:flutter/material.dart';

/// A controller class for the ForgotPasswordVerificationTwoScreen.
///
/// This class manages the state of the ForgotPasswordVerificationTwoScreen, including the
/// current forgotPasswordVerificationTwoModelObj
class ForgotPasswordVerificationTwoController extends GetxController
    with CodeAutoFill {
  Rx<TextEditingController> otpController = TextEditingController().obs;

  Rx<ForgotPasswordVerificationTwoModel> forgotPasswordVerificationTwoModelObj =
      ForgotPasswordVerificationTwoModel().obs;

  @override
  void codeUpdated() {
    otpController.value.text = code ?? '';
  }

  @override
  void onInit() {
    super.onInit();
    listenForCode();
  }
}
