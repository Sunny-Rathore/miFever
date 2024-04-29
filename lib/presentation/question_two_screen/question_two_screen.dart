import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';

import 'controller/question_two_controller.dart';
import 'models/frame_item_model.dart';
import 'widgets/frame_item_widget.dart';

// ignore_for_file: must_be_immutable
class QuestionTwoScreen extends GetWidget<QuestionTwoController> {
  const QuestionTwoScreen({Key? key}) : super(key: key);

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
                    color: appTheme.redA200,
                    value: 0.29,
                    backgroundColor: appTheme.red50,
                  ),
                ),
              ),
              SizedBox(height: 26.v),
              Text(
                "msg_what_is_your_gender".tr,
                style: theme.textTheme.headlineSmall,
              ),
              SizedBox(height: 20.v),
              _buildFrame(),
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
  Widget _buildFrame() {
    return Expanded(
      child: Obx(
        () => ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 20.v,
            );
          },
          itemCount:
              controller.questionTwoModelObj.value.frameItemList.value.length,
          itemBuilder: (context, index) {
            FrameItemModel model =
                controller.questionTwoModelObj.value.frameItemList.value[index];
            return FrameItemWidget(
              model,
            );
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildContinueButton() {
    return Obx(
      () => CustomElevatedButton(
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
        buttonStyle: controller.selectedGender.value.isEmpty
            ? CustomButtonStyles.fillGray
            : null,
        onPressed:
            controller.selectedGender.value.isEmpty ? null : _onTapContinue,
      ),
    );
  }

  _onTapContinue() {
    Get.toNamed(AppRoutes.questionThreeScreen);
  }
}
