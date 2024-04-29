import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_text_form_field.dart';

import '../../data/sevices/google_places_services.dart';
import 'controller/create_travel_plan_controller.dart';

// ignore_for_file: must_be_immutable
class CreateTravelPlanScreen extends GetWidget<CreateTravelPlanController> {
  CreateTravelPlanScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.h,
                  vertical: 23.v,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "msg_travel_plan_name".tr,
                      style: CustomTextStyles.titleSmallGray60004,
                    ),
                    SizedBox(height: 8.v),
                    _buildName(),
                    SizedBox(height: 15.v),
                    Text(
                      "lbl_start_date".tr,
                      style: CustomTextStyles.titleSmallGray60004,
                    ),
                    SizedBox(height: 8.v),
                    _buildFrameFourteen(
                      selectYourTravel: controller.startDate,
                    ),
                    SizedBox(height: 16.v),
                    Text(
                      "lbl_end_date".tr,
                      style: CustomTextStyles.titleSmallGray60004,
                    ),
                    SizedBox(height: 7.v),
                    _buildFrameFourteen(
                      selectYourTravel: controller.endDate,
                    ),
                    SizedBox(height: 25.v),
                    Text(
                      "lbl_location".tr,
                      style: CustomTextStyles.titleMediumGray900,
                    ),
                    SizedBox(height: 10.v),
                    _buildCountry(),
                    SizedBox(height: 13.v),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildCreate(),
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
        text: "msg_create_travel_plan".tr,
        margin: EdgeInsets.only(left: 12.h),
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildName() {
    return CustomTextFormField(
      controller: controller.nameController,
      hintText: "msg_enter_travel_plan".tr,
      hintStyle: theme.textTheme.bodySmall!,
      validator: (value) {
        if (value!.isEmpty) {
          return "err_msg_please_enter_plan_name".tr;
        }
        return null;
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 13.v,
      ),
    );
  }

  /// Section Widget
  Widget _buildCountry() {
    return CustomTextFormField(
      controller: controller.countryController,
      hintText: "lbl_enter_location".tr,
      hintStyle: theme.textTheme.bodySmall!,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(12.h, 12.v, 8.h, 12.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgLocation01RedA200,
          height: 20.adaptSize,
          width: 20.adaptSize,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 44.v,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "err_msg_please_enter_location".tr;
        }
        return null;
      },
      onTap: () async {
        await GooglePlacesApiServices.placeSelectAPI(
                Get.context!, controller.countryController.text)
            .then((value) {
          controller.countryController.text =
              value!.result.formattedAddress.toString();
          controller.locationLatLong.value = GeoPoint(
            value.result.geometry!.location.lat,
            value.result.geometry!.location.lng,
          );
        });
      },
    );
  }

  /// Section Widget
  Widget _buildCreate() {
    return CustomElevatedButton(
      text: "lbl_create".tr,
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
      onPressed: onTapCreate,
    );
  }

  /// Common widget
  Widget _buildFrameFourteen({
    required Rx<DateTime> selectYourTravel,
  }) {
    return GestureDetector(
      onTap: () {
        _showDatePicker(Get.context!, selectYourTravel);
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
                top: 5.v,
                bottom: 1.v,
              ),
              child: Obx(
                () => Text(
                  selectYourTravel.value.format(),
                  style: theme.textTheme.bodySmall!.copyWith(
                      color: appTheme.gray900, fontWeight: FontWeight.bold),
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

  /// Show calendar in pop up dialog for selecting date range for calendar event.
  void _showDatePicker(BuildContext context, Rx<DateTime> date) async {
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
                date.value = controller.initialDateTime.value;
                // '${controller.initialDateTime.value.day}/${controller.initialDateTime.value.month}/${controller.initialDateTime.value.year}';
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

    // if (picked != null && picked != controller.initialDateTime.value) {
    //   controller.initialDateTime.value = picked;
    //   date.value = picked;
    //   //'${picked.day}/${picked.month}/${picked.year}';
    // }
  }

  onTapCreate() {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      if (controller.endDate.value.isBefore(controller.startDate.value)) {
        Fluttertoast.showToast(msg: 'lbl_end_date_must'.tr);
      } else {
        controller.addPlan();
      }
    }
  }
}
