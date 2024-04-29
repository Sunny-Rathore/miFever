import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_radio_button.dart';
import 'controller/block_proflie_one_controller.dart';

// ignore_for_file: must_be_immutable
class BlockProflieOneScreen extends GetWidget<BlockProflieOneController> {
  const BlockProflieOneScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                width: 268.h,
                margin: EdgeInsets.only(right: 74.h),
                child: Text(
                  "msg_select_reason_why".tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.titleLargeGray900.copyWith(
                    height: 1.40,
                  ),
                ),
              ),
              SizedBox(height: 22.v),
              _buildSelectReasonWhyYouWantToBlockJ(),
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
    return Padding(
      padding: EdgeInsets.only(right: 8.h),
      child: Obx(
        () => Column(
          children: [
            CustomRadioButton(
              width: 335.h,
              text: "msg_suspicious_activity".tr,
              value:
                  controller.blockProflieOneModelObj.value.radioList.value[0],
              groupValue: controller.selectReasonWhyYouWantToBlockJ.value,
              padding: EdgeInsets.symmetric(
                horizontal: 16.h,
                vertical: 10.v,
              ),
              isRightCheck: true,
              onChange: (value) {
                controller.selectReasonWhyYouWantToBlockJ.value = value;
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.v),
              child: CustomRadioButton(
                width: 335.h,
                text: "lbl_potential_scam".tr,
                value:
                    controller.blockProflieOneModelObj.value.radioList.value[1],
                groupValue: controller.selectReasonWhyYouWantToBlockJ.value,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.h,
                  vertical: 12.v,
                ),
                isRightCheck: true,
                onChange: (value) {
                  controller.selectReasonWhyYouWantToBlockJ.value = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.v),
              child: CustomRadioButton(
                width: 335.h,
                text: "msg_inappropriate_behavior".tr,
                value:
                    controller.blockProflieOneModelObj.value.radioList.value[2],
                groupValue: controller.selectReasonWhyYouWantToBlockJ.value,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.h,
                  vertical: 10.v,
                ),
                isRightCheck: true,
                onChange: (value) {
                  controller.selectReasonWhyYouWantToBlockJ.value = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.v),
              child: CustomRadioButton(
                width: 335.h,
                text: "lbl_other".tr,
                value:
                    controller.blockProflieOneModelObj.value.radioList.value[3],
                groupValue: controller.selectReasonWhyYouWantToBlockJ.value,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.h,
                  vertical: 12.v,
                ),
                isRightCheck: true,
                onChange: (value) {
                  controller.selectReasonWhyYouWantToBlockJ.value = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildContinue() {
    return CustomElevatedButton(
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
      buttonStyle: CustomButtonStyles.fillGray,
    );
  }
}
