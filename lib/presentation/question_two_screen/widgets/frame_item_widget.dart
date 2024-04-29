import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import '../controller/question_two_controller.dart';
import '../models/frame_item_model.dart';

// ignore: must_be_immutable
class FrameItemWidget extends StatelessWidget {
  FrameItemWidget(
    this.frameItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  FrameItemModel frameItemModelObj;

  var controller = Get.find<QuestionTwoController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () {
          controller.selectedGender.value = frameItemModelObj.genderText!.value;
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15.h,
            vertical: 11.v,
          ),
          decoration: isSelected()
              ? AppDecoration.outlineRedA.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder4,
                  border: Border.all(
                    color: appTheme.redA200,
                    width: 4.h,
                  ),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(4.h),
                  border: Border.all(
                    color: appTheme.gray200,
                    width: 1.h,
                  ),
                ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                  frameItemModelObj.genderText!.value,
                  style: isSelected()
                      ? theme.textTheme.titleMedium
                      : CustomTextStyles.titleMediumGray900,
                ),
              ),
              Obx(
                () => isSelected()
                    ? CustomImageView(
                        imagePath: frameItemModelObj.genderImage!.value,
                        height: 20.adaptSize,
                        width: 20.adaptSize,
                      )
                    : Radio(value: false, groupValue: true, onChanged: null),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isSelected() {
    if (controller.selectedGender.value ==
        frameItemModelObj.genderText!.value) {
      return true;
    }
    return false;
  }
}
