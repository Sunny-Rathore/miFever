import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/custom_outlined_button.dart';

import 'controller/match_screen_one_controller.dart';

// ignore_for_file: must_be_immutable
class MatchScreenOneScreen extends GetWidget<MatchScreenOneController> {
  const MatchScreenOneScreen({Key? key}) : super(key: key);

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
                      child: Opacity(
                        opacity: 0.95,
                        child: Container(
                          width: SizeUtils.width,
                          height: SizeUtils.height,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.h,
                            vertical: 34.v,
                          ),
                          decoration: AppDecoration.gradientRedAToOnPrimary,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(height: 64.v),
                              Container(
                                padding: EdgeInsets.all(15.h),
                                decoration: BoxDecoration(
                                    color: Colors.white38,
                                    borderRadius: BorderRadius.circular(120)),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(120)),
                                  // elevation: 6,
                                  child: SizedBox(
                                    height: 200.h,
                                    width: 100.v,
                                    child: Lottie.asset(
                                      'assets/json/Mi-FullCrack-V3.json',
                                      repeat: false,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 9.v),
                              Column(
                                children: [
                                  Container(
                                    width: 290.h,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 22.h),
                                    child: Text(
                                      "msg_great_your_thermometer".tr,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: CustomTextStyles
                                          .titleMediumExtraBold
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
                                ],
                              ),
                              SizedBox(height: 33.v),
                              Obx(
                                () => CustomOutlinedButton(
                                  height: 50.v,
                                  text:
                                      "00:${controller.elapsedSeconds.value == 10 ? controller.elapsedSeconds.value : "0" + controller.elapsedSeconds.value.toString()}",
                                  //"lbl_00_01s".tr,
                                  buttonStyle:
                                      CustomButtonStyles.outlinePrimaryTL25,
                                  buttonTextStyle: theme.textTheme.titleMedium!,
                                ),
                              ),
                              SizedBox(height: 26.v),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Text(
                                  "lbl_keep_scrolling".tr,
                                  style: theme.textTheme.titleMedium,
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
      ),
    );
  }
}
