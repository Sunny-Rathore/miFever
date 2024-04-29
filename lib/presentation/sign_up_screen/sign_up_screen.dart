import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/validation_functions.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_text_form_field.dart';

import '../../data/sevices/firebase_services.dart';
import '../../data/sevices/smtp_service.dart';
import 'controller/sign_up_controller.dart';

// ignore_for_file: must_be_immutable
class SignUpScreen extends GetWidget<SignUpController> {
  SignUpScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.v),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 5.h),
                        child: Text("msg_create_an_account".tr,
                            style: theme.textTheme.headlineSmall)),
                    SizedBox(height: 23.v),
                    CustomElevatedButton(
                        height: 48.v,
                        text: "msg_continue_with_google".tr,
                        margin: EdgeInsets.symmetric(horizontal: 5.h),
                        leftIcon: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 9.h, vertical: 6.v),
                            margin: EdgeInsets.only(right: 8.h),
                            decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(15.h)),
                            child: CustomImageView(
                                imagePath: ImageConstant.imgImage1599,
                                height: 18.adaptSize,
                                width: 18.adaptSize)),
                        buttonStyle: CustomButtonStyles.fillRedA,
                        onPressed: () {
                          FirebaseServices.signInWithGoogle();
                        }),
                    SizedBox(height: 29.v),
                    _buildFrameTwelve(),
                    SizedBox(height: 30.v),
                    Padding(
                        padding: EdgeInsets.only(left: 5.h),
                        child: Text("lbl_your_email".tr,
                            style: CustomTextStyles.titleSmallGray60002)),
                    SizedBox(height: 8.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.h),
                      child: CustomTextFormField(
                        controller: controller.emailController,
                        hintText: "msg_enter_email_address".tr,
                        hintStyle: CustomTextStyles.bodySmall12,
                        textInputAction: TextInputAction.done,
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
                          controller.isButtonDisable(val.isEmpty);
                        },
                      ),
                    ),
                    SizedBox(height: 24.v),
                    Obx(
                      () => CustomElevatedButton(
                        buttonStyle: controller.isButtonDisable.value
                            ? CustomButtonStyles.fillGray
                            : null,
                        text: "lbl_continue".tr,
                        margin: EdgeInsets.symmetric(horizontal: 5.h),
                        rightIcon: Container(
                          margin: EdgeInsets.only(left: 4.h),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgArrowleft02sharp,
                            height: 24.adaptSize,
                            width: 24.adaptSize,
                          ),
                        ),
                        onPressed: controller.isButtonDisable.value
                            ? null
                            : onTapContinue,
                      ),
                    ),
                    SizedBox(height: 5.v)
                  ],
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
          Get.back();
        },
        imagePath: ImageConstant.imgElementsGray900,
        margin: EdgeInsets.fromLTRB(25.h, 21.v, 330.h, 22.v),
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameTwelve() {
    return Padding(
        padding: EdgeInsets.only(left: 5.h),
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Padding(
              padding: EdgeInsets.only(top: 10.v, bottom: 8.v),
              child: SizedBox(width: 156.h, child: Divider())),
          Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: Text("lbl_or".tr,
                  style: CustomTextStyles.titleSmallGray60002)),
          Padding(
              padding: EdgeInsets.only(top: 10.v, bottom: 8.v),
              child: SizedBox(width: 160.h, child: Divider(indent: 4.h)))
        ]));
  }

  onTapContinue() async {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      bool isEmailInUse = await FirebaseServices.checkEmailExists(
          controller.emailController.text);
      if (isEmailInUse) {
        Fluttertoast.showToast(msg: 'lbl_email_already_use'.tr);
      } else {
        int otp = generateRandomNumber();
        await PrefUtils.saveOtp(otp);
        debugPrint('otp===>$otp');
        await sendMail(
            subject: 'MiFever - OTP for Authentication',
            fullName: PrefUtils.getUserName(),
            email: controller.emailController.text,
            text:
                "Your one time password (OTP) is $otp.\nThis OTP is valid for 90 seconds. Never share this OTP with anyone else.\n\n\nWarm regards,\nMiFever Team");

        Get.toNamed(AppRoutes.verificationScreen, parameters: {
          'email': controller.emailController.text.trim(),
          'route': AppRoutes.signUpScreen,
        });
      }
    }
  }
}
