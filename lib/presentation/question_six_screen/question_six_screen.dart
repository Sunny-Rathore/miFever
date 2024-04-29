import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';

import 'controller/question_six_controller.dart';

// ignore_for_file: must_be_immutable
class QuestionSixScreen extends GetWidget<QuestionSixController> {
  const QuestionSixScreen({Key? key}) : super(key: key);

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
          child: SingleChildScrollView(
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
                      value: 0.86,
                      color: appTheme.redA200,
                      backgroundColor: appTheme.red50,
                    ),
                  ),
                ),
                SizedBox(height: 25.v),
                Container(
                  width: 240.h,
                  margin: EdgeInsets.only(right: 94.h),
                  child: Text(
                    "msg_what_do_you_want".tr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.headlineSmall!.copyWith(
                      height: 1.33,
                    ),
                  ),
                ),
                SizedBox(height: 22.v),
                _buildWhatDoYouWantToFindOut(),
                SizedBox(height: 5.v),
              ],
            ),
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
  Widget _buildWhatDoYouWantToFindOut() {
    return Column(
      children: List.generate(
          controller.whatDoYouWantToFindOutList.length,
          (index) => Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: InkWell(
                  onTap: () {
                    controller.whatDoYouWantToFindOut.value =
                        controller.whatDoYouWantToFindOutList[index];
                  },
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.h,
                        vertical: 11.v,
                      ),
                      decoration: isSelected(
                              controller.whatDoYouWantToFindOutList[index])
                          ? AppDecoration.outlineRedA.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder4,
                              border: Border.all(
                                color: appTheme.redA200,
                                width: 4.h,
                              ),
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
                              controller.whatDoYouWantToFindOutList[index],
                              style: isSelected(controller
                                      .whatDoYouWantToFindOutList[index])
                                  ? theme.textTheme.titleMedium
                                  : CustomTextStyles.titleMediumGray900,
                            ),
                          ),
                          Obx(
                            () => isSelected(controller
                                    .whatDoYouWantToFindOutList[index])
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

    // Obx(
    //   () => Column(
    //     children: [
    //       CustomRadioButton(
    //         width: 335.h,
    //         text: "lbl_casual_dating".tr,
    //         value: controller.questionSixModelObj.value.radioList.value[0],
    //         groupValue: controller.whatDoYouWantToFindOut.value,
    //         padding: EdgeInsets.symmetric(
    //           horizontal: 16.h,
    //           vertical: 10.v,
    //         ),
    //         isRightCheck: true,
    //         onChange: (value) {
    //           controller.whatDoYouWantToFindOut.value = value;
    //         },
    //       ),
    //       Padding(
    //         padding: EdgeInsets.only(top: 20.v),
    //         child: CustomRadioButton(
    //           width: 335.h,
    //           text: "msg_serious_relationship".tr,
    //           value: controller.questionSixModelObj.value.radioList.value[1],
    //           groupValue: controller.whatDoYouWantToFindOut.value,
    //           padding: EdgeInsets.symmetric(
    //             horizontal: 18.h,
    //             vertical: 10.v,
    //           ),
    //           isRightCheck: true,
    //           onChange: (value) {
    //             controller.whatDoYouWantToFindOut.value = value;
    //           },
    //         ),
    //       ),
    //       Padding(
    //         padding: EdgeInsets.only(top: 20.v),
    //         child: CustomRadioButton(
    //           width: 335.h,
    //           text: "msg_culture_learning".tr,
    //           value: controller.questionSixModelObj.value.radioList.value[2],
    //           groupValue: controller.whatDoYouWantToFindOut.value,
    //           padding: EdgeInsets.symmetric(
    //             horizontal: 16.h,
    //             vertical: 10.v,
    //           ),
    //           isRightCheck: true,
    //           onChange: (value) {
    //             controller.whatDoYouWantToFindOut.value = value;
    //           },
    //         ),
    //       ),
    //       Padding(
    //         padding: EdgeInsets.only(top: 20.v),
    //         child: CustomRadioButton(
    //           width: 335.h,
    //           text: "lbl_i_don_t_know".tr,
    //           value: controller.questionSixModelObj.value.radioList.value[3],
    //           groupValue: controller.whatDoYouWantToFindOut.value,
    //           padding: EdgeInsets.symmetric(
    //             horizontal: 16.h,
    //             vertical: 12.v,
    //           ),
    //           isRightCheck: true,
    //           onChange: (value) {
    //             controller.whatDoYouWantToFindOut.value = value;
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  bool isSelected(String whatDoYouWantToFindOut) {
    if (controller.whatDoYouWantToFindOut.value == whatDoYouWantToFindOut) {
      return true;
    }
    return false;
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
        buttonStyle: controller.whatDoYouWantToFindOut.value.isEmpty
            ? CustomButtonStyles.fillGray
            : null,
        onPressed: controller.whatDoYouWantToFindOut.value.isEmpty
            ? null
            : _onTapContinue,
      ),
    );
  }

  void _onTapContinue() {
    Get.toNamed(AppRoutes.questionSevenScreen);
  }
}
