import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_trailing_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_icon_button.dart';

import 'controller/liked_one_controller.dart';

// ignore_for_file: must_be_immutable
class LikedOneScreen extends GetWidget<LikedOneController> {
  const LikedOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: 704.v,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Opacity(
                  opacity: 0.5,
                  child: SizedBox(
                    height: 337.v,
                    width: 289.h,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgRectangle17844337x289,
                          height: 337.v,
                          width: 289.h,
                          radius: BorderRadius.circular(
                            9.h,
                          ),
                          alignment: Alignment.center,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20.h,
                              right: 108.h,
                              bottom: 18.v,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomIconButton(
                                  height: 72.adaptSize,
                                  width: 72.adaptSize,
                                  padding: EdgeInsets.all(15.h),
                                  decoration: IconButtonStyleHelper.radiusTL36,
                                  alignment: Alignment.centerRight,
                                  child: CustomImageView(
                                    imagePath:
                                        ImageConstant.imgFavouritePrimary,
                                  ),
                                ),
                                SizedBox(height: 87.v),
                                Container(
                                  margin: EdgeInsets.only(right: 95.h),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.h,
                                    vertical: 1.v,
                                  ),
                                  decoration:
                                      AppDecoration.fillPrimary1.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder9,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 3.v),
                                      Text(
                                        "lbl_2_km_away".tr,
                                        style: theme.textTheme.labelSmall,
                                      ),
                                    ],
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
                  margin: EdgeInsets.only(bottom: 47.v),
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
              _buildClientTestimonials(),
              _buildAppBar(),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildClientTestimonials() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 155.h,
          vertical: 42.v,
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
            SizedBox(height: 64.v),
            CustomIconButton(
              height: 64.adaptSize,
              width: 64.adaptSize,
              padding: EdgeInsets.all(13.h),
              decoration: IconButtonStyleHelper.outlinePrimaryTL32,
              child: CustomImageView(
                imagePath: ImageConstant.imgFavouritePrimary,
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
