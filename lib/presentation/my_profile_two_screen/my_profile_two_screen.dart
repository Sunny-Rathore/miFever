import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_icon_button.dart';
import 'package:mifever/widgets/custom_switch.dart';

import 'controller/my_profile_two_controller.dart';

// ignore_for_file: must_be_immutable
class MyProfileTwoScreen extends GetWidget<MyProfileTwoController> {
  const MyProfileTwoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.v),
              child: Column(
                children: [
                  _buildLayerTwentyOne(),
                  SizedBox(height: 8.v),
                  CustomElevatedButton(
                    height: 28.v,
                    width: 140.h,
                    text: "msg_35_profile_completed".tr,
                    buttonStyle: CustomButtonStyles.fillRedTL14,
                    buttonTextStyle: CustomTextStyles.labelMediumRedA200,
                  ),
                  SizedBox(height: 8.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 3.v),
                        child: Text(
                          "lbl_john_smith_24".tr,
                          style: CustomTextStyles.titleLargeGray900,
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgGroup26,
                        height: 30.adaptSize,
                        width: 30.adaptSize,
                        margin: EdgeInsets.only(left: 8.h),
                      ),
                    ],
                  ),
                  SizedBox(height: 28.v),
                  _buildFrame1(),
                  SizedBox(height: 30.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: _buildFrame(
                      image: ImageConstant.imgUserAccountRedA200,
                      languages: "lbl_profile_details".tr,
                    ),
                  ),
                  SizedBox(height: 16.v),
                  _buildFrame3(),
                  SizedBox(height: 16.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: _buildFrame(
                      image: ImageConstant.imgLanguageSquare,
                      languages: "lbl_languages".tr,
                    ),
                  ),
                  SizedBox(height: 16.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: _buildFrame(
                      image: ImageConstant.imgHelpCircleRedA200,
                      languages: "lbl_help_support".tr,
                    ),
                  ),
                  SizedBox(height: 16.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: _buildFrame(
                      image: ImageConstant.imgTask02RedA200,
                      languages: "msg_terms_conditions".tr,
                    ),
                  ),
                  SizedBox(height: 16.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: _buildFrame(
                      image: ImageConstant.imgSecurityCheck,
                      languages: "lbl_privacy_policy".tr,
                    ),
                  ),
                  SizedBox(height: 30.v),
                  CustomElevatedButton(
                    height: 40.v,
                    text: "lbl_log_out".tr,
                    margin: EdgeInsets.symmetric(horizontal: 20.h),
                    buttonStyle: CustomButtonStyles.fillRedTL4,
                    buttonTextStyle: theme.textTheme.titleSmall!,
                  ),
                  SizedBox(height: 30.v),
                  Text(
                    "lbl_version_0_011".tr,
                    style: CustomTextStyles.bodySmall11,
                  ),
                  SizedBox(height: 2.v),
                  Text(
                    "lbl_mifever".tr,
                    style: CustomTextStyles.bodySmall11,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildLayerTwentyOne() {
    return SizedBox(
      height: 172.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 105.v,
              width: double.maxFinite,
              decoration: AppDecoration.gradientOnPrimaryToRedA,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Opacity(
                    opacity: 0.16,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgLayer21,
                      height: 105.v,
                      width: 375.h,
                      alignment: Alignment.center,
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgSend,
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(
                      top: 20.v,
                      right: 20.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusStyle.circleBorder67,
              ),
              child: Container(
                height: 134.adaptSize,
                width: 134.adaptSize,
                padding: EdgeInsets.symmetric(
                  horizontal: 1.h,
                  vertical: 2.v,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.circleBorder67,
                ),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 130.adaptSize,
                        width: 130.adaptSize,
                        decoration: BoxDecoration(
                          color: appTheme.red50,
                          borderRadius: BorderRadius.circular(
                            65.h,
                          ),
                        ),
                      ),
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgSettings,
                      height: 58.v,
                      width: 38.h,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(
                        left: 1.h,
                        top: 6.v,
                      ),
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgEllipse1598120x120,
                      height: 120.adaptSize,
                      width: 120.adaptSize,
                      radius: BorderRadius.circular(
                        60.h,
                      ),
                      alignment: Alignment.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.v),
                      child: CustomIconButton(
                        height: 40.adaptSize,
                        width: 40.adaptSize,
                        padding: EdgeInsets.all(10.h),
                        decoration: IconButtonStyleHelper.outlinePrimaryTL20,
                        alignment: Alignment.bottomRight,
                        child: CustomImageView(
                          imagePath: ImageConstant.imgEdit02,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFrame1() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      padding: EdgeInsets.all(12.h),
      decoration: AppDecoration.gradientGrayToGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder9,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgGroup26Gray900,
            height: 42.adaptSize,
            width: 42.adaptSize,
            margin: EdgeInsets.only(bottom: 42.v),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 9.h,
              top: 3.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "msg_buy_platinum_plan".tr,
                  style: CustomTextStyles.titleSmallPrimaryExtraBold,
                ),
                SizedBox(height: 3.v),
                Text(
                  "msg_lorem_ipsum_dolor5".tr,
                  style: CustomTextStyles.bodySmallPrimary,
                ),
                SizedBox(height: 10.v),
                CustomElevatedButton(
                  height: 30.v,
                  width: 110.h,
                  text: "lbl_view_details".tr,
                  buttonStyle: CustomButtonStyles.fillPrimaryTL15,
                  buttonTextStyle: CustomTextStyles.labelLargeGray60003,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFrame3() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      padding: EdgeInsets.symmetric(
        horizontal: 11.h,
        vertical: 12.v,
      ),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgNotification02,
            height: 20.adaptSize,
            width: 20.adaptSize,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              "lbl_notifications".tr,
              style: theme.textTheme.titleSmall,
            ),
          ),
          Spacer(),
          Obx(
            () => CustomSwitch(
              margin: EdgeInsets.symmetric(vertical: 2.v),
              value: controller.isSelectedSwitch.value,
              onChange: (value) {
                controller.isSelectedSwitch.value = value;
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildFrame({
    required String image,
    required String languages,
  }) {
    return Container(
      padding: EdgeInsets.all(11.h),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: image,
            height: 20.adaptSize,
            width: 20.adaptSize,
            margin: EdgeInsets.only(top: 1.v),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 8.h,
              top: 1.v,
            ),
            child: Text(
              languages,
              style: theme.textTheme.titleSmall!.copyWith(
                color: appTheme.gray900,
              ),
            ),
          ),
          Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgArrowRightGray6000416x16,
            height: 16.adaptSize,
            width: 16.adaptSize,
            margin: EdgeInsets.only(
              top: 1.v,
              bottom: 3.v,
            ),
          ),
        ],
      ),
    );
  }
}
