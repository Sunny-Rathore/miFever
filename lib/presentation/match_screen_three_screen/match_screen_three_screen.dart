import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/custom_outlined_button.dart';

import 'controller/match_screen_three_controller.dart';

// ignore_for_file: must_be_immutable
class MatchScreenThreeScreen extends GetWidget<MatchScreenThreeController> {
  const MatchScreenThreeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.5, 0),
              end: Alignment(0.5, 1),
              colors: [
                appTheme.redA200,
                theme.colorScheme.onPrimary.withOpacity(1),
              ],
            ),
          ),
          child: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Opacity(
                opacity: 0.5,
                child: SizedBox(
                  height: 768.v,
                  width: double.maxFinite,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgLayer22,
                        height: 472.v,
                        width: 375.h,
                        alignment: Alignment.topCenter,
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgLayer23,
                        height: 562.v,
                        width: 375.h,
                        alignment: Alignment.bottomCenter,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.h,
                            vertical: 34.v,
                          ),
                          decoration: AppDecoration.gradientRedAToOnPrimary,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 180.v),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 124.h),
                                padding: EdgeInsets.all(8.h),
                                decoration: AppDecoration.fillPrimary.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder43,
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.h,
                                    vertical: 6.v,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusStyle.circleBorder36,
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(left: 1.h),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.h,
                                      vertical: 13.v,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder29,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "lbl_90".tr,
                                          style: theme.textTheme.labelLarge,
                                        ),
                                        SizedBox(height: 3.v),
                                        CustomImageView(
                                          imagePath: ImageConstant.imgGroup79,
                                          height: 40.v,
                                          width: 19.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 9.v),
                              Container(
                                width: 290.h,
                                margin: EdgeInsets.symmetric(horizontal: 22.h),
                                child: Text(
                                  "msg_great_your_thermometer".tr,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: CustomTextStyles.titleMediumExtraBold
                                      .copyWith(
                                    height: 1.50,
                                  ),
                                ),
                              ),
                              SizedBox(height: 6.v),
                              Container(
                                width: 268.h,
                                margin: EdgeInsets.only(
                                  left: 34.h,
                                  right: 31.h,
                                ),
                                child: Text(
                                  "msg_please_wait_for".tr,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: CustomTextStyles.bodyMediumGray200
                                      .copyWith(
                                    height: 1.43,
                                  ),
                                ),
                              ),
                              SizedBox(height: 21.v),
                              CustomOutlinedButton(
                                height: 50.v,
                                text: "lbl_00_10s".tr,
                                buttonStyle:
                                    CustomButtonStyles.outlinePrimaryTL25,
                                buttonTextStyle: theme.textTheme.titleMedium!,
                              ),
                              SizedBox(height: 202.v),
                              Text(
                                "lbl_keep_scrolling".tr,
                                style: theme.textTheme.titleMedium,
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
        ),
      ),
    );
  }
}
