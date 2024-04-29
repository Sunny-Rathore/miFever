// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import '../../data/sevices/google_places_services.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/filter_bottomsheet_controller.dart';

class FilterBottomsheet extends StatelessWidget {
  FilterBottomsheet({Key? key}) : super();

  final controller = Get.put(FilterBottomSheetController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 120.v),
      child: SingleChildScrollView(
        child: Material(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            margin: EdgeInsets.only(bottom: 74.v),
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 12.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 55.h,
                    child: Divider(
                      color: appTheme.gray200,
                    ),
                  ),
                ),
                SizedBox(height: 11.v),
                Text(
                  "lbl_filter".tr,
                  style: theme.textTheme.headlineSmall,
                ),
                SizedBox(height: 15.v),
                Text(
                  "lbl_location".tr,
                  style: theme.textTheme.titleSmall,
                ),
                //SizedBox(height: 13.v),
                // Text(
                //   "lbl_country".tr,
                //   style: CustomTextStyles.titleSmallGray60004,
                // ),
                SizedBox(height: 6.v),
                _buildCountryField(),
                // CustomDropDown(
                //   hintText: "lbl_select_country".tr,
                //   items: controller
                //       .activePlanModelObj.value.dropdownItemList.value,
                //   prefix: Container(
                //     margin: EdgeInsets.fromLTRB(12.h, 12.v, 8.h, 12.v),
                //     child: CustomImageView(
                //       imagePath: ImageConstant.imgLocation01RedA200,
                //       height: 20.adaptSize,
                //       width: 20.adaptSize,
                //     ),
                //   ),
                //   prefixConstraints: BoxConstraints(
                //     maxHeight: 44.v,
                //   ),
                //   onChanged: (value) {
                //     controller.onSelected(value);
                //   },
                // ),

                // SizedBox(height: 13.v),
                // Text(
                //   "lbl_city".tr,
                //   style: CustomTextStyles.titleSmallGray60004,
                // ),
                // SizedBox(height: 6.v),
                // CustomDropDown(
                //   hintText: "lbl_select_city".tr,
                //   items: controller
                //       .activePlanModelObj.value.dropdownItemList1.value,
                //   prefix: Container(
                //     margin: EdgeInsets.fromLTRB(12.h, 12.v, 8.h, 12.v),
                //     child: CustomImageView(
                //       imagePath: ImageConstant.imgLocation01RedA200,
                //       height: 20.adaptSize,
                //       width: 20.adaptSize,
                //     ),
                //   ),
                //   prefixConstraints: BoxConstraints(
                //     maxHeight: 44.v,
                //   ),
                //   onChanged: (value) {
                //     controller.onSelected1(value);
                //   },
                // ),
                SizedBox(height: 23.v),
                Text(
                  "lbl_distance".tr,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 8.v),
                SliderTheme(
                  data: SliderThemeData(
                      trackShape: RoundedRectSliderTrackShape(),
                      activeTrackColor: appTheme.redA200,
                      inactiveTrackColor: appTheme.red50,
                      thumbColor: theme.colorScheme.onPrimary.withOpacity(1),
                      thumbShape: RoundSliderThumbShape(),
                      valueIndicatorColor: appTheme.redA200,
                      valueIndicatorTextStyle: TextStyle(color: Colors.white)),
                  child: Obx(
                    () => Slider(
                      label: controller.distanceSliderValue.value
                              .round()
                              .toString() +
                          "Km",
                      value: controller.distanceSliderValue.value,
                      min: 0.0,
                      max: 200.0,
                      divisions: 200,
                      onChanged: (value) {
                        controller.distanceSliderValue.value = value;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 4.v),
                // Padding(
                //   padding: EdgeInsets.only(left: 67.h),
                //   child: Text(
                //     "lbl_15_km".tr,
                //     style: theme.textTheme.labelMedium,
                //   ),
                // ),
                //SizedBox(height: 25.v),
                Text(
                  "lbl_age".tr,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 6.v),
                _buildAgeFilter(),
                SizedBox(height: 24.v),
                Text(
                  "lbl_interested_in".tr,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 7.v),
                _buildInterestedInChipView(),
                SizedBox(height: 23.v),
                InkWell(
                  onTap: () {
                    controller.isExpanded.value = !controller.isExpanded.value;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.v),
                    width: 147.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff92163A)),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'lbl_advance_filters'.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff92163A)),
                        ),
                        Obx(
                          () => SizedBox(
                              width: !controller.isExpanded.value ? 4.h : 2.h),
                        ),
                        Obx(
                          () => CustomImageView(
                            imagePath: !controller.isExpanded.value
                                ? 'assets/images/arrow-down-01-sharp.svg'
                                : 'assets/images/Vector 6902.svg',
                            color: Color(0xff92163A),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.v),
                Obx(
                  () => Visibility(
                    visible: controller.isExpanded.value,
                    child: Column(
                      children: [
                        _buildHeight(),
                        SizedBox(height: 12.v),
                        _buildHoroscope(),
                        SizedBox(height: 12.v),
                        _buildSmokingStatus(),
                        SizedBox(height: 12.v),
                        _buildDrinkingStatus(),
                        SizedBox(height: 12.v),
                        _buildReligion(),
                        SizedBox(height: 12.v),
                        _buildMaritalStatus(),
                        SizedBox(height: 12.v),
                        _buildHaireColor(),
                        SizedBox(height: 12.v),
                        _buildChildren(),
                        SizedBox(height: 12.v),
                        _buildMusicPreference(),
                      ],
                    ),
                  ),
                ),

                // _buildTravelPlanRow(),
                // SizedBox(height: 12.v),
                // _buildTripDetailsColumn(),
                SizedBox(height: 152.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: controller.onCancelAll,
                        child: Text(
                          'Clear All',
                          style: TextStyle(
                            color: appTheme.redA200,
                            fontSize: 16.fSize,
                          ),
                        )),
                    SizedBox(width: 50.v),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(157.v, 55.v)),
                      onPressed: controller.onApply,
                      child: Text(
                        'Apply',
                        style: TextStyle(
                          fontSize: 16.fSize,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildChildren() => Container(
        width: 335.h,
        margin: EdgeInsets.only(right: 3.h),
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        decoration: AppDecoration.outlineGray200.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildChipOption(
                title: 'lbl_children'.tr,
                list: childrenStatus,
                selectedValue: controller.selectedChildrenStatus)
          ],
        ),
      );
  Container _buildMusicPreference() => Container(
        width: 335.h,
        margin: EdgeInsets.only(right: 3.h),
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        decoration: AppDecoration.outlineGray200.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(),
            _buildChipOption(
                title: 'lbl_musicpreference'.tr,
                list: musicPreference,
                selectedValue: controller.selectedMusicPreference)
          ],
        ),
      );
  Container _buildHaireColor() => Container(
        width: 335.h,
        margin: EdgeInsets.only(right: 3.h),
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        decoration: AppDecoration.outlineGray200.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildChipOption(
                title: 'lbl_naturalHairColor'.tr,
                list: hairColor,
                selectedValue: controller.selectedHairColor)
          ],
        ),
      );
  Container _buildSmokingStatus() => Container(
        width: 335.h,
        margin: EdgeInsets.only(right: 3.h),
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        decoration: AppDecoration.outlineGray200.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildChipOption(
                title: 'lbl_smokingOrNonSmoking'.tr,
                list: smokingStatus,
                selectedValue: controller.selectedSmokingStatus)
          ],
        ),
      );
  Container _buildDrinkingStatus() => Container(
        width: 335.h,
        margin: EdgeInsets.only(right: 3.h),
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        decoration: AppDecoration.outlineGray200.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildChipOption(
                title: 'lbl_drinkerOrNonDrinker'.tr,
                list: drinkingStatus,
                selectedValue: controller.selectedDrinkingStatus)
          ],
        ),
      );
  Container _buildReligion() => Container(
        width: 335.h,
        margin: EdgeInsets.only(right: 3.h),
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        decoration: AppDecoration.outlineGray200.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder4,
        ),
        child: ExpansionTile(
          iconColor: appTheme.gray600,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          collapsedIconColor: appTheme.gray600,
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: Colors.white)),
          title: Text('lbl_religion'.tr),
          children: [
            CustomTextFormField(
              controller: controller.religionController,
              textInputType: TextInputType.name,
              hintText: "lbl_religion".tr,
              hintStyle: CustomTextStyles.bodySmall12,
              contentPadding: EdgeInsets.all(12.h),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "err_msg_please_enter_religion".tr;
                }
                return null;
              },
            ),
            SizedBox(height: 10.v),
          ],
        ),
      );

  Container _buildMaritalStatus() => Container(
        width: 335.h,
        margin: EdgeInsets.only(right: 3.h),
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        decoration: AppDecoration.outlineGray200.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildChipOption(
                title: 'lbl_maritalStatus'.tr,
                list: martialStatus,
                selectedValue: controller.selectedMartialStatus)
          ],
        ),
      );
  Container _buildHoroscope() {
    return Container(
      width: 335.h,
      margin: EdgeInsets.only(right: 3.h),
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      decoration: AppDecoration.outlineGray200.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildChipOption(
              title: 'lbl_horoscope'.tr,
              list: honoscope,
              selectedValue: controller.selectedHoroscope)
        ],
      ),
    );
  }

  _buildHeight() {
    return Container(
      width: 335.h,
      margin: EdgeInsets.only(right: 3.h),
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      decoration: AppDecoration.outlineGray200.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: ExpansionTile(
        iconColor: appTheme.gray600,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        collapsedIconColor: appTheme.gray600,
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Colors.white)),
        title: Text('lbl_height'.tr),
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  controller.selectedHeightUnit.value = 'CM';
                },
                child: Obx(
                  () => Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: controller.selectedHeightUnit.value == 'CM'
                            ? appTheme.redA200
                            : appTheme.gray100,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        )),
                    child: Text(
                      'CM',
                      style: controller.selectedHeightUnit.value == 'CM'
                          ? CustomTextStyles.bodyMediumPrimary
                          : CustomTextStyles.bodyMediumGray900,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // convertCmToFeetAndInches(
                  //     double.parse(controller.heightController.text));
                  controller.selectedHeightUnit.value = 'Ft/In';
                },
                child: Obx(
                  () => Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: controller.selectedHeightUnit.value != 'CM'
                            ? appTheme.redA200
                            : appTheme.gray200,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        )),
                    child: Text(
                      'Ft/In',
                      style: controller.selectedHeightUnit.value != 'CM'
                          ? CustomTextStyles.bodyMediumPrimary
                          : CustomTextStyles.bodyMediumGray900,
                    ),
                  ),
                ),
              )
            ],
          ),
          _buildHeightFilter(),
        ],
      ),
    );
    // Container(
    // width: 335.h,
    // margin: EdgeInsets.only(right: 3.h),
    // padding: EdgeInsets.symmetric(horizontal: 15.h),
    // decoration: AppDecoration.outlineGray200.copyWith(
    //   borderRadius: BorderRadiusStyle.roundedBorder4,
    // ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text('lbl_height'.tr),
    //       SizedBox(height: 8.v),
    //       _buildHeightFilter(),
    //     ],
    //   ),
    //);
  }

  /// Section Widget
  Widget _buildAgeFilter() {
    return SizedBox(
      height: 44.v,
      width: 335.h,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          SliderTheme(
            data: SliderThemeData(
                trackShape: RoundedRectSliderTrackShape(),
                activeTrackColor: appTheme.redA200,
                inactiveTrackColor: appTheme.red50,
                thumbColor: theme.colorScheme.onPrimary.withOpacity(1),
                thumbShape: RoundSliderThumbShape(),
                valueIndicatorColor: appTheme.redA200,
                valueIndicatorTextStyle: TextStyle(color: Colors.white)),
            child: Obx(
              () => RangeSlider(
                values: controller.ageRange.value,
                min: 0.0,
                max: 100.0,
                divisions: 100,
                labels: RangeLabels(
                  '${controller.ageRange.value.start.round()}',
                  '${controller.ageRange.value.end.round()}',
                ),
                onChanged: (value) {
                  if (controller.isSoutheastAsianCountries.value) {
                    if (value.start >= 21.0 && value.end <= 60.0) {
                      controller.ageRange.value = value;
                    }
                  } else {
                    if (value.start >= 18.0 && value.end <= 60.0) {
                      controller.ageRange.value = value;
                    }
                  }
                },
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: Container(
          //     margin: EdgeInsets.only(left: 23.h),
          //     padding: EdgeInsets.symmetric(horizontal: 5.h),
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //       children: [
          //         Padding(
          //           padding: EdgeInsets.only(top: 28.v),
          //           child: Text(
          //             "lbl_18".tr,
          //             style: theme.textTheme.labelMedium,
          //           ),
          //         ),
          //         Padding(
          //           padding: EdgeInsets.only(
          //             left: 67.h,
          //             top: 27.v,
          //           ),
          //           child: Text(
          //             "lbl_24".tr,
          //             style: theme.textTheme.labelMedium,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildHeightFilter() {
    return SizedBox(
      height: 44.v,
      width: 335.h,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          SliderTheme(
            data: SliderThemeData(
                trackShape: RoundedRectSliderTrackShape(),
                activeTrackColor: appTheme.redA200,
                inactiveTrackColor: appTheme.red50,
                thumbColor: theme.colorScheme.onPrimary.withOpacity(1),
                thumbShape: RoundSliderThumbShape(),
                valueIndicatorColor: appTheme.redA200,
                valueIndicatorTextStyle: TextStyle(color: Colors.white)),
            child: Obx(
              () => RangeSlider(
                values: controller.selectedHeightUnit.value == 'CM'
                    ? controller.heightRange.value
                    : controller.heightRangeFeet.value,
                min: 0.0,
                max: controller.selectedHeightUnit.value == 'CM' ? 300.0 : 10.0,
                divisions:
                    controller.selectedHeightUnit.value == 'CM' ? 100 : 10,
                labels: controller.selectedHeightUnit.value == 'CM'
                    ? RangeLabels(
                        '${controller.heightRange.value.start.round()} cm',
                        '${controller.heightRange.value.end.round()} cm',
                      )
                    : RangeLabels(
                        '${controller.heightRangeFeet.value.start.round()} ft',
                        '${controller.heightRangeFeet.value.end.round()} ft',
                      ),
                onChanged: (value) {
                  if (controller.selectedHeightUnit.value == 'CM') {
                    print('${value.start} ,${value.end}');
                    if (value.start >= 100.0 && value.end <= 300.0) {
                      controller.heightRange.value = value;
                      controller.isHeightFilterApplied.value = true;
                    }
                  } else {
                    print('${value.start} ,${value.end}');
                    if (value.start >= 3.0 && value.end <= 10.0)
                      controller.heightRangeFeet.value = value;
                    controller.isHeightFilterApplied.value = true;
                  }
                },
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: Container(
          //     margin: EdgeInsets.only(left: 23.h),
          //     padding: EdgeInsets.symmetric(horizontal: 5.h),
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //       children: [
          //         Padding(
          //           padding: EdgeInsets.only(top: 28.v),
          //           child: Text(
          //             "lbl_18".tr,
          //             style: theme.textTheme.labelMedium,
          //           ),
          //         ),
          //         Padding(
          //           padding: EdgeInsets.only(
          //             left: 67.h,
          //             top: 27.v,
          //           ),
          //           child: Text(
          //             "lbl_24".tr,
          //             style: theme.textTheme.labelMedium,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildInterestedInChipView() {
    List interest = ['lbl_male'.tr, 'lbl_female'.tr, 'lbl_other'.tr];
    return Wrap(
      runSpacing: 6.v,
      spacing: 6.h,
      children: List<Widget>.generate(
        interest.length,
        (index) {
          return Obx(
            () => Theme(
              data: ThemeData(
                canvasColor: Colors.transparent,
              ),
              child: RawChip(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.h,
                  vertical: 8.v,
                ),
                showCheckmark: false,
                labelPadding: EdgeInsets.zero,
                label: Text(
                  interest[index],
                  style: TextStyle(
                    color: interest[index] == controller.selectedInterest.value
                        ? theme.colorScheme.primary
                        : appTheme.gray60004,
                    fontSize: 14.fSize,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                selected: interest[index] == controller.selectedInterest.value,
                backgroundColor: Colors.transparent,
                selectedColor: appTheme.redA200,
                shape: interest[index] == controller.selectedInterest.value
                    ? RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.circular(
                          18.h,
                        ),
                      )
                    : RoundedRectangleBorder(
                        side: BorderSide(
                          color: appTheme.gray200,
                          width: 1.h,
                        ),
                        borderRadius: BorderRadius.circular(
                          18.h,
                        ),
                      ),
                onSelected: (value) {
                  controller.selectedInterest.value = interest[index];
                },
              ),
            ),
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildTravelPlanRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "msg_your_travel_plan".tr,
          style: theme.textTheme.titleSmall,
        ),
        Text(
          "lbl_create_more".tr,
          style: CustomTextStyles.titleSmallRedA200,
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildTripDetailsColumn() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 7.h,
        vertical: 10.v,
      ),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 70.h,
                  margin: EdgeInsets.only(top: 1.v),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "lbl_us_trip".tr,
                        style: CustomTextStyles.titleSmallBold,
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgCheckmarkCircle02,
                        height: 16.adaptSize,
                        width: 16.adaptSize,
                        margin: EdgeInsets.only(bottom: 3.v),
                      ),
                    ],
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgMoreVerticalGray900,
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                ),
              ],
            ),
          ),
          SizedBox(height: 7.v),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgCalendar03,
                  height: 18.adaptSize,
                  width: 18.adaptSize,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.h),
                  child: Text(
                    "msg_24_feb_2024_12".tr,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 7.v),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgLocation01RedA2001,
                  height: 18.adaptSize,
                  width: 18.adaptSize,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.h),
                  child: Text(
                    "lbl_new_york_usa".tr,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCountryField() {
    return CustomTextFormField(
      readOnly: true,
      controller: controller.locationController,
      hintText: "msg_select_your_country".tr,
      hintStyle: CustomTextStyles.bodySmall12,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(12.h, 12.v, 8.h, 12.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgLocation01,
          height: 20.adaptSize,
          width: 20.adaptSize,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 44.v,
      ),
      textInputType: TextInputType.name,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "msg_select_your_country".tr;
        }
        return null;
      },
      onTap: () async {
        await GooglePlacesApiServices.placeSelectAPI(
                Get.context!, controller.locationController.text)
            .then((value) {
          controller.locationController.text =
              value!.result.formattedAddress.toString();

          controller.locationLatLong.value = GeoPoint(
            value.result.geometry!.location.lat,
            value.result.geometry!.location.lng,
          );
          value.result.addressComponents.forEach((component) {
            if (component.types.contains("country")) {
              // print("Country Name:${component.longName}");

              //controller.country.value = '${component.longName}';
            }
          });
        });
      },
    );
  }

  Widget _buildChipOption(
      {required String title,
      required List list,
      required RxString selectedValue}) {
    return ExpansionTile(
      iconColor: appTheme.gray600,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      collapsedIconColor: appTheme.gray600,
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: Colors.white)),
      title: Text(title),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            runAlignment: WrapAlignment.start,
            alignment: WrapAlignment.start,
            //runSpacing: 6.v,
            spacing: 6.h,
            children: List<Widget>.generate(
              list.length,
              (index) {
                return Obx(
                  () => Theme(
                    data: ThemeData(
                      canvasColor: Colors.transparent,
                    ),
                    child: RawChip(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.h,
                        vertical: 8.v,
                      ),
                      showCheckmark: false,
                      labelPadding: EdgeInsets.zero,
                      label: Text(
                        list[index],
                        style: TextStyle(
                          color: selectedValue.value == list[index]
                              ? theme.colorScheme.primary
                              : appTheme.gray60004,
                          fontSize: 14.fSize,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      selected: list[index] == selectedValue.value,
                      backgroundColor: Colors.transparent,
                      selectedColor: appTheme.redA200,
                      shape: selectedValue.value == list[index]
                          ? RoundedRectangleBorder(
                              side: BorderSide.none,
                              borderRadius: BorderRadius.circular(
                                18.h,
                              ),
                            )
                          : RoundedRectangleBorder(
                              side: BorderSide(
                                color: appTheme.gray200,
                                width: 1.h,
                              ),
                              borderRadius: BorderRadius.circular(
                                18.h,
                              ),
                            ),
                      onSelected: (value) {
                        selectedValue.value = list[index];
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}

List honoscope = [
  'lbl_aries'.tr,
  'lbl_taurus'.tr,
  'lbl_gemini'.tr,
  'lbl_cancer'.tr,
  'lbl_leo'.tr,
  'lbl_virgo'.tr,
  'lbl_libra'.tr,
  'lbl_scorpio'.tr,
  'lbl_sagittarius'.tr,
  'lbl_capricorn'.tr,
  'lbl_aquarius'.tr,
  'lbl_pisces'.tr,
];
List<String> southeastAsianCountries = [
  'Brunei',
  'Cambodia',
  'Indonesia',
  'Laos',
  'Malaysia',
  'Myanmar',
  'Philippines',
  'Singapore',
  'Thailand',
  'Timor-Leste',
  'Vietnam'
];
List drinkingStatus = [
  'lbl_drinker'.tr,
  'lbl_nondrinker'.tr,
  'lbl_socialdrinker'.tr
];
List smokingStatus = [
  'lbl_smoking'.tr,
  'lbl_nonsmoking'.tr,
  'lbl_socialsmoking'.tr
];
List religion = [
  'lbl_christianity'.tr,
  'lbl_islam'.tr,
  'lbl_judaism'.tr,
  'lbl_hinduism'.tr,
  'lbl_buddhism'.tr,
  'lbl_sikhism'.tr,
  'lbl_jainism'.tr,
  'lbl_other'.tr
];
List childrenStatus = [
  'lbl_yes'.tr,
  'lbl_no'.tr,
  'lbl_someday'.tr,
];
List hairColor = [
  'lbl_brown'.tr,
  'lbl_black'.tr,
  'lbl_blonde'.tr,
  'lbl_red'.tr,
  'lbl_other'.tr
];
List musicPreference = [
  'lbl_hiphoprap'.tr,
  'lbl_electronicdance'.tr,
  'lbl_classical'.tr,
  'lbl_jazz'.tr,
  'lbl_country'.tr,
  'lbl_metal'.tr,
  'lbl_rbsoul'.tr,
  'lbl_alternative'.tr,
  'lbl_indie'.tr,
  'lbl_folk'.tr,
  'lbl_reggae'.tr,
  'lbl_othermusic'.tr,
];
List martialStatus = [
  'lbl_single'.tr,
  'lbl_married'.tr,
  'lbl_divorced'.tr,
  'lbl_widowed'.tr,
  'lbl_separated'.tr,
];
