import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_pin_code_text_field.dart';
import 'controller/forgot_password_verification_two_controller.dart';

// ignore_for_file: must_be_immutable
class ForgotPasswordVerificationTwoScreen
    extends GetWidget<ForgotPasswordVerificationTwoController> {
  const ForgotPasswordVerificationTwoScreen({Key? key})
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
              SizedBox(height: 23.v),
              Text(
                "lbl_resend_otp".tr,
                style: CustomTextStyles.titleSmallRedA200,
              ),
              SizedBox(height: 24.v),
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
