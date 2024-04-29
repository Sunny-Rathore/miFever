import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_trailing_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_icon_button.dart';

import 'controller/disliked_controller.dart';

// ignore_for_file: must_be_immutable
class DislikedScreen extends GetWidget<DislikedController> {
  const DislikedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: 702.v,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Opacity(
                  opacity: 0.8,
                  child: SizedBox(
                    height: 470.v,
                    width: 273.h,
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgRectangle17844470x273,
                          height: 470.v,
                          width: 273.h,
                          radius: BorderRadius.circular(
                            11.h,
                          ),
                          alignment: Alignment.center,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 78.adaptSize,
                            width: 78.adaptSize,
                            margin: EdgeInsets.only(
                              left: 13.h,
                              top: 157.v,
                            ),
                            padding: EdgeInsets.all(17.h),
                            decoration: AppDecoration.fillPrimary3.copyWith(
                              borderRadius: BorderRadiusStyle.circleBorder40,
                            ),
                            child: CustomIconButton(
                              height: 43.adaptSize,
                              width: 43.adaptSize,
                              padding: EdgeInsets.all(6.h),
                              alignment: Alignment.center,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgRemovePrimary43x43,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 482.v,
                  width: 335.h,
                  margin: EdgeInsets.only(bottom: 5.v),
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
                            bottom: 22.v,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 75.h,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.h,
                                  vertical: 1.v,
                                ),
                                decoration: AppDecoration.fillPrimary1.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder12,
                                ),
                                child: Text(
                                  "lbl_2_km_away".tr,
                                  style: CustomTextStyles.labelMediumPrimary_1,
                                ),
                              ),
                              SizedBox(height: 5.v),
                              Text(
                                "lbl_amy_johns_25".tr,
                                style: theme.textTheme.titleLarge,
                              ),
                              SizedBox(height: 5.v),
                              Row(
                                children: [
                                  CustomImageView(
                                    imagePath:
                                        ImageConstant.imgLocation01Gray200,
                                    height: 16.adaptSize,
                                    width: 16.adaptSize,
                                    margin: EdgeInsets.only(bottom: 2.v),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4.h),
                                    child: Text(
                                      "lbl_madrid_europe".tr,
                                      style: CustomTextStyles.labelLargeGray200,
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
              _buildFortyThree(),
              _buildAppBar(),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFortyThree() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 155.h,
          vertical: 40.v,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImageConstant.imgFrame427320779,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 68.v),
            CustomIconButton(
              height: 64.adaptSize,
              width: 64.adaptSize,
              padding: EdgeInsets.all(13.h),
              decoration: IconButtonStyleHelper.outlinePrimaryTL32,
              child: CustomImageView(
                imagePath: ImageConstant.imgRemovePrimary,
              ),
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
