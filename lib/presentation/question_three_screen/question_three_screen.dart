import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';

import '../question_three_dialog/question_three_dialog.dart';
import 'controller/question_three_controller.dart';

// ignore_for_file: must_be_immutable
class QuestionThreeScreen extends GetWidget<QuestionThreeController> {
  const QuestionThreeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 20.h,
            vertical: 11.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 8.v,
                width: 335.h,
                decoration: BoxDecoration(
                  color: appTheme.red50,
                  borderRadius: BorderRadius.circular(
                    4.h,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    4.h,
                  ),
                  child: LinearProgressIndicator(
                    value: 0.43,
                    color: appTheme.redA200,
                    backgroundColor: appTheme.red50,
                  ),
                ),
              ),
              SizedBox(height: 26.v),
              Text(
                "msg_when_were_you_born".tr,
                style: theme.textTheme.headlineSmall,
              ),
              SizedBox(height: 20.v),
              _buildFrameThirteen(),
              SizedBox(height: 5.v),
            ],
          ),
        ),
        bottomNavigationBar: _buildContinueButton(),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingImage(
        onTap: () {
          Get.back();
        },
        imagePath: ImageConstant.imgElementsGray900,
        margin: EdgeInsets.fromLTRB(25.h, 21.v, 330.h, 22.v),
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameThirteen() {
    return GestureDetector(
      onTap: () {
        _showDatePicker(Get.context!);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 11.h,
          vertical: 9.v,
        ),
        decoration: AppDecoration.outlineGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 1.v,
                bottom: 1.v,
              ),
              child: Obx(
                () => Text(
                  controller.selectedDate.value,
                  // "msg_select_your_birth".tr,
                  style: theme.textTheme.bodySmall!.copyWith(
                      color: appTheme.gray900, fontWeight: FontWeight.bold),

                  //CustomTextStyles.bodySmallPrimary_1,
                ),
              ),
            ),
            CustomImageView(
              imagePath: ImageConstant.imgCalendar03,
              height: 24.adaptSize,
              width: 24.adaptSize,
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildContinueButton() {
    return CustomElevatedButton(
      text: "lbl_continue".tr,
      margin: EdgeInsets.only(
        left: 20.h,
        right: 20.h,
        bottom: 36.v,
      ),
      rightIcon: Container(
        margin: EdgeInsets.only(left: 4.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgArrowleft02sharp,
          height: 24.adaptSize,
          width: 24.adaptSize,
        ),
      ),
      onPressed: _onTapContinue,
    );
  }

  void _onTapContinue() {
    Get.toNamed(AppRoutes.questionFourScreen);
  }

  /// Show calendar in pop up dialog for selecting date range for calendar event.
  void _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: SizeUtils.width,
            height: SizeUtils.height * 0.45,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Theme(
                  data: ThemeData(indicatorColor: appTheme.redA200),
                  child: CalendarDatePicker(
                    initialDate:
                        DateTime.now().subtract(Duration(days: 18 * 366)),
                    firstDate:
                        DateTime.now().subtract(Duration(days: 60 * 366)),
                    lastDate: DateTime.now().subtract(Duration(days: 18 * 366)),
                    onDateChanged: (DateTime date) {
                      if (date != controller.initialDateTime.value) {
                        controller.initialDateTime.value = date;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.only(right: 20.v),
                  shape: RoundedRectangleBorder()),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: appTheme.redA200, fontSize: 15.fSize),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  minimumSize: Size(140.v, 50.v),
                  backgroundColor: appTheme.redA200),
              onPressed: () {
                controller.selectedDate.value =
                    controller.initialDateTime.value.format();
                //'${controller.initialDateTime.value.day}/${controller.initialDateTime.value.month}/${controller.initialDateTime.value.year}';
                Navigator.of(context).pop();
                Get.dialog(Center(
                  child: QuestionThreeDialog(
                      calculateAgeFromString(controller.selectedDate.value)),
                ));
              },
              child: Text(
                'Add',
              ),
            ),
          ],
        );
      },
    );
  }
}
