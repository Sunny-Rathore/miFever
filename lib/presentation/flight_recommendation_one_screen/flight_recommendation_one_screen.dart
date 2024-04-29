import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_icon_button.dart';

import '../../core/utils/progress_dialog_utils.dart';
import '../../widgets/custom_text_form_field.dart';
import '../flight_recommendation_screen/controller/flight_recommendation_controller.dart';

// ignore_for_file: must_be_immutable
class FlightRecommendationOneScreen
    extends GetWidget<FlightRecommendationController> {
  const FlightRecommendationOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          height: 712.v,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 24.v),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgFrame427320779,
                height: 212.v,
                width: 375.h,
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 90.v),
              ),
              _buildFrame2(),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Get.back();
        },
        imagePath: ImageConstant.imgArrowLeft02SharpGray90024x24,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 16.v,
          bottom: 16.v,
        ),
      ),
      title: AppbarSubtitle(
        text: "msg_flight_recommendations".tr,
        margin: EdgeInsets.only(left: 12.h),
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildFrame2() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.h),
        padding: EdgeInsets.all(16.h),
        decoration: AppDecoration.outlineGray900.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder9,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 100.v,
              width: 303.h,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 56.v),
                    child: _buildFrame(
                        skyId: controller.pickLocationSkyId,
                        entityId: controller.pickLocationEntityId,
                        locationSix: ImageConstant.imgSettingsRedA200,
                        hint: "lbl_jakarta".tr,
                        textEditingController:
                            controller.pickLocationController),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 56.v),
                    child: _buildFrame(
                      skyId: controller.dropLocationSkyId,
                      entityId: controller.dropLocationEntityId,
                      locationSix: ImageConstant.imgLocation06,
                      hint: "lbl_tokyo".tr,
                      textEditingController:
                          controller.dropLocationToController,
                      subTitle: controller.subTitle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 12.h),
                    child: CustomIconButton(
                      height: 30.adaptSize,
                      width: 30.adaptSize,
                      padding: EdgeInsets.all(6.h),
                      decoration: IconButtonStyleHelper.outlinePrimaryTL15,
                      alignment: Alignment.centerRight,
                      child: CustomImageView(
                        onTap: () {
                          String drop =
                              controller.dropLocationToController.text;
                          String pick = controller.pickLocationController.text;
                          controller.dropLocationToController.text = pick;
                          controller.pickLocationController.text = drop;
                          String dropId = controller.dropLocationEntityId.value;
                          String pickId = controller.pickLocationEntityId.value;
                          controller.dropLocationEntityId.value = pickId;
                          controller.pickLocationEntityId.value = dropId;
                        },
                        imagePath: ImageConstant.imgClock,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.v),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 11.h,
                vertical: 10.v,
              ),
              decoration: AppDecoration.outlineGray.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgCalendar03,
                    height: 20.adaptSize,
                    width: 20.adaptSize,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.h),
                    child: Obx(
                      () => InkWell(
                        onTap: () {
                          _showDatePicker(Get.context!);
                        },
                        child: Text(
                          controller.selectedDate.value,
                          //"lbl_25_feb_2024".tr,
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      _onTapTomorrow();
                    },
                    child: Text(
                      "lbl_tomorrow".tr,
                      style: CustomTextStyles.titleSmallRedA200,
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 8.h),
                  //   child: Text(
                  //     "lbl_27_feb".tr,
                  //     style: CustomTextStyles.titleSmallRedA200,
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 30.v),
            CustomElevatedButton(
              text: "lbl_search_flights".tr,
              onPressed: () async {
                if (controller.dropLocationToController.text.isNotEmpty &&
                    controller.pickLocationController.text.isNotEmpty &&
                    controller.selectedDate.value != 'Select Date') {
                  ProgressDialogUtils.showProgressDialog();
                  await controller.getFlight();
                  ProgressDialogUtils.hideProgressDialog();
                  Get.toNamed(AppRoutes.flightRecommendationScreen);
                } else {}
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildFrame({
    required String locationSix,
    required String hint,
    required TextEditingController textEditingController,
    required RxString entityId,
    required RxString skyId,
    RxString? subTitle,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 11.h,
        vertical: 9.v,
      ),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Row(
        children: [
          CustomImageView(
            imagePath: locationSix,
            height: 20.adaptSize,
            width: 20.adaptSize,
            margin: EdgeInsets.symmetric(vertical: 1.v),
          ),
          SizedBox(width: 5.v),
          Expanded(
            child: TextFormField(
              onTap: () {
                showDialog(
                  context: Get.context!,
                  builder: (context) {
                    return Material(
                      child: Padding(
                        padding: EdgeInsets.all(8.0.v),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextFormField(
                              //controller: controller.emailController,
                              hintText: "Search".tr,
                              hintStyle: CustomTextStyles.bodySmall12,
                              textInputType: TextInputType.emailAddress,
                              prefix: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      12.h, 12.v, 8.h, 12.v),
                                  child: Icon(Icons.search)),
                              prefixConstraints: BoxConstraints(
                                maxHeight: 44.v,
                              ),
                              validator: (value) {
                                return null;
                              },
                              onChanged: (val) {
                                print('val:$val');
                                if (val.length > 2) {
                                  Future.delayed(Duration(seconds: 2), () {
                                    controller.showFlightSuggestion(val);
                                  });
                                }
                              },
                            ),
                            Obx(
                              () => ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.suggestions.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      textEditingController.text = controller
                                          .suggestions[index]
                                          .presentation
                                          .title;
                                      entityId.value = controller
                                          .suggestions[index]
                                          .navigation
                                          .entityId;
                                      skyId.value = controller
                                          .suggestions[index]
                                          .navigation
                                          .relevantFlightParams
                                          .skyId;
                                      if (subTitle != null) {
                                        subTitle.value = controller
                                            .suggestions[index]
                                            .presentation
                                            .subtitle;
                                        print(controller.subTitle.value);
                                      }
                                      controller.suggestions.clear();
                                      Get.back();
                                    },
                                    title: Text(controller
                                        .suggestions[index].presentation.title),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              controller: textEditingController,
              cursorColor: appTheme.redA200,
              readOnly: true,
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 12.fSize),
                  border: InputBorder.none,
                  hintText: hint),
            ),
          ),
        ],
      ),
    );
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
                    initialDate: controller.initialDateTime.value,
                    firstDate: DateTime.now().add(Duration(days: 1)),
                    lastDate: DateTime(2030),
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
                String formattedDate = DateFormat('yyyy-MM-dd')
                    .format(controller.initialDateTime.value);
                controller.selectedDate.value = formattedDate;
                Navigator.of(context).pop();
              },
              child: Text(
                'Add',
              ),
            ),
          ],
        );
      },
    );

    if (picked != null && picked != controller.initialDateTime.value) {
      controller.initialDateTime.value = picked;
      controller.selectedDate.value =
          '${picked.year}-${picked.month}-${picked.day}';
    }
  }

  _onTapTomorrow() {
    DateTime todayDate = DateTime.now().add(Duration(days: 1));
    String formattedDate = DateFormat('yyyy-MM-dd').format(todayDate);
    controller.selectedDate.value = formattedDate;
  }
}
