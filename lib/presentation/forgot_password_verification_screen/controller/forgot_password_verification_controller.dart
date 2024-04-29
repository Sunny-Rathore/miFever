import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/forgot_password_verification_screen/models/forgot_password_verification_model.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:flutter/material.dart';

/// A controller class for the ForgotPasswordVerificationScreen.
///
/// This class manages the state of the ForgotPasswordVerificationScreen, including the
/// current forgotPasswordVerificationModelObj
class ForgotPasswordVerificationController extends GetxController
    with CodeAutoFill {
  Rx<TextEditingController> otpController = TextEditingController().obs;

  Rx<ForgotPasswordVerificationModel> forgotPasswordVerificationModelObj =
      ForgotPasswordVerificationModel().obs;

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
