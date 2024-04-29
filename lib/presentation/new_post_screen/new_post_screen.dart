import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_trailing_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_icon_button.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

import 'controller/new_post_controller.dart';

// ignore_for_file: must_be_immutable
class NewPostScreen extends GetWidget<NewPostController> {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          height: 638.v,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 2.v),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              _buildFrame(),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 482.v,
                  width: 335.h,
                  margin: EdgeInsets.only(top: 36.v),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgRectangle178442,
                        height: 482.v,
                        width: 335.h,
                        radius: BorderRadius.circular(
                          12.h,
                        ),
                        alignment: Alignment.center,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 24.h,
                            right: 16.h,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 247.h),
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
                                      decoration:
                                          AppDecoration.outline.copyWith(
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
                              ),
                              SizedBox(height: 286.v),
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
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: 62.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgGroup58,
        margin: EdgeInsets.only(
          left: 19.h,
          top: 12.v,
          bottom: 12.v,
        ),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgFilterHorizontalGray60004,
          margin: EdgeInsets.symmetric(
            horizontal: 21.h,
            vertical: 13.v,
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildFrame() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 422.v),
        padding: EdgeInsets.symmetric(
          horizontal: 70.h,
          vertical: 25.v,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImageConstant.imgFrame427320779,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 98.v),
              child: CustomIconButton(
                height: 64.adaptSize,
                width: 64.adaptSize,
                padding: EdgeInsets.all(14.h),
                child: CustomImageView(
                  imagePath: ImageConstant.imgRemove,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 98.v),
              child: CustomIconButton(
                height: 64.adaptSize,
                width: 64.adaptSize,
                padding: EdgeInsets.all(14.h),
                child: CustomImageView(
                  imagePath: ImageConstant.imgFavourite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
