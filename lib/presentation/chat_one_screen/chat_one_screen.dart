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
import 'controller/chat_one_controller.dart';

// ignore_for_file: must_be_immutable
class ChatOneScreen extends GetWidget<ChatOneController> {
  const ChatOneScreen({Key? key})
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
              _buildJan(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.h,
                    vertical: 24.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFrame(),
                      Spacer(),
                      Container(
                        width: 225.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.h,
                          vertical: 6.v,
                        ),
                        decoration: AppDecoration.fillRed.copyWith(
                          borderRadius: BorderRadiusStyle.customBorderTL12,
                        ),
                        child: Text(
                          "msg_my_success_story".tr,
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                      ),
                      SizedBox(height: 2.v),
                      Padding(
                        padding: EdgeInsets.only(left: 5.h),
                        child: Text(
                          "lbl_just_now2".tr,
                          style: CustomTextStyles.bodySmall11,
                        ),
                      ),
                      SizedBox(height: 24.v),
                    ],
                  ),
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
  Widget _buildJan() {
    return SizedBox(
      height: 64.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
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
          CustomElevatedButton(
            height: 28.v,
            width: 71.h,
            text: "lbl_24_jan".tr,
            margin: EdgeInsets.only(top: 10.v),
            buttonStyle: CustomButtonStyles.fillGrayTL4,
            buttonTextStyle: CustomTextStyles.titleSmallGray60004,
            alignment: Alignment.topCenter,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFrame() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 10.v,
      ),
      decoration: AppDecoration.fillRed.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgInformationCircle,
            height: 20.adaptSize,
            width: 20.adaptSize,
            margin: EdgeInsets.only(
              top: 1.v,
              bottom: 35.v,
            ),
          ),
          Expanded(
            child: Container(
              width: 276.h,
              margin: EdgeInsets.only(
                left: 8.h,
                top: 1.v,
              ),
              child: Text(
                "msg_please_do_not_send".tr,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyles.labelLargeGray60004.copyWith(
                  height: 1.50,
                ),
              ),
            ),
          ),
        ],
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
          Expanded(
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
          ),
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
