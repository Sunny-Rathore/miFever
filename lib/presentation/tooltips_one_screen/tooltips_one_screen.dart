import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/custom_icon_button.dart';
import 'package:mifever/widgets/custom_outlined_button.dart';

import 'controller/tooltips_one_controller.dart';

// ignore_for_file: must_be_immutable
class TooltipsOneScreen extends GetWidget<TooltipsOneController> {
  const TooltipsOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: 704.v,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              _buildFrame(),
              _buildFrame1(),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 482.v,
                  width: 335.h,
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgRectangle17844482x335,
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  decoration: AppDecoration.fillBlack,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomOutlinedButton(
                        width: 100.h,
                        text: "lbl_next".tr,
                        rightIcon: Container(
                          margin: EdgeInsets.only(left: 4.h),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgArrowleft02sharp,
                            height: 24.adaptSize,
                            width: 24.adaptSize,
                          ),
                        ),
                        buttonStyle: CustomButtonStyles.outlinePrimary,
                        buttonTextStyle: CustomTextStyles.titleSmallPrimary,
                      ),
                      Spacer(
                        flex: 33,
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgRotateLeft03,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 55.h),
                      ),
                      SizedBox(height: 8.v),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "msg_swipe_left_to_dislike".tr,
                          style: CustomTextStyles.titleSmallPrimary,
                        ),
                      ),
                      Spacer(
                        flex: 21,
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgTap06,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        margin: EdgeInsets.only(right: 53.h),
                      ),
                      SizedBox(height: 6.v),
                      Text(
                        "msg_double_click_to".tr,
                        style: CustomTextStyles.titleSmallPrimary,
                      ),
                      Spacer(
                        flex: 44,
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
  Widget _buildFrame() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(
          top: 490.v,
          bottom: 2.v,
        ),
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

  /// Section Widget
  Widget _buildFrame1() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.h, 22.v, 20.h, 650.v),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgGroup58,
              height: 31.v,
              width: 43.h,
            ),
            CustomImageView(
              imagePath: ImageConstant.imgFilterHorizontalGray60004,
              height: 30.adaptSize,
              width: 30.adaptSize,
            ),
          ],
        ),
      ),
    );
  }
}
