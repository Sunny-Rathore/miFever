// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';

import '../question_three_screen/controller/question_three_controller.dart';

class QuestionThreeDialog extends StatelessWidget {
  QuestionThreeDialog(
    this.age, {
    Key? key,
  }) : super(key: key);
  int age;
  final questionThreeController = Get.find<QuestionThreeController>();
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadiusStyle.circleBorder50,
      child: Container(
        width: 320.h,
        padding: EdgeInsets.all(24.h),
        decoration: AppDecoration.fillPrimary.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                  horizontal: 19.h,
                  vertical: 16.v,
                ),
                decoration: AppDecoration.fillRedA.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder40,
                ),
                child: CustomImageView(
                  imagePath: ImageConstant.imgElements,
                  height: 47.v,
                  width: 40.h,
                  alignment: Alignment.center,
                ),
              ),
            ),
            SizedBox(height: 26.v),
            Text(
              "lbl_your_age_is_22".tr + " $age",
              style: theme.textTheme.headlineSmall,
            ),
            SizedBox(height: 20.v),
            CustomElevatedButton(
              onPressed: () {
                questionThreeController.previousSelected.value =
                    questionThreeController.selectedDate.value;
                Get.back();
              },
              text: "lbl_yes_right".tr,
            ),
            SizedBox(height: 22.v),
            GestureDetector(
              onTap: () {
                questionThreeController.selectedDate.value =
                    questionThreeController.previousSelected.value;
                Get.back();
              },
              child: Text(
                "lbl_no".tr,
                style: CustomTextStyles.titleMediumRedA200,
              ),
            ),
            SizedBox(height: 9.v),
          ],
        ),
      ),
    );
  }
}
