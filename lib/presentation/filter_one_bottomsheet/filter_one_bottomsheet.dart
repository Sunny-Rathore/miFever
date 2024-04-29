// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/custom_drop_down.dart';
import 'package:mifever/widgets/custom_outlined_button.dart';
import 'package:mifever/widgets/custom_text_form_field.dart';

import '../filter_one_bottomsheet/widgets/frame3_item_widget.dart';
import 'controller/filter_one_controller.dart';
import 'models/frame3_item_model.dart';

class FilterOneBottomsheet extends StatelessWidget {
  FilterOneBottomsheet(this.controller, {Key? key}) : super(key: key);

  FilterOneController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 74.v),
        padding: EdgeInsets.symmetric(
          horizontal: 20.h,
          vertical: 12.v,
        ),
        decoration: AppDecoration.fillPrimary.copyWith(
          borderRadius: BorderRadiusStyle.customBorderTL20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            SizedBox(height: 13.v),
            Text(
              "lbl_country".tr,
              style: CustomTextStyles.titleSmallGray60004,
            ),
            SizedBox(height: 6.v),
            CustomTextFormField(
              controller: controller.countryController,
              hintText: "lbl_select_country".tr,
              hintStyle: theme.textTheme.bodySmall!,
              textInputAction: TextInputAction.done,
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
            ),
            SizedBox(height: 13.v),
            Text(
              "lbl_city".tr,
              style: CustomTextStyles.titleSmallGray60004,
            ),
            SizedBox(height: 6.v),
            CustomDropDown(
              hintText: "lbl_select_city".tr,
              items: controller.filterOneModelObj.value.dropdownItemList.value,
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
              onChanged: (value) {
                controller.onSelected(value);
              },
            ),
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
              ),
              child: Slider(
                value: 24.48,
                min: 0.0,
                max: 100.0,
                onChanged: (value) {},
              ),
            ),
            SizedBox(height: 4.v),
            Padding(
              padding: EdgeInsets.only(left: 67.h),
              child: Text(
                "lbl_15_km".tr,
                style: theme.textTheme.labelMedium,
              ),
            ),
            SizedBox(height: 25.v),
            Text(
              "lbl_age".tr,
              style: theme.textTheme.titleSmall,
            ),
            SizedBox(height: 6.v),
            _buildSeventyOne(),
            SizedBox(height: 24.v),
            Text(
              "lbl_interested_in".tr,
              style: theme.textTheme.titleSmall,
            ),
            SizedBox(height: 7.v),
            _buildFrame(),
            SizedBox(height: 23.v),
            Text(
              "msg_your_travel_plan".tr,
              style: theme.textTheme.titleSmall,
            ),
            SizedBox(height: 8.v),
            Container(
              width: 304.h,
              margin: EdgeInsets.only(right: 30.h),
              child: Text(
                "msg_create_an_itinerary".tr,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium!.copyWith(
                  height: 1.43,
                ),
              ),
            ),
            SizedBox(height: 9.v),
            CustomOutlinedButton(
              width: 110.h,
              text: "lbl_create".tr,
              buttonTextStyle: CustomTextStyles.titleMediumRedA200,
            ),
            SizedBox(height: 12.v),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSeventyOne() {
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
            ),
            child: RangeSlider(
              values: RangeValues(
                0,
                0,
              ),
              min: 0.0,
              max: 100.0,
              onChanged: (value) {},
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 23.h),
              padding: EdgeInsets.symmetric(horizontal: 5.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 28.v),
                    child: Text(
                      "lbl_18".tr,
                      style: theme.textTheme.labelMedium,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 67.h,
                      top: 27.v,
                    ),
                    child: Text(
                      "lbl_24".tr,
                      style: theme.textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFrame() {
    return Obx(
      () => Wrap(
        runSpacing: 6.v,
        spacing: 6.h,
        children: List<Widget>.generate(
          controller.filterOneModelObj.value.frame3ItemList.value.length,
          (index) {
            Frame3ItemModel model =
                controller.filterOneModelObj.value.frame3ItemList.value[index];

            return Frame3ItemWidget(
              model,
            );
          },
        ),
      ),
    );
  }
}
