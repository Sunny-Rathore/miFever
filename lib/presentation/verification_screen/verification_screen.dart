import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_pin_code_text_field.dart';

import '../../data/sevices/firebase_services.dart';
import '../../data/sevices/smtp_service.dart';
import '../../widgets/custom_bottom_bar.dart';
import 'controller/verification_controller.dart';

// ignore_for_file: must_be_immutable
class VerificationScreen extends GetWidget<VerificationController> {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 20.h,
            vertical: 10.v,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "lbl_verification".tr,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              SizedBox(height: 23.v),
              Container(
                width: 268.h,
                margin: EdgeInsets.only(
                  left: 32.h,
                  right: 33.h,
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "msg_we_have_sent_otp2".tr,
                        style: CustomTextStyles.bodyMediumff767676,
                      ),
                      TextSpan(
                        text: controller.email.value,
                        style: CustomTextStyles.titleSmallff282828,
                      ),
                      TextSpan(
                        text: "msg_abc_gmail_com".tr,
                        style: CustomTextStyles.bodyMediumff767676,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 21.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 43.h),
                child: Obx(
                  () => CustomPinCodeTextField(
                    context: Get.context!,
                    controller: controller.otpController.value,
                    onChanged: (value) {
                      if (value.length == 4) {
                        controller.isButtonDisable(true);
                        controller.enteredOtp.value = value;
                      }
                    },
                    onCompleted: (p0) {
                      controller.isButtonDisable(false);
                    },
                  ),
                ),
              ),
              SizedBox(height: 25.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'msg_otp_will_expire2'.tr,
                    style: CustomTextStyles.bodyMediumff767676,
                  ),
                  Obx(
                    () => controller.minutes.value == 0 &&
                            controller.seconds.value == 0
                        ? InkWell(
                            onTap: () async {
                              controller.otpController.value.clear();
                              int otp = generateRandomNumber();
                              await PrefUtils.saveOtp(otp);
                              debugPrint('otp===>$otp');
                              await sendMail(
                                  subject: 'MiFever - OTP for Authentication',
                                  fullName: PrefUtils.getUserName(),
                                  email: controller.email.value,
                                  text:
                                      "Your one time password (OTP) is $otp.\nThis OTP is valid for 90 seconds. Never share this OTP with anyone else.\n\n\nWarm regards,\nMiFever Team");

                              controller.startTimer();
                            },
                            child: Text(
                              'lbl_resend'.tr,
                              style: CustomTextStyles.titleSmallfff84754,
                            ),
                          )
                        : Text(
                            '0${controller.minutes.value}:${controller.seconds.value.toString().length == 1 ? "0${controller.seconds.value}" : controller.seconds.value} ',
                            //"lbl_01_30".tr,
                            style: CustomTextStyles.titleSmallfff84754,
                          ),
                  ),
                ],
              ),
              SizedBox(height: 22.v),
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
                  onPressed:
                      controller.isButtonDisable.value ? null : _onTapContinue,
                ),
              ),
              SizedBox(height: 5.v),
            ],
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

  _onTapContinue() {
    if (controller.enteredOtp.value == PrefUtils.getOtp().toString()) {
      if (controller.minutes.value == 0 && controller.seconds.value == 0) {
        Fluttertoast.showToast(msg: 'error_msg_otp_expired'.tr);
      } else {
        if (controller.route.value == AppRoutes.signUpScreen) {
          Get.toNamed(AppRoutes.createAPasswordScreen);
        } else if (controller.route.value ==
            AppRoutes.forgotPasswordVerificationOneScreen) {
          Get.toNamed(AppRoutes.createNewPasswordScreen);
        } else {
          FirebaseServices.getCurrentUser().then((user) {
            if (user != null) {
              if (user.isProfileComplete ?? false) {
                PrefUtils.setUserName(user.name ?? '').then((value) {});
                Get.offAll(() => CustomBottomBar());
              } else {
                Get.toNamed(AppRoutes.questionOneScreen);
              }
            } else {
              PrefUtils.clearPreferencesData();
              Get.offAllNamed(AppRoutes.onboardingScreen);
            }
          });
          // FirebaseServices.getCurrentUser().then((user) async {}
        }
      }
    } else {
      Fluttertoast.showToast(msg: 'error_msg_wrong_otp'.tr);
    }
  }
}
