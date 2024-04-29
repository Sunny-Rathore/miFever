import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import '../controller/langauges_controller.dart';
import '../models/language_options_widgetModel.dart';

// ignore: must_be_immutable
class LanguageOptionsWidget extends StatelessWidget {
  LanguageOptionsWidget(this.languageOptionsWidgetModelObj, {Key? key})
      : super(key: key);

  LanguageOptionsWidgetModel languageOptionsWidgetModelObj;

  var controller = Get.find<LangaugesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () {
          controller.languageModel.value = languageOptionsWidgetModelObj;
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15.h,
            vertical: 9.v,
          ),
          decoration: isSelected(
            languageOptionsWidgetModelObj,
          )
              ? AppDecoration.outlineRedA.copyWith(
                  border: Border.all(
                    color: appTheme.redA200,
                    width: 3.h,
                  ),
                  borderRadius: BorderRadiusStyle.roundedBorder4,
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
              Padding(
                padding: EdgeInsets.only(top: 3.v),
                child: Obx(
                  () => Text(
                    languageOptionsWidgetModelObj.englishText!.value,
                    style: isSelected(
                      languageOptionsWidgetModelObj,
                    )
                        ? theme.textTheme.titleMedium
                        : CustomTextStyles.titleMediumGray900,
                  ),
                ),
              ),
              Obx(
                () => isSelected(languageOptionsWidgetModelObj)
                    ? CustomImageView(
                        imagePath: ImageConstant.imgCheckmarkPrimary,
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

  bool isSelected(LanguageOptionsWidgetModel language) {
    if (controller.languageModel.value == language) {
      return true;
    }
    return false;
  }
}
