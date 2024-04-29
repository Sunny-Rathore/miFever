import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:mifever/core/app_export.dart';
import 'controller/themometer_controller.dart';

// ignore_for_file: must_be_immutable
class ThemometerScreen extends GetWidget<ThemometerController> {
  const ThemometerScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: 595.h,
          child: Column(
            children: [
              _buildCalendar(),
              SizedBox(height: 36.v),
              Padding(
                padding: EdgeInsets.only(
                  left: 92.h,
                  right: 81.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgGroup63Primary,
                      height: 32.v,
                      width: 16.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 4.h,
                        top: 2.v,
                        bottom: 12.v,
                      ),
                      child: Text(
                        "lbl_0".tr,
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                    Spacer(
                      flex: 20,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgGroup63Red5032x16,
                      height: 32.v,
                      width: 16.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 4.h,
                        top: 2.v,
                        bottom: 12.v,
                      ),
                      child: Text(
                        "lbl_10".tr,
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                    Spacer(
                      flex: 20,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgGroup63Red50,
                      height: 32.v,
                      width: 16.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 4.h,
                        top: 2.v,
                        bottom: 12.v,
                      ),
                      child: Text(
                        "lbl_202".tr,
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                    Spacer(
                      flex: 20,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgGroup63Red50,
                      height: 32.v,
                      width: 16.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 4.h,
                        top: 2.v,
                        bottom: 12.v,
                      ),
                      child: Text(
                        "lbl_302".tr,
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                    Spacer(
                      flex: 20,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgGroup63Red50,
                      height: 32.v,
                      width: 16.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 4.h,
                        top: 2.v,
                        bottom: 12.v,
                      ),
                      child: Text(
                        "lbl_40".tr,
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                    Spacer(
                      flex: 20,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgGroup63Red50,
                      height: 32.v,
                      width: 16.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 4.h,
                        top: 2.v,
                        bottom: 12.v,
                      ),
                      child: Text(
                        "lbl_502".tr,
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 31.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 92.h,
                    right: 140.h,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgGroup63Red50,
                        height: 32.v,
                        width: 16.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 4.h,
                          top: 2.v,
                          bottom: 13.v,
                        ),
                        child: Text(
                          "lbl_60".tr,
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                      Spacer(
                        flex: 25,
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgGroup63Red50,
                        height: 32.v,
                        width: 16.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 4.h,
                          top: 2.v,
                          bottom: 13.v,
                        ),
                        child: Text(
                          "lbl_70".tr,
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                      Spacer(
                        flex: 25,
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgGroup63Red50,
                        height: 32.v,
                        width: 16.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 4.h,
                          top: 2.v,
                          bottom: 13.v,
                        ),
                        child: Text(
                          "lbl_80".tr,
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                      Spacer(
                        flex: 25,
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgGroup63Red50,
                        height: 32.v,
                        width: 16.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 4.h,
                          top: 2.v,
                          bottom: 13.v,
                        ),
                        child: Text(
                          "lbl_90".tr,
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                      Spacer(
                        flex: 25,
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgGroup175986,
                        height: 33.v,
                        width: 19.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 4.h,
                          top: 5.v,
                          bottom: 10.v,
                        ),
                        child: Text(
                          "lbl_100".tr,
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildCalendar() {
    return Obx(
      () => SizedBox(
        height: 220.v,
        width: 594.h,
        child: CalendarDatePicker2(
          config: CalendarDatePicker2Config(
            calendarType: CalendarDatePicker2Type.single,
            firstDate: DateTime(DateTime.now().year - 5),
            lastDate: DateTime(DateTime.now().year + 5),
            firstDayOfWeek: 0,
          ),
          value: controller.selectedDatesFromCalendar1.value,
          onValueChanged: (dates) {
            controller.selectedDatesFromCalendar1.value = dates;
          },
        ),
      ),
    );
  }
}
