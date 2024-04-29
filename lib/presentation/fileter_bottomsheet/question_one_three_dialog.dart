// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/question_one_one_dialog/controller/question_one_one_controller.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';

class QuestionOneThreeDialog extends StatelessWidget {
  QuestionOneThreeDialog(this.controller, {Key? key}) : super(key: key);

  QuestionOneOneController controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadiusStyle.roundedBorder12,
      child: Container(
        width: 320.h,
        padding: EdgeInsets.all(24.h),
        decoration: AppDecoration.fillPrimary.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: CustomImageView(
                imagePath: ImageConstant.imgArrowRightOnerrorcontainer,
                height: 24.adaptSize,
                width: 24.adaptSize,
                alignment: Alignment.centerRight,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 86.h),
              padding: EdgeInsets.all(10.h),
              decoration: AppDecoration.fillRed.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder50,
              ),
              child: Container(
                height: 80.adaptSize,
                width: 80.adaptSize,
                padding: EdgeInsets.symmetric(
                  horizontal: 22.h,
                  vertical: 17.v,
                ),
                decoration: AppDecoration.fillRedA.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder40,
                ),
                child: CustomImageView(
                  imagePath: ImageConstant.imgMenu,
                  height: 44.v,
                  width: 36.h,
                  alignment: Alignment.center,
                ),
              ),
            ),
            SizedBox(height: 23.v),
            Text(
              "lbl_00_00".tr,
              style: theme.textTheme.headlineSmall,
            ),
            SizedBox(height: 15.v),
            CustomElevatedButton(
              text: "lbl_start_recording".tr,
            ),
            SizedBox(height: 12.v),
          ],
        ),
      ),
    );
  }
}
