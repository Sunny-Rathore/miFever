import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_trailing_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_icon_button.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

import 'controller/liked_controller.dart';

// ignore_for_file: must_be_immutable
class LikedScreen extends GetWidget<LikedController> {
  const LikedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 12.v),
            child: SizedBox(
              height: 805.v,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgRectangle17844415x289,
                    height: 415.v,
                    width: 289.h,
                    radius: BorderRadius.circular(
                      9.h,
                    ),
                    alignment: Alignment.topCenter,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 172.v),
                    child: CustomIconButton(
                      height: 72.adaptSize,
                      width: 72.adaptSize,
                      padding: EdgeInsets.all(15.h),
                      decoration: IconButtonStyleHelper.radiusTL36,
                      alignment: Alignment.topCenter,
                      child: CustomImageView(
                        imagePath: ImageConstant.imgFavouritePrimary,
                      ),
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgRectangle178441,
                    height: 482.v,
                    width: 335.h,
                    radius: BorderRadius.circular(
                      12.h,
                    ),
                    alignment: Alignment.bottomCenter,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 44.h,
                        right: 195.h,
                        bottom: 24.v,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 61.h),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.h,
                              vertical: 1.v,
                            ),
                            decoration: AppDecoration.fillPrimary1.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder12,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 2.v),
                                Text(
                                  "lbl_2_km_away".tr,
                                  style: CustomTextStyles.labelMediumPrimary_1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4.v),
                          Text(
                            "lbl_amy_johns_25".tr,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 4.v),
                          Padding(
                            padding: EdgeInsets.only(right: 30.h),
                            child: Row(
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.imgLocation01Gray200,
                                  height: 16.adaptSize,
                                  width: 16.adaptSize,
                                  margin: EdgeInsets.symmetric(vertical: 1.v),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.h),
                                  child: Text(
                                    "lbl_madrid_europe".tr,
                                    textAlign: TextAlign.center,
                                    style: CustomTextStyles.labelLargeGray200,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgFrame427320779,
                    height: 212.v,
                    width: 375.h,
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 113.v),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgMaskGroup,
                    height: 212.v,
                    width: 375.h,
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 113.v),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 67.h,
                        right: 36.h,
                        bottom: 170.v,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 23.v),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 65.h,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.h,
                                        vertical: 1.v,
                                      ),
                                      decoration:
                                          AppDecoration.fillPrimary1.copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder9,
                                      ),
                                      child: Text(
                                        "lbl_2_km_away".tr,
                                        style: theme.textTheme.labelSmall,
                                      ),
                                    ),
                                    SizedBox(height: 4.v),
                                    Text(
                                      "lbl_amy_johns_25".tr,
                                      style: CustomTextStyles.titleMedium17,
                                    ),
                                    SizedBox(height: 4.v),
                                    Row(
                                      children: [
                                        CustomImageView(
                                          imagePath: ImageConstant
                                              .imgLocation01Gray20013x13,
                                          height: 13.adaptSize,
                                          width: 13.adaptSize,
                                          margin: EdgeInsets.only(bottom: 2.v),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3.h),
                                          child: Text(
                                            "lbl_madrid_europe".tr,
                                            style: CustomTextStyles
                                                .labelMediumGray20010,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 7.v),
                                child: OutlineGradientButton(
                                  padding: EdgeInsets.only(
                                    left: 1.h,
                                    top: 1.v,
                                    right: 1.h,
                                    bottom: 1.v,
                                  ),
                                  strokeWidth: 1.h,
                                  gradient: LinearGradient(
                                    begin: Alignment(0.06, 0),
                                    end: Alignment(0.84, 0.91),
                                    colors: [
                                      theme.colorScheme.primary
                                          .withOpacity(0.6),
                                      theme.colorScheme.primary
                                          .withOpacity(0.6),
                                    ],
                                  ),
                                  corners: Corners(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24),
                                    bottomLeft: Radius.circular(24),
                                    bottomRight: Radius.circular(24),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 11.h,
                                      vertical: 9.v,
                                    ),
                                    decoration: AppDecoration.outline.copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder24,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 1.v),
                                        Text(
                                          "lbl_10".tr,
                                          style: CustomTextStyles
                                              .labelLargePrimary,
                                        ),
                                        SizedBox(height: 3.v),
                                        CustomImageView(
                                          imagePath: ImageConstant.imgGroup63,
                                          height: 40.v,
                                          width: 19.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 184.v),
                          CustomImageView(
                            imagePath: ImageConstant.imgElementsPrimary,
                            height: 29.v,
                            width: 32.h,
                            margin: EdgeInsets.only(left: 103.h),
                          ),
                        ],
                      ),
                    ),
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
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: 63.v,
      leadingWidth: 63.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgGroup58,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 10.v,
          bottom: 10.v,
        ),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgFilterHorizontalGray60004,
          margin: EdgeInsets.symmetric(
            horizontal: 20.h,
            vertical: 10.v,
          ),
        ),
      ],
    );
  }
}
