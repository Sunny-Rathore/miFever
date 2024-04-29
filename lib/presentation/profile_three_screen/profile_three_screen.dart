import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/appbar_trailing_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_icon_button.dart';
import 'package:mifever/widgets/custom_outlined_button.dart';
import '../profile_three_screen/widgets/frametwentythree10_item_widget.dart';
import '../profile_three_screen/widgets/frametwentythree8_item_widget.dart';
import 'controller/profile_three_controller.dart';
import 'models/frametwentythree10_item_model.dart';
import 'models/frametwentythree8_item_model.dart';
import 'models/widget2_item_model.dart';
import 'widgets/widget2_item_widget.dart';

// ignore_for_file: must_be_immutable
class ProfileThreeScreen extends GetWidget<ProfileThreeController> {
  const ProfileThreeScreen({Key? key})
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
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.v),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.h),
                      child: Row(
                        children: [
                          CustomElevatedButton(
                            height: 36.v,
                            width: 105.h,
                            text: "lbl_way_album".tr,
                            buttonStyle: CustomButtonStyles.fillRedATL18,
                            buttonTextStyle: CustomTextStyles.titleSmallPrimary,
                          ),
                          CustomOutlinedButton(
                            width: 102.h,
                            text: "lbl_life_album".tr,
                            margin: EdgeInsets.only(left: 12.h),
                            buttonStyle: CustomButtonStyles.outlineGray,
                          ),
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
                        count: controller.profileThreeModelObj.value
                            .widget2ItemList.value.length,
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
                  _buildFrame1(),
                  _buildFrame(
                    thingsIReally: "lbl_here_for".tr,
                    description: "msg_serious_relationship2".tr,
                  ),
                  _buildFrameTwentyOne(),
                  _buildFrame(
                    thingsIReally: "msg_things_i_really".tr,
                    description: "msg_lorem_ipsum_dolor2".tr,
                  ),
                  _buildFrame(
                    thingsIReally: "msg_things_i_love_about".tr,
                    description: "msg_lorem_ipsum_dolor3".tr,
                  ),
                  _buildFrame(
                    thingsIReally: "msg_what_kind_of_person".tr,
                    description: "msg_lorem_ipsum_dolor2".tr,
                  ),
                  _buildFrame(
                    thingsIReally: "msg_my_hobbies_and_activities".tr,
                    description: "msg_lorem_ipsum_dolor4".tr,
                  ),
                  _buildFrame(
                    thingsIReally: "msg_about_my_favorite".tr,
                    description: "msg_lorem_ipsum_dolor4".tr,
                  ),
                ],
              ),
            ),
          ),
        ),
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
            controller.profileThreeModelObj.value.widget2ItemList.value.length,
        itemBuilder: (context, index, realIndex) {
          Widget2ItemModel model = controller
              .profileThreeModelObj.value.widget2ItemList.value[index];
          return Widget2ItemWidget(
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
  Widget _buildFrame1() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.h, 24.v, 20.h, 22.v),
      decoration: AppDecoration.outlineRed50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "lbl_interests".tr,
            style: CustomTextStyles.titleMediumGray900ExtraBold,
          ),
          SizedBox(height: 10.v),
          Obx(
            () => Wrap(
              runSpacing: 12.v,
              spacing: 12.h,
              children: List<Widget>.generate(
                controller.profileThreeModelObj.value.frametwentythree8ItemList
                    .value.length,
                (index) {
                  Frametwentythree8ItemModel model = controller
                      .profileThreeModelObj
                      .value
                      .frametwentythree8ItemList
                      .value[index];

                  return Frametwentythree8ItemWidget(
                    model,
                  );
                },
              ),
            ),
          ),
        ],
      ),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "msg_available_locations".tr,
            style: CustomTextStyles.titleMediumGray900ExtraBold,
          ),
          SizedBox(height: 8.v),
          Obx(
            () => Wrap(
              runSpacing: 12.v,
              spacing: 12.h,
              children: List<Widget>.generate(
                controller.profileThreeModelObj.value.frametwentythree10ItemList
                    .value.length,
                (index) {
                  Frametwentythree10ItemModel model = controller
                      .profileThreeModelObj
                      .value
                      .frametwentythree10ItemList
                      .value[index];

                  return Frametwentythree10ItemWidget(
                    model,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildFrame({
    required String thingsIReally,
    required String description,
  }) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.fromLTRB(20.h, 21.v, 20.h, 19.v),
      decoration: AppDecoration.outlineRed50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.v),
          Text(
            thingsIReally,
            style: CustomTextStyles.titleMediumGray900ExtraBold.copyWith(
              color: appTheme.gray900,
            ),
          ),
          SizedBox(height: 7.v),
          Container(
            width: 307.h,
            margin: EdgeInsets.only(right: 27.h),
            child: Text(
              description,
              maxLines: 4,
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
