import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_trailing_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_icon_button.dart';

import 'controller/disliked_one_controller.dart';

// ignore_for_file: must_be_immutable
class DislikedOneScreen extends GetWidget<DislikedOneController> {
  const DislikedOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: SizedBox(
              height: 768.v,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 482.v,
                      width: 335.h,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgRectangle178441,
                            height: 482.v,
                            width: 335.h,
                            radius: BorderRadius.circular(
                              12.h,
                            ),
                            alignment: Alignment.center,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 24.h,
                                right: 175.h,
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
                                    decoration:
                                        AppDecoration.fillPrimary1.copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder12,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 2.v),
                                        Text(
                                          "lbl_2_km_away".tr,
                                          style: CustomTextStyles
                                              .labelMediumPrimary_1,
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
                                  Row(
                                    children: [
                                      CustomImageView(
                                        imagePath:
                                            ImageConstant.imgLocation01Gray200,
                                        height: 16.adaptSize,
                                        width: 16.adaptSize,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 1.v),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.h),
                                        child: Text(
                                          "lbl_madrid_europe".tr,
                                          textAlign: TextAlign.center,
                                          style: CustomTextStyles
                                              .labelLargeGray200,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
                    margin: EdgeInsets.only(bottom: 66.v),
                  ),
                  _buildFiftyNine(),
                  _buildAppBar(),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Opacity(
                      opacity: 0.8,
                      child: Container(
                        height: 497.v,
                        width: 360.h,
                        margin: EdgeInsets.only(top: 49.v),
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgRectangle17844497x360,
                              height: 497.v,
                              width: 360.h,
                              radius: BorderRadius.circular(
                                11.h,
                              ),
                              alignment: Alignment.center,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: 174.h,
                                  bottom: 113.v,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomIconButton(
                                      height: 72.adaptSize,
                                      width: 72.adaptSize,
                                      padding: EdgeInsets.all(15.h),
                                      decoration:
                                          IconButtonStyleHelper.fillPrimary,
                                      alignment: Alignment.centerRight,
                                      child: CustomImageView(
                                        imagePath:
                                            ImageConstant.imgRemovePrimary72x72,
                                      ),
                                    ),
                                    SizedBox(height: 48.v),
                                    SizedBox(
                                      height: 72.v,
                                      width: 86.h,
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(right: 42.h),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 7.v),
                                              decoration: AppDecoration
                                                  .fillPrimary1
                                                  .copyWith(
                                                borderRadius: BorderRadiusStyle
                                                    .roundedBorder24,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 18.v),
                                                  Text(
                                                    "lbl_2_km_away".tr,
                                                    textAlign: TextAlign.center,
                                                    style: CustomTextStyles
                                                        .labelMediumPrimary,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "lbl_amy_johns_25".tr,
                                                  textAlign: TextAlign.center,
                                                  style: CustomTextStyles
                                                      .titleMedium18,
                                                ),
                                                SizedBox(height: 9.v),
                                                Text(
                                                  "lbl_madrid_europe".tr,
                                                  textAlign: TextAlign.center,
                                                  style: CustomTextStyles
                                                      .labelMediumGray200,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFiftyNine() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 64.v),
        padding: EdgeInsets.symmetric(
          horizontal: 169.h,
          vertical: 54.v,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImageConstant.imgMaskGroup,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 68.v),
            CustomImageView(
              imagePath: ImageConstant.imgRemovePrimary,
              height: 36.adaptSize,
              width: 36.adaptSize,
            ),
          ],
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
          top: 22.v,
          bottom: 10.v,
        ),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgFilterHorizontalGray60004,
          margin: EdgeInsets.fromLTRB(20.h, 22.v, 20.h, 10.v),
        ),
      ],
      styleType: Style.bgFill,
    );
  }
}
