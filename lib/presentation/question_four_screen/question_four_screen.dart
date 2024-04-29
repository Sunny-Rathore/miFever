import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';

import '../question_four_screen/widgets/chipview_item_widget.dart';
import 'controller/question_four_controller.dart';
import 'models/chipview_item_model.dart';

// ignore_for_file: must_be_immutable
class QuestionFourScreen extends GetWidget<QuestionFourController> {
  const QuestionFourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 11.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Container(
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
                        value: 0.57,
                        color: appTheme.redA200,
                        backgroundColor: appTheme.red50,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 23.v),
              Padding(
                padding: EdgeInsets.only(left: 20.h),
                child: Text(
                  "msg_select_your_interest".tr,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              SizedBox(height: 8.v),
              Container(
                width: 252.h,
                margin: EdgeInsets.only(left: 20.h),
                child: Text(
                  "msg_select_your_interests".tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall!.copyWith(
                    height: 1.50,
                  ),
                ),
              ),
              SizedBox(height: 19.v),
              _buildChipView(),
              Spacer(),
              SizedBox(height: 9.v),
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
      leadingWidth: 50.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Get.back();
        },
        imagePath: ImageConstant.imgArrowLeft02SharpGray900,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 13.v,
          bottom: 13.v,
        ),
      ),
      actions: [
        // AppbarSubtitleTwo(
        //   text: "lbl_skip".tr,
        //   margin: EdgeInsets.fromLTRB(20.h, 19.v, 20.h, 16.v),
        // ),
      ],
    );
  }

  /// Section Widget
  Widget _buildChipView() {
    return Padding(
      padding: EdgeInsets.all(8.0.h),
      child: Align(
        alignment: Alignment.center,
        child: Obx(
          () => Wrap(
            runSpacing: 12.v,
            spacing: 12.h,
            children: List<Widget>.generate(
              controller
                  .questionFourModelObj.value.chipviewItemList.value.length,
              (index) {
                ChipviewItemModel model = controller
                    .questionFourModelObj.value.chipviewItemList.value[index];

                return ChipviewItemWidget(
                  model,
                );
              },
            ),
          ),
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
        buttonStyle: controller
                    .questionFourModelObj.value.chipviewItemList.value
                    .firstWhereOrNull(
                        (element) => element.isSelected!.value == true) !=
                null
            ? null
            : CustomButtonStyles.fillGray,
        onPressed: controller.questionFourModelObj.value.chipviewItemList.value
                    .firstWhereOrNull(
                        (element) => element.isSelected!.value == true) !=
                null
            ? _onTapContinue
            : null,
      ),
    );
  }

  void _onTapContinue() {
    Get.toNamed(AppRoutes.questionFiveScreen);
  }
}
