import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_pin_code_text_field.dart';
import 'controller/forgot_password_verification_controller.dart';

// ignore_for_file: must_be_immutable
class ForgotPasswordVerificationScreen
    extends GetWidget<ForgotPasswordVerificationController> {
  const ForgotPasswordVerificationScreen({Key? key})
      : super(
          key: key,
        );

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
                        text: "msg_abc_gmail_com".tr,
                        style: CustomTextStyles.titleSmallff282828,
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
                    onChanged: (value) {},
                  ),
                ),
              ),
              SizedBox(height: 25.v),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "msg_otp_will_expire2".tr,
                      style: CustomTextStyles.bodyMediumff767676,
                    ),
                    TextSpan(
                      text: "lbl_01_30".tr,
                      style: CustomTextStyles.titleSmallfff84754,
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 22.v),
              CustomElevatedButton(
                text: "lbl_continue".tr,
                rightIcon: Container(
                  margin: EdgeInsets.only(left: 4.h),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgArrowleft02sharp,
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                  ),
                ),
                buttonStyle: CustomButtonStyles.fillGray,
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
        imagePath: ImageConstant.imgElementsGray900,
        margin: EdgeInsets.fromLTRB(25.h, 21.v, 330.h, 22.v),
      ),
    );
  }
}
