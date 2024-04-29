import 'package:flutter/material.dart';

/// A controller class for the SignUpScreen.
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/presentation/sign_up_screen/models/sign_up_model.dart';

import '../../../core/utils/progress_dialog_utils.dart';
import '../../../data/sevices/firebase_services.dart';
import '../../create_a_password_screen/models/create_a_password_model.dart';
import '../../sucess_msg_dialog/controller/sucess_msg_controller.dart';
import '../../sucess_msg_dialog/sucess_msg_dialog.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();

  TextEditingController newpasswordController = TextEditingController();

  TextEditingController newpasswordController1 = TextEditingController();

  Rx<CreateAPasswordModel> createAPasswordModelObj = CreateAPasswordModel().obs;

  Rx<bool> isShowPassword = true.obs;

  Rx<bool> isShowPassword1 = true.obs;

  Rx<bool> isButtonDisable = true.obs;

  Rx<SignUpModel> signUpModelObj = SignUpModel().obs;

  void onTapContinue() async {
    ProgressDialogUtils.showProgressDialog();
    bool isSuccess = await FirebaseServices.signUpWithEmail(
        email: emailController.text.trim(),
        password: newpasswordController.text.trim());
    if (isSuccess) {
      UserModel userModel = UserModel(
        timestamp: DateTime.now().toUtc().toString(),
        email: emailController.text.trim(),
        isProfileComplete: false,
      );
      await FirebaseServices.addUser(userModel);
      ProgressDialogUtils.hideProgressDialog();
      Get.dialog(
        Center(
            child: SucessMsgDialog(
          SucessMsgController(),
          "msg_your_account_has".tr,
        )),
        barrierColor: Colors.black.withOpacity(0.7),
        barrierDismissible: false,
      );
    } else {
      ProgressDialogUtils.hideProgressDialog();
    }
  }

  @override
  void onClose() {
    super.onClose();
    // emailController.dispose();
  }
}
