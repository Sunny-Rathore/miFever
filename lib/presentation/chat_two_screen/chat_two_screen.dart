import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle_three.dart';
import 'package:mifever/widgets/app_bar/appbar_title_circleimage.dart';
import 'package:mifever/widgets/app_bar/appbar_trailing_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_icon_button.dart';
import 'package:mifever/widgets/custom_text_form_field.dart';
import 'controller/chat_two_controller.dart';

// ignore_for_file: must_be_immutable
class ChatTwoScreen extends GetWidget<ChatTwoController> {
  const ChatTwoScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildFrame(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 132.h),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.h,
                          vertical: 3.v,
                        ),
                        decoration: AppDecoration.fillGray200.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder4,
                        ),
                        child: Text(
                          "lbl_24_jan".tr,
                          style: CustomTextStyles.titleSmallGray60004,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.v),
                    Container(
                      margin: EdgeInsets.only(left: 180.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.h,
                        vertical: 6.v,
                      ),
                      decoration: AppDecoration.fillRedA.copyWith(
                        borderRadius: BorderRadiusStyle.customBorderTL8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 3.v),
                          Text(
                            "msg_what_do_you_think".tr,
                            style: CustomTextStyles.titleSmallGray100,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.v),
                    _buildTellMe(),
                    SizedBox(height: 4.v),
                    Text(
                      "lbl_10_45_am".tr,
                      style: CustomTextStyles.bodySmall11,
                    ),
                    SizedBox(height: 7.v),
                    _buildMessageOne(),
                    SizedBox(height: 2.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.h),
                        child: Text(
                          "lbl_11_50_am".tr,
                          style: CustomTextStyles.bodySmall11,
                        ),
                      ),
                    ),
                    SizedBox(height: 25.v),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 80.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.h,
                          vertical: 2.v,
                        ),
                        decoration: AppDecoration.fillGray200.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder4,
                        ),
                        child: Text(
                          "lbl_yesterday".tr,
                          style: CustomTextStyles.labelMediumGray60004,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.v),
                    Container(
                      margin: EdgeInsets.only(left: 180.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.h,
                        vertical: 6.v,
                      ),
                      decoration: AppDecoration.fillRedA.copyWith(
                        borderRadius: BorderRadiusStyle.customBorderTL8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 3.v),
                          Text(
                            "msg_hi_how_s_going".tr,
                            style: CustomTextStyles.titleSmallGray100,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.v),
                    Text(
                      "lbl_10_45_am".tr,
                      style: CustomTextStyles.bodySmall11,
                    ),
                    SizedBox(height: 3.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 225.h,
                        margin: EdgeInsets.only(right: 110.h),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.h,
                          vertical: 7.v,
                        ),
                        decoration: AppDecoration.fillRed.copyWith(
                          borderRadius: BorderRadiusStyle.customBorderTL12,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 1.v),
                            Container(
                              width: 181.h,
                              margin: EdgeInsets.only(right: 19.h),
                              child: Text(
                                "msg_well_it_s_good_but".tr,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleSmall!.copyWith(
                                  height: 1.43,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 2.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.h),
                        child: Text(
                          "lbl_11_50_am".tr,
                          style: CustomTextStyles.bodySmall11,
                        ),
                      ),
                    ),
                    SizedBox(height: 25.v),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 60.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.h,
                          vertical: 2.v,
                        ),
                        decoration: AppDecoration.fillGray200.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder4,
                        ),
                        child: Text(
                          "lbl_today".tr,
                          style: CustomTextStyles.labelMediumGray60004,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.v),
                    Container(
                      margin: EdgeInsets.only(left: 179.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.h,
                        vertical: 6.v,
                      ),
                      decoration: AppDecoration.fillRedA.copyWith(
                        borderRadius: BorderRadiusStyle.customBorderTL8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 3.v),
                          Text(
                            "msg_how_can_i_help_you".tr,
                            style: CustomTextStyles.titleSmallGray100,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.v),
                    Text(
                      "lbl_01_34_pm".tr,
                      style: CustomTextStyles.bodySmall11,
                    ),
                    SizedBox(height: 2.v),
                    _buildNoThanks(),
                    SizedBox(height: 3.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.h),
                        child: Text(
                          "lbl_01_34_pm".tr,
                          style: CustomTextStyles.bodySmall11,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.v),
                    _buildOk(),
                    SizedBox(height: 4.v),
                    Text(
                      "lbl_10_45_am".tr,
                      style: CustomTextStyles.bodySmall11,
                    ),
                    SizedBox(height: 5.v),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildFrame1(),
      ),
    );
  }

  /// Section Widget
  Widget _buildFrame() {
    return Container(
      decoration: AppDecoration.top,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAppBar(
            height: 64.v,
            leadingWidth: 40.h,
            leading: AppbarLeadingImage(
              imagePath: ImageConstant.imgArrowLeft02SharpPrimarycontainer,
              margin: EdgeInsets.only(
                left: 16.h,
                top: 20.v,
                bottom: 20.v,
              ),
            ),
            title: Padding(
              padding: EdgeInsets.only(left: 12.h),
              child: Row(
                children: [
                  AppbarTitleCircleimage(
                    imagePath: ImageConstant.imgEllipse159140x40,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.h),
                    child: Column(
                      children: [
                        AppbarSubtitleOne(
                          text: "lbl_theresa_webb".tr,
                        ),
                        SizedBox(height: 3.v),
                        AppbarSubtitleThree(
                          text: "lbl_online".tr,
                          margin: EdgeInsets.only(right: 60.h),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              AppbarTrailingImage(
                imagePath: ImageConstant.imgVideo02,
                margin: EdgeInsets.only(
                  left: 24.h,
                  top: 20.v,
                  right: 20.h,
                ),
              ),
              AppbarTrailingImage(
                imagePath: ImageConstant.imgCalling,
                margin: EdgeInsets.only(
                  left: 24.h,
                  top: 20.v,
                  right: 44.h,
                ),
              ),
            ],
            styleType: Style.bgFill,
          ),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 12.h,
              vertical: 8.v,
            ),
            decoration: AppDecoration.fillRed.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgTicketStar,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 8.h,
                    top: 5.v,
                  ),
                  child: Text(
                    "msg_flights_recommendations".tr,
                    style: CustomTextStyles.labelLargeBlack900,
                  ),
                ),
                Spacer(),
                Text(
                  "lbl_view_now".tr,
                  style: CustomTextStyles.titleSmallRedA200,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTellMe() {
    return CustomElevatedButton(
      height: 36.v,
      width: 71.h,
      text: "lbl_tell_me".tr,
      buttonStyle: CustomButtonStyles.fillRedATL8,
      buttonTextStyle: CustomTextStyles.titleSmallGray100,
    );
  }

  /// Section Widget
  Widget _buildMessageOne() {
    return CustomTextFormField(
      width: 225.h,
      controller: controller.messageOneController,
      hintText: "msg_awesome_bro_let_s".tr,
      alignment: Alignment.centerLeft,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 8.v,
      ),
      borderDecoration: TextFormFieldStyleHelper.fillRed,
      filled: true,
      fillColor: appTheme.red50,
    );
  }

  /// Section Widget
  Widget _buildNoThanks() {
    return CustomElevatedButton(
      height: 36.v,
      width: 115.h,
      text: "lbl_no_thanks".tr,
      buttonStyle: CustomButtonStyles.fillRedTL12,
      buttonTextStyle: theme.textTheme.titleSmall!,
      alignment: Alignment.centerLeft,
    );
  }

  /// Section Widget
  Widget _buildOk() {
    return CustomElevatedButton(
      height: 36.v,
      width: 40.h,
      text: "lbl_ok".tr,
      buttonStyle: CustomButtonStyles.fillRedATL8,
      buttonTextStyle: CustomTextStyles.titleSmallGray100,
    );
  }

  /// Section Widget
  Widget _buildMessage() {
    return Expanded(
      child: CustomTextFormField(
        controller: controller.messageController,
        hintText: "msg_type_message_here".tr,
        hintStyle: theme.textTheme.bodySmall!,
        textInputAction: TextInputAction.done,
        prefix: Container(
          margin: EdgeInsets.fromLTRB(12.h, 14.v, 5.h, 14.v),
          child: CustomImageView(
            imagePath: ImageConstant.imgIconEmoji,
            height: 20.adaptSize,
            width: 20.adaptSize,
          ),
        ),
        prefixConstraints: BoxConstraints(
          maxHeight: 48.v,
        ),
        suffix: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 30.h,
            vertical: 14.v,
          ),
          child: CustomImageView(
            imagePath: ImageConstant.imgAttachment01,
            height: 20.adaptSize,
            width: 20.adaptSize,
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 48.v,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15.v),
        borderDecoration: TextFormFieldStyleHelper.outlineOnPrimary,
        filled: true,
        fillColor: theme.colorScheme.primary,
      ),
    );
  }

  /// Section Widget
  Widget _buildFrame1() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.h,
        right: 20.h,
        bottom: 30.v,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildMessage(),
          Padding(
            padding: EdgeInsets.only(left: 12.h),
            child: CustomIconButton(
              height: 48.adaptSize,
              width: 48.adaptSize,
              padding: EdgeInsets.all(12.h),
              decoration: IconButtonStyleHelper.fillRed,
              child: CustomImageView(
                imagePath: ImageConstant.imgMic01RedA200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
