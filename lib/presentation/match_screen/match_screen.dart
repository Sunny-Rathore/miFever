import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/custom_icon_button.dart';

import 'controller/match_controller.dart';

// ignore_for_file: must_be_immutable
class MatchScreen extends GetWidget<MatchController> {
  const MatchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: 768.v,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgRectangle17844768x375,
                height: 768.v,
                width: 375.h,
                alignment: Alignment.center,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 768.v,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 57.h,
                    vertical: 60.v,
                  ),
                  decoration: AppDecoration.fillGray,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgArrowUp01Sharp,
                        height: 40.adaptSize,
                        width: 40.adaptSize,
                        alignment: Alignment.bottomRight,
                        margin: EdgeInsets.only(
                          right: 21.h,
                          bottom: 93.v,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 35.v,
                            right: 1.h,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgEllipse2005,
                                height: 90.adaptSize,
                                width: 90.adaptSize,
                                radius: BorderRadius.circular(
                                  45.h,
                                ),
                              ),
                              SizedBox(height: 27.v),
                              Text(
                                "lbl_tom_cooper".tr,
                                style: CustomTextStyles.titleLargeExtraBold,
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomIconButton(
                                    height: 80.adaptSize,
                                    width: 80.adaptSize,
                                    padding: EdgeInsets.all(22.h),
                                    decoration:
                                        IconButtonStyleHelper.fillPrimaryTL40,
                                    child: CustomImageView(
                                      imagePath: ImageConstant.imgCloseRedA200,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 100.h),
                                    child: CustomIconButton(
                                      height: 80.adaptSize,
                                      width: 80.adaptSize,
                                      padding: EdgeInsets.all(22.h),
                                      decoration:
                                          IconButtonStyleHelper.fillRedATL40,
                                      child: CustomImageView(
                                        imagePath: ImageConstant.imgUpload,
                                      ),
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
}
