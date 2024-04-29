// ignore_for_file: must_be_immutable

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/custom_drop_down.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';

import 'controller/question_three_three_controller.dart';

class QuestionThreeThreeDialog extends StatelessWidget {
  QuestionThreeThreeDialog(this.controller, {Key? key}) : super(key: key);

  QuestionThreeThreeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 301.h,
      padding: EdgeInsets.symmetric(
        horizontal: 11.h,
        vertical: 16.v,
      ),
      decoration: AppDecoration.fillPrimary.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.h),
            padding: EdgeInsets.symmetric(
              horizontal: 9.h,
              vertical: 8.v,
            ),
            decoration: AppDecoration.fillPrimary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomDropDown(
                  width: 79.h,
                  icon: Container(
                    margin: EdgeInsets.only(left: 4.h),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgCheckmarkGray60004,
                      height: 18.adaptSize,
                      width: 18.adaptSize,
                    ),
                  ),
                  hintText: "lbl_jul_2022".tr,
                  items: controller
                      .questionThreeThreeModelObj.value.dropdownItemList.value,
                  onChanged: (value) {
                    controller.onSelected(value);
                  },
                ),
                Spacer(),
                CustomImageView(
                  imagePath: ImageConstant.imgArrowLeft,
                  height: 18.adaptSize,
                  width: 18.adaptSize,
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgArrowRight,
                  height: 18.adaptSize,
                  width: 18.adaptSize,
                  margin: EdgeInsets.only(left: 8.h),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.v),
          Obx(
            () => SizedBox(
              height: 220.v,
              width: 274.h,
              child: CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  calendarType: CalendarDatePicker2Type.multi,
                  firstDate: DateTime(DateTime.now().year - 5),
                  lastDate: DateTime(DateTime.now().year + 5),
                  selectedDayHighlightColor: Color(0XFFFFFFFF),
                  firstDayOfWeek: 0,
                  weekdayLabelTextStyle: TextStyle(
                    color: appTheme.gray60004,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w500,
                  ),
                  selectedDayTextStyle: TextStyle(
                    color: Color(0XFF767676),
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w500,
                  ),
                  disabledDayTextStyle: TextStyle(
                    color: appTheme.gray60004,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w500,
                  ),
                  weekdayLabels: ["S", "M", "T", "W", "T", "F", "S"],
                ),
                value: controller.selectedDatesFromCalendar1.value,
                onValueChanged: (dates) {
                  controller.selectedDatesFromCalendar1.value = dates;
                },
              ),
            ),
          ),
          SizedBox(height: 15.v),
          Padding(
            padding: EdgeInsets.only(
              left: 44.h,
              right: 4.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 10.v,
                    bottom: 9.v,
                  ),
                  child: Text(
                    "lbl_cancel".tr,
                    style: CustomTextStyles.titleMediumRedA200,
                  ),
                ),
                CustomElevatedButton(
                  width: 134.h,
                  text: "lbl_add".tr,
                  margin: EdgeInsets.only(left: 41.h),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
