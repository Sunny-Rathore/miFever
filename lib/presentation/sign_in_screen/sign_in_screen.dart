// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/progress_dialog_utils.dart';
import 'package:mifever/core/utils/validation_functions.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/data/sevices/smtp_service.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_text_form_field.dart';

import 'controller/sign_in_controller.dart';

// ignore_for_file: must_be_immutable
class SignInScreen extends GetWidget<SignInController> {
  SignInScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(AppRoutes.onboardingScreen);
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: _buildAppBar(),
          body: SizedBox(
            width: SizeUtils.width,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Form(
                key: _formKey,
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.h,
                    vertical: 13.v,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "msg_continue_to_login2".tr,
                          style: theme.textTheme.headlineSmall,
                        ),
                      ),
                      SizedBox(height: 20.v),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "lbl_your_email".tr,
                          style: CustomTextStyles.titleSmallGray60002,
                        ),
                      ),
                      SizedBox(height: 8.v),
                      CustomTextFormField(
                        controller: controller.emailController,
                        hintText: "msg_enter_email_address".tr,
                        hintStyle: CustomTextStyles.bodySmall12,
                        textInputType: TextInputType.emailAddress,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(12.h, 12.v, 8.h, 12.v),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgMail02RedA200,
                            height: 20.adaptSize,
                            width: 20.adaptSize,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 44.v,
                        ),
                        validator: (value) {
                          if (value == null ||
                              (!isValidEmail(value, isRequired: true))) {
                            return "err_msg_please_enter_valid_email".tr;
                          }
                          return null;
                        },
                        onChanged: (val) {
                          if (controller.emailController.text.isEmpty ||
                              controller.passwordController.text.isEmpty) {
                            controller.isButtonDisable.value = true;
                          } else {
                            controller.isButtonDisable.value = false;
                          }
                        },
                      ),
                      SizedBox(height: 24.v),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "lbl_your_password".tr,
                          style: CustomTextStyles.titleSmallGray60002,
                        ),
                      ),
                      SizedBox(height: 7.v),
                      Obx(
                        () => CustomTextFormField(
                          controller: controller.passwordController,
                          hintText: "msg_enter_your_password".tr,
                          hintStyle: CustomTextStyles.bodySmall12,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.visiblePassword,
                          prefix: Container(
                            margin: EdgeInsets.fromLTRB(12.h, 12.v, 8.h, 12.v),
                            child: CustomImageView(
                              imagePath: ImageConstant.imgCirclepassword,
                              height: 20.adaptSize,
                              width: 20.adaptSize,
                            ),
                          ),
                          prefixConstraints: BoxConstraints(
                            maxHeight: 44.v,
                          ),
                          suffix: InkWell(
                            onTap: () {
                              controller.isShowPassword.value =
                                  !controller.isShowPassword.value;
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.fromLTRB(12.h, 12.v, 12.h, 12.v),
                              child: CustomImageView(
                                imagePath: controller.isShowPassword.value
                                    ? ImageConstant.imgView
                                    : ImageConstant.imgViewoff,
                                height: 20.adaptSize,
                                width: 20.adaptSize,
                              ),
                            ),
                          ),
                          suffixConstraints: BoxConstraints(
                            maxHeight: 44.v,
                          ),
                          validator: (value) {
                            if (value == null ||
                                (!isValidPassword(value, isRequired: true))) {
                              return "err_msg_please_enter_valid_password".tr;
                            }
                            return null;
                          },
                          onChanged: (val) {
                            if (controller.emailController.text.isEmpty ||
                                controller.passwordController.text.isEmpty) {
                              controller.isButtonDisable.value = true;
                            } else {
                              controller.isButtonDisable.value = false;
                            }
                          },
                          obscureText: controller.isShowPassword.value,
                          contentPadding: EdgeInsets.symmetric(vertical: 13.v),
                        ),
                      ),
                      SizedBox(height: 24.v),
                      Obx(
                        () => CustomElevatedButton(
                          text: "lbl_continue".tr,
                          rightIcon: Container(
                            margin: EdgeInsets.only(left: 4.h),
                            child: CustomImageView(
                              imagePath: ImageConstant.imgArrowleft02sharp,
                              height: 24.adaptSize,
                              width: 24.adaptSize,
                            ),
                          ),
                          buttonStyle: controller.isButtonDisable.value
                              ? CustomButtonStyles.fillGray
                              : null,
                          onPressed: controller.isButtonDisable.value
                              ? null
                              : _onTapContinue,
                        ),
                      ),
                      SizedBox(height: 31.v),
                      InkWell(
                        onTap: _onTapForgotPassword,
                        child: Text(
                          "msg_forgot_password".tr,
                          style: CustomTextStyles.titleSmallRedA200,
                        ),
                      ),
                      SizedBox(height: 5.v),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingImage(
        onTap: () {
          Get.toNamed(AppRoutes.onboardingScreen);
        },
        imagePath: ImageConstant.imgElementsGray900,
        margin: EdgeInsets.fromLTRB(25.h, 21.v, 330.h, 22.v),
      ),
    );
  }

  _onTapForgotPassword() async {
    if (controller.emailController.text.isNotEmpty) {
      ProgressDialogUtils.showProgressDialog();
      await FirebaseServices.sendPasswordResetEmail(
          controller.emailController.text);
      ProgressDialogUtils.hideProgressDialog();

      // Get.to(() => ForgotPasswordView());
      // Get.toNamed(AppRoutes.verificationScreen, parameters: {
      //   'email': controller.emailController.text.trim(),
      //   'route': AppRoutes.forgotPasswordVerificationOneScreen,
      // });
    } else {
      Get.snackbar('Alert', 'Please enter email');
    }
  }

  _onTapContinue() async {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      int otp = generateRandomNumber();
      await PrefUtils.saveOtp(otp);
      debugPrint('otp===>$otp');

      await FirebaseServices.signInWithEmail(
              email: controller.emailController.text.trim(),
              password: controller.passwordController.text.trim())
          .then((isSuccess) async {
        if (isSuccess) {
          FirebaseServices.getCurrentUser().then((user) async {
            if (user != null) {
              await sendMail(
                  fullName: PrefUtils.getUserName(),
                  subject: 'MiFever - OTP for Authentication',
                  email: controller.emailController.text,
                  text:
                      "Your one time password (OTP) is $otp.\nThis OTP is valid for 90 seconds. Never share this OTP with anyone else.\n\n\nWarm regards,\nMiFever Team");
              // if (user.isProfileComplete ?? false) {
              //   PrefUtils.setUserName(user.name ?? '').then((value) {});
              //   Get.offAll(() => CustomBottomBar());
              //   // Get.offAllNamed(AppRoutes.homeScreen);
              // } else
              //{
              Get.toNamed(AppRoutes.verificationScreen, parameters: {
                'email': controller.emailController.text.trim(),
                'route': AppRoutes.signInScreen,
              });
              // }
            } else {
              Get.toNamed(AppRoutes.verificationScreen, parameters: {
                'email': controller.emailController.text.trim(),
                'route': AppRoutes.signInScreen,
              });
            }
          });
        }
      });
    }
  }
}

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
