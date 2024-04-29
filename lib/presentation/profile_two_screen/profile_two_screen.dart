import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/appbar_trailing_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_floating_button.dart';
import 'package:mifever/widgets/custom_icon_button.dart';
import 'package:mifever/widgets/custom_outlined_button.dart';
import 'controller/profile_two_controller.dart';
import 'models/widget_item_model.dart';
import 'widgets/widget_item_widget.dart';

// ignore_for_file: must_be_immutable
class ProfileTwoScreen extends GetWidget<ProfileTwoController> {
  const ProfileTwoScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 24.v),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: Row(
                      children: [
                        _buildWayAlbum(),
                        _buildLifeAlbum(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.v),
                _buildWidget(),
                SizedBox(height: 16.v),
                Obx(
                  () => SizedBox(
                    height: 6.v,
                    child: AnimatedSmoothIndicator(
                      activeIndex: controller.sliderIndex.value,
                      count: controller
                          .profileTwoModelObj.value.widgetItemList.value.length,
                      axisDirection: Axis.horizontal,
                      effect: ScrollingDotsEffect(
                        spacing: 4,
                        activeDotColor:
                            theme.colorScheme.onPrimary.withOpacity(1),
                        dotColor: appTheme.gray200,
                        dotHeight: 6.v,
                        dotWidth: 6.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.v),
                _buildFrameEighteen(),
                _buildUpgradeYourPlansForChats1(),
                _buildFrameTwentyOne(),
                _buildFrame(
                  title: "msg_things_i_really".tr,
                  description: "msg_lorem_ipsum_dolor2".tr,
                ),
                _buildFrame(
                  title: "msg_things_i_love_about".tr,
                  description: "msg_lorem_ipsum_dolor3".tr,
                ),
                _buildFrame(
                  title: "msg_what_kind_of_person".tr,
                  description: "msg_lorem_ipsum_dolor2".tr,
                ),
                _buildFrame(
                  title: "msg_my_hobbies_and_activities".tr,
                  description: "msg_lorem_ipsum_dolor4".tr,
                ),
                _buildFrame(
                  title: "msg_about_my_favorite".tr,
                  description: "msg_lorem_ipsum_dolor4".tr,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: _buildFloatingActionButton(),
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
        text: "lbl_amy_johns_25".tr,
        margin: EdgeInsets.only(left: 12.h),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgMoreVertical,
          margin: EdgeInsets.all(16.h),
        ),
      ],
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildWayAlbum() {
    return CustomElevatedButton(
      height: 36.v,
      width: 105.h,
      text: "lbl_way_album".tr,
      buttonStyle: CustomButtonStyles.fillRedATL18,
      buttonTextStyle: CustomTextStyles.titleSmallPrimary,
    );
  }

  /// Section Widget
  Widget _buildLifeAlbum() {
    return CustomOutlinedButton(
      width: 102.h,
      text: "lbl_life_album".tr,
      margin: EdgeInsets.only(left: 12.h),
      buttonStyle: CustomButtonStyles.outlineGray,
    );
  }

  /// Section Widget
  Widget _buildWidget() {
    return Obx(
      () => CarouselSlider.builder(
        options: CarouselOptions(
          height: 295.v,
          initialPage: 0,
          autoPlay: true,
          viewportFraction: 1.0,
          enableInfiniteScroll: false,
          scrollDirection: Axis.horizontal,
          onPageChanged: (
            index,
            reason,
          ) {
            controller.sliderIndex.value = index;
          },
        ),
        itemCount:
            controller.profileTwoModelObj.value.widgetItemList.value.length,
        itemBuilder: (context, index, realIndex) {
          WidgetItemModel model =
              controller.profileTwoModelObj.value.widgetItemList.value[index];
          return WidgetItemWidget(
            model,
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameEighteen() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.h, 24.v, 20.h, 22.v),
      decoration: AppDecoration.outlineRed50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 3.v),
          Text(
            "lbl_voice_recording".tr,
            style: CustomTextStyles.titleMediumGray900ExtraBold,
          ),
          SizedBox(height: 8.v),
          Container(
            padding: EdgeInsets.all(12.h),
            decoration: AppDecoration.fillRed.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder4,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 11.v),
                    child: Container(
                      height: 8.v,
                      width: 269.h,
                      decoration: BoxDecoration(
                        color: appTheme.red100,
                        borderRadius: BorderRadius.circular(
                          4.h,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          4.h,
                        ),
                        child: LinearProgressIndicator(
                          value: 0.3,
                          backgroundColor: appTheme.red100,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.h),
                  child: CustomIconButton(
                    height: 30.adaptSize,
                    width: 30.adaptSize,
                    padding: EdgeInsets.all(6.h),
                    decoration: IconButtonStyleHelper.fillRedATL15,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgFavorite,
                    ),
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
  Widget _buildUpgradeYourPlansForChats() {
    return CustomElevatedButton(
      height: 48.v,
      text: "msg_upgrade_your_plans".tr,
      leftIcon: Container(
        margin: EdgeInsets.only(right: 8.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgGroup25Primary,
          height: 36.adaptSize,
          width: 36.adaptSize,
        ),
      ),
      buttonStyle: CustomButtonStyles.fillRedA,
      buttonTextStyle: CustomTextStyles.titleSmallPrimary,
    );
  }

  /// Section Widget
  Widget _buildUpgradeYourPlansForChats1() {
    return SizedBox(
      height: 220.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.fromLTRB(20.h, 24.v, 20.h, 22.v),
              decoration: AppDecoration.outlineRed50,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "lbl_interests".tr,
                    style: CustomTextStyles.titleMediumGray900ExtraBold,
                  ),
                  SizedBox(height: 10.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 105.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.h,
                          vertical: 6.v,
                        ),
                        decoration: AppDecoration.fillRed.copyWith(
                          borderRadius: BorderRadiusStyle.circleBorder20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomImageView(
                              imagePath:
                                  ImageConstant.imgGameController03Gray900,
                              height: 16.v,
                              width: 15.h,
                              margin: EdgeInsets.symmetric(vertical: 3.v),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3.v),
                              child: Text(
                                "lbl_gaming".tr,
                                style: theme.textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.h,
                          vertical: 6.v,
                        ),
                        decoration: AppDecoration.fillRed.copyWith(
                          borderRadius: BorderRadiusStyle.circleBorder20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgMaximizeGray900,
                              height: 16.adaptSize,
                              width: 16.adaptSize,
                              margin: EdgeInsets.symmetric(vertical: 3.v),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 6.h,
                                top: 3.v,
                              ),
                              child: Text(
                                "lbl_design".tr,
                                style: theme.textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.h,
                          vertical: 6.v,
                        ),
                        decoration: AppDecoration.fillRed.copyWith(
                          borderRadius: BorderRadiusStyle.circleBorder20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgUserGray900,
                              height: 16.adaptSize,
                              width: 16.adaptSize,
                              margin: EdgeInsets.symmetric(vertical: 3.v),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 6.h,
                                top: 3.v,
                              ),
                              child: Text(
                                "lbl_writing".tr,
                                style: theme.textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _buildFrame(
            title: "lbl_here_for".tr,
            description: "msg_serious_relationship2".tr,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80.v,
              width: double.maxFinite,
              margin: EdgeInsets.only(bottom: 61.v),
              decoration: AppDecoration.top,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20.h, 16.v, 80.h, 16.v),
                      padding: EdgeInsets.all(8.h),
                      decoration: AppDecoration.top.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgIconEmoji,
                            height: 20.adaptSize,
                            width: 20.adaptSize,
                            margin: EdgeInsets.only(
                              left: 4.h,
                              top: 6.v,
                              bottom: 6.v,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 5.h,
                              top: 9.v,
                              bottom: 5.v,
                            ),
                            child: Text(
                              "msg_type_message_here".tr,
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                          Spacer(),
                          CustomImageView(
                            imagePath: ImageConstant.imgAttachment01,
                            height: 20.adaptSize,
                            width: 20.adaptSize,
                            margin: EdgeInsets.symmetric(vertical: 6.v),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.h),
                            child: CustomIconButton(
                              height: 32.adaptSize,
                              width: 32.adaptSize,
                              padding: EdgeInsets.all(6.h),
                              decoration: IconButtonStyleHelper.fillRedA,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgSave,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.h,
                        vertical: 16.v,
                      ),
                      decoration: AppDecoration.fillPrimary2,
                      child: _buildUpgradeYourPlansForChats(),
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
  Widget _buildMadridEupore() {
    return CustomElevatedButton(
      height: 36.v,
      width: 133.h,
      text: "lbl_madrid_eupore".tr,
      buttonStyle: CustomButtonStyles.fillRed,
      buttonTextStyle: theme.textTheme.titleSmall!,
    );
  }

  /// Section Widget
  Widget _buildNewYorkUSA() {
    return CustomElevatedButton(
      height: 36.v,
      width: 127.h,
      text: "lbl_new_york_usa".tr,
      margin: EdgeInsets.only(left: 12.h),
      buttonStyle: CustomButtonStyles.fillRed,
      buttonTextStyle: theme.textTheme.titleSmall!,
    );
  }

  /// Section Widget
  Widget _buildFrameTwentyOne() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.fromLTRB(20.h, 24.v, 20.h, 22.v),
      decoration: AppDecoration.outlineRed50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "msg_available_locations".tr,
            style: CustomTextStyles.titleMediumGray900ExtraBold,
          ),
          SizedBox(height: 8.v),
          Padding(
            padding: EdgeInsets.only(right: 63.h),
            child: Row(
              children: [
                _buildMadridEupore(),
                _buildNewYorkUSA(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFloatingActionButton() {
    return CustomFloatingButton(
      height: 48,
      width: 48,
      backgroundColor: appTheme.red50,
      child: CustomImageView(
        imagePath: ImageConstant.imgMic01RedA200,
        height: 24.0.v,
        width: 24.0.h,
      ),
    );
  }

  /// Common widget
  Widget _buildFrame({
    required String title,
    required String description,
  }) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.fromLTRB(20.h, 24.v, 20.h, 22.v),
      decoration: AppDecoration.outlineRed50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CustomTextStyles.titleMediumGray900ExtraBold.copyWith(
              color: appTheme.gray900,
            ),
          ),
          SizedBox(height: 8.v),
          Container(
            width: 311.h,
            margin: EdgeInsets.only(right: 24.h),
            child: Text(
              description,
              maxLines: null,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: appTheme.gray60004,
                height: 1.43,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
