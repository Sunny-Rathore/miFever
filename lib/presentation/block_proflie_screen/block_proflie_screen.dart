import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/progress_dialog_utils.dart';
import 'package:mifever/data/models/block/block_model.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_text_form_field.dart';

import '../../data/models/thermometer_model/thermometer_model.dart';
import '../../data/sevices/firebase_analytics_service/firebase_analytics_service.dart';
import '../../data/sevices/firebase_services.dart';
import 'controller/block_proflie_controller.dart';

// ignore_for_file: must_be_immutable
class BlockProflieScreen extends GetWidget<BlockProflieController> {
  BlockProflieScreen({Key? key}) : super(key: key);
  final String? id = Get.arguments[0];
  final String? name = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 25.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //width: 268.h,
                //margin: EdgeInsets.only(right: 74.h),
                child: Text(
                  "msg_select_reason_why".tr + " $name",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.titleLargeGray900.copyWith(
                    height: 1.40,
                  ),
                ),
              ),
              SizedBox(height: 22.v),
              _buildSelectReasonWhyYouWantToBlockJ(),
              SizedBox(height: 19.v),
              Obx(
                () => Visibility(
                  visible: controller.selectReasonWhyYouWantToBlockJ.value ==
                      'lbl_other'.tr,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "lbl_write_a_reason".tr,
                        style: CustomTextStyles.titleSmallGray60004,
                      ),
                      SizedBox(height: 8.v),
                      Padding(
                        padding: EdgeInsets.only(right: 8.h),
                        child: CustomTextFormField(
                          controller: controller.optionalController,
                          hintText: "lbl_optional".tr,
                          hintStyle: theme.textTheme.bodySmall!,
                          textInputAction: TextInputAction.done,
                          maxLines: 4,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.h,
                            vertical: 14.v,
                          ),
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
        bottomNavigationBar: _buildContinue(),
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
        text: "lbl_block_profile".tr,
        margin: EdgeInsets.only(left: 12.h),
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildSelectReasonWhyYouWantToBlockJ() {
    return Column(
      children: List.generate(
          controller.blockProflieModelObj.value.radioList.value.length,
          (index) => Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: InkWell(
                  onTap: () {
                    controller.selectReasonWhyYouWantToBlockJ.value = controller
                        .blockProflieModelObj.value.radioList.value[index];
                  },
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.h,
                        vertical: 11.v,
                      ),
                      decoration: isSelected(controller.blockProflieModelObj
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
                              controller.blockProflieModelObj.value.radioList
                                  .value[index],
                              style: isSelected(controller.blockProflieModelObj
                                      .value.radioList.value[index])
                                  ? theme.textTheme.titleMedium
                                  : CustomTextStyles.titleMediumGray900,
                            ),
                          ),
                          Obx(
                            () => isSelected(controller.blockProflieModelObj
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

  bool isSelected(String reason) {
    if (controller.selectReasonWhyYouWantToBlockJ.value == reason) {
      return true;
    }
    return false;
  }

  /// Section Widget
  Widget _buildContinue() {
    return Obx(
      () => CustomElevatedButton(
        text: "lbl_continue".tr,
        margin: EdgeInsets.only(
          left: 20.h,
          right: 20.h,
          bottom: 20.v,
        ),
        rightIcon: Container(
          margin: EdgeInsets.only(left: 4.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgArrowleft02sharp,
            height: 24.adaptSize,
            width: 24.adaptSize,
          ),
        ),
        buttonStyle: controller.selectReasonWhyYouWantToBlockJ.value.isEmpty
            ? CustomButtonStyles.fillGray
            : null,
        onPressed: controller.selectReasonWhyYouWantToBlockJ.value.isEmpty
            ? null
            : onTapContinue,
      ),
    );
  }

  onTapContinue() async {
    ProgressDialogUtils.showProgressDialog();
    BlockModel model = BlockModel(
      roomId: FirebaseServices.createChatRoomId(id!),
      blockTo: id!,
      blockBy: PrefUtils.getId(),
      reason: controller.selectReasonWhyYouWantToBlockJ.value,
      otherReason: controller.optionalController.text,
    );
    await FirebaseServices.addBlockUser(model);
    ThermometerModel thermometerModel = ThermometerModel(
      timestamp: DateTime.now().toString(),
      roomId: FirebaseServices.createChatRoomId(id!),
      userIds: [id, PrefUtils.getId()],
      percentageValue: 0,
    );
    await FirebaseServices.addThermometerValue(thermometerModel);
    controller.optionalController.clear();
    ProgressDialogUtils.hideProgressDialog();
    AnalyticsService.block(name ?? "");
    Get.back();
  }
}
