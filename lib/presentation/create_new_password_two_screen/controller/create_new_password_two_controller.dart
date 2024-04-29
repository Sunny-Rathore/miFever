import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/create_new_password_two_screen/models/create_new_password_two_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the CreateNewPasswordTwoScreen.
///
/// This class manages the state of the CreateNewPasswordTwoScreen, including the
/// current createNewPasswordTwoModelObj
class CreateNewPasswordTwoController extends GetxController {
  TextEditingController newpasswordController = TextEditingController();

  TextEditingController newpasswordController1 = TextEditingController();

  Rx<CreateNewPasswordTwoModel> createNewPasswordTwoModelObj =
      CreateNewPasswordTwoModel().obs;

  Rx<bool> isShowPassword = true.obs;

  Rx<bool> isShowPassword1 = true.obs;

  @override
  void onClose() {
    super.onClose();
    newpasswordController.dispose();
    newpasswordController1.dispose();
  }
}
