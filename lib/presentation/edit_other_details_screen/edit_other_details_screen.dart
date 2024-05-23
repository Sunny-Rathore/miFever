import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_text_form_field.dart';

import '../../data/sevices/google_places_services.dart';
import '../question_five_screen/controller/question_five_controller.dart';
import 'controller/edit_other_details_controller.dart';
import 'models/frame10_item_model.dart';
import 'widgets/other_details_item_widget.dart';

// ignore_for_file: must_be_immutable
class EditOtherDetailsScreen extends GetWidget<EditOtherDetailsController> {
  const EditOtherDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25.v),
              Container(
                margin: EdgeInsets.only(bottom: 5.v),
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "msg_select_your_interest".tr,
                      style: CustomTextStyles.titleMediumGray900,
                    ),
                    SizedBox(height: 16.v),
                    _buildInterestFrame(),
                    SizedBox(height: 33.v),
                    Text(
                      "msg_what_do_you_want".tr,
                      style: CustomTextStyles.titleMediumGray900,
                    ),
                    SizedBox(height: 14.v),
                    _buildWhatDoYouWantToFindOut(),
                    SizedBox(height: 31.v),
                    Text(
                      "msg_interested_in_locations".tr,
                      style: CustomTextStyles.titleMediumGray900,
                    ),
                    SizedBox(height: 16.v),
                    Obx(
                      () => Wrap(
                        runSpacing: 5.v,
                        spacing: 5.v,
                        children: List.generate(
                          controller.availableLocation.length,
                          (index) => Visibility(
                            visible: controller
                                    .availableLocation[index].locationName !=
                                'lbl_enter_location'.tr,
                            child: _buildMadridEurope(
                                text:
                                    '${controller.availableLocation[index].locationName}',
                                onTap: () {
                                  if (controller.availableLocation.length > 1) {
                                    controller.availableLocation
                                        .removeAt(index);
                                  }
                                }),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 21.v),
                    Obx(
                      () => Column(
                        children: List.generate(
                          controller.availableLocation.length,
                          (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "lbl_location".tr,
                                style: CustomTextStyles.titleSmallGray60002,
                              ),
                              SizedBox(height: 6.v),
                              _buildLocationField(
                                  text: controller
                                      .availableLocation[index].locationName,
                                  onTap: () async {
                                    await GooglePlacesApiServices
                                            .placeSelectAPI(
                                                Get.context!,
                                                controller
                                                    .availableLocation[index]
                                                    .locationName)
                                        .then((value) {
                                      controller.availableLocation[index] =
                                          LocationModel(
                                              name: 'Location${index + 1}',
                                              latLng: GeoPoint(
                                                  value!.result.geometry!
                                                      .location.lat,
                                                  value.result.geometry!
                                                      .location.lng),
                                              locationName: value
                                                  .result.formattedAddress
                                                  .toString());
                                    });
                                  }),
                              SizedBox(height: 21.v),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.availableLocation.add(LocationModel(
                            name: 'Location'.tr,
                            latLng: GeoPoint(0.0, 0.0),
                            locationName: 'lbl_enter_location'.tr));
                      },
                      child: Text(
                        "lbl_add_more".tr,
                        style: CustomTextStyles.titleMediumRedA200,
                      ),
                    ),
                    SizedBox(height: 60.h)
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomSheet: _buildSave(),
      ),
    );
  }

  /// Section Widget
  Widget _buildLocationField(
      {required String text, required VoidCallback onTap}) {
    return CustomTextFormField(
      readOnly: true,
      hintText: text,
      hintStyle: text == "lbl_enter_location".tr
          ? CustomTextStyles.bodySmall12
          : theme.textTheme.titleSmall,
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
      onTap: onTap,
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
        text: "msg_edit_other_details".tr,
        margin: EdgeInsets.only(left: 12.h),
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildInterestFrame() {
    return Obx(
      () => Wrap(
        runSpacing: 12.v,
        spacing: 12.h,
        children: List<Widget>.generate(
          controller.palyList.length,
          (index) {
            OtherDetailsItemWidgetModel model = controller
                .editOtherDetailsModelObj.value.chipviewItemList.value[index];

            return OtherDetailsItemWidget(
              model,
              text: controller.palyList[index],
            );
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildWhatDoYouWantToFindOut() {
    return Column(
      children: List.generate(
          controller.editOtherDetailsModelObj.value.radioList.value.length,
          (index) => Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: InkWell(
                  onTap: () {
                    controller.whatDoYouWantToFindOut.value = controller
                        .editOtherDetailsModelObj.value.radioList.value[index];
                  },
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.h,
                        vertical: 11.v,
                      ),
                      decoration: isSelected(controller.editOtherDetailsModelObj
                              .value.radioList.value[index])
                          ? AppDecoration.outlineRedA.copyWith(
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
                          Obx(
                            () => Text(
                              controller.editOtherDetailsModelObj.value
                                  .radioList.value[index],
                              style: isSelected(controller
                                      .editOtherDetailsModelObj
                                      .value
                                      .radioList
                                      .value[index])
                                  ? theme.textTheme.titleMedium
                                  : CustomTextStyles.titleMediumGray900,
                            ),
                          ),
                          Obx(
                            () => isSelected(controller.editOtherDetailsModelObj
                                    .value.radioList.value[index])
                                ? CustomImageView(
                                    imagePath:
                                        ImageConstant.imgCheckmarkPrimary,
                                    height: 20.adaptSize,
                                    width: 20.adaptSize,
                                  )
                                : Radio(
                                    value: false,
                                    groupValue: true,
                                    onChanged: null),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
    );
  }

  bool isSelected(String whatDoYouWantToFindOut) {
    if (controller.whatDoYouWantToFindOut.value == whatDoYouWantToFindOut) {
      return true;
    }
    return false;
  }

  /// Section Widget
  Widget _buildMadridEurope(
      {required String text, required VoidCallback onTap}) {
    return Container(
      constraints: BoxConstraints(maxWidth: 150.v),
      padding: EdgeInsets.symmetric(horizontal: 15.v, vertical: 8.v),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: appTheme.redA200),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 100.v,
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white, overflow: TextOverflow.ellipsis),
            ),
          ),
          SizedBox(width: 2.v),
          CustomImageView(
            onTap: onTap,
            imagePath: ImageConstant.imgArrowrightPrimary,
            height: 16.adaptSize,
            width: 16.adaptSize,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSave() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.h,
        right: 20.h,
        bottom: 16.v,
      ),
      child: Obx(
        () => CustomElevatedButton(
          text: "lbl_save".tr,
          buttonStyle: controller.isButtonDisable.value
              ? CustomButtonStyles.fillGray
              : null,
          onPressed: controller.isButtonDisable.value
              ? null
              : () {
                  controller.onTapSave();
                },
        ),
      ),
    );
  }

  isButtonDisable() {
    controller.isButtonDisable.value = controller.availableLocation
                .firstWhereOrNull((element) => element.locationName.isEmpty) !=
            null
        ? true
        : false;
  }
}
