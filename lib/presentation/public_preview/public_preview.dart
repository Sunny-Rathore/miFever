// ignore_for_file: sdk_version_since

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_icon_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../data/sevices/media_services/audio_services.dart';
import '../../widgets/custom_outlined_button.dart';
import '../about_me_page/models/describeathings_item_model.dart';
import '../personal_info_page/models/adition_details_model.dart';
import '../profile_screen/widgets/carousel_item_widget.dart';
import '../profile_screen/widgets/frametwentythree_item_widget.dart';

class PublicPreviewController extends GetxController {
  RxBool isWayAlbum = true.obs;
  Rx<int> sliderIndex = 0.obs;
  RxDouble progress = 0.0.obs;
  RxBool isPlaying = false.obs;
  RxString planName = ''.obs;
  RxString textTries = '0'.obs;
  late Timer _timer;
  RxDouble timingSeconds = 0.0.obs;
  RxInt timerCount = 0.obs;
  startTimer() {
    timingSeconds.value = 0.0;
    progress.value = 0;

    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      timingSeconds.value = timingSeconds.value + 10;
      if (isPlaying.value) {
        if (progress.value < 1) {
          progress.value =
              timingSeconds.value / ((timerCount.value + 1) * 1000);
        } else {
          isPlaying.value = false;
          progress.value = 0.0;
          timingSeconds.value = 0;
          _timer.cancel();
        }
      }
    });
  }
}

// ignore_for_file: must_be_immutable
class PublicPreview extends StatelessWidget {
  PublicPreview(this.id, {Key? key}) : super(key: key);
  final String id;
  final controller = Get.put(PublicPreviewController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        VoiceRecorderController.stopAudio();
        controller._timer.cancel();
        return true;
      },
      child: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseServices.getUserById(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox.shrink();
              }
              var data = snapshot.data;
              UserModel user =
                  UserModel.fromJson(data!.data() as Map<String, dynamic>);

              controller.timerCount.value = user.audioDuration ?? 3;

              return Scaffold(
                appBar: PreferredSize(
                    preferredSize: Size(SizeUtils.width, 56.v),
                    child: _buildAppBar(user)),
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
                              child: Obx(
                                () => Row(
                                  children: [
                                    CustomOutlinedButton(
                                      height: 36.v,
                                      width: 135.h,
                                      text: "lbl_way_album".tr,
                                      buttonStyle: controller.isWayAlbum.value
                                          ? CustomButtonStyles.fillRedATL18
                                          : CustomButtonStyles.outlineGray,
                                      buttonTextStyle: controller
                                              .isWayAlbum.value
                                          ? CustomTextStyles.titleSmallPrimary
                                          : CustomTextStyles
                                              .titleSmallGray60004,
                                      onPressed: () {
                                        controller.isWayAlbum.value = true;
                                      },
                                    ),
                                    CustomOutlinedButton(
                                      width: 135.h.h,
                                      text: "lbl_life_album".tr,
                                      buttonTextStyle: !controller
                                              .isWayAlbum.value
                                          ? CustomTextStyles.titleSmallPrimary
                                          : CustomTextStyles
                                              .titleSmallGray60004,
                                      margin: EdgeInsets.only(left: 12.h),
                                      buttonStyle: !controller.isWayAlbum.value
                                          ? CustomButtonStyles.fillRedATL18
                                          : CustomButtonStyles.outlineGray,
                                      onPressed: () {
                                        controller.isWayAlbum.value = false;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.v),
                          Obx(() => _buildCarouselSlider(
                                controller.isWayAlbum.value
                                    ? user.wayAlbum ?? []
                                    : user.lifeAlbum ?? [],
                              )),
                          SizedBox(height: 16.v),
                          Obx(
                            () => SizedBox(
                              height: 6.v,
                              child: AnimatedSmoothIndicator(
                                activeIndex: controller.sliderIndex.value,
                                count: user.wayAlbum?.length ?? 0,
                                axisDirection: Axis.horizontal,
                                effect: ScrollingDotsEffect(
                                  spacing: 4,
                                  activeDotColor: theme.colorScheme.onPrimary
                                      .withOpacity(1),
                                  dotColor: appTheme.gray200,
                                  dotHeight: 6.v,
                                  dotWidth: 6.h,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24.v),
                          _buildVoiceRecording(user),
                          _buildInterests(user),
                          _buildQuestionAnswer(
                            aboutMyFavorite: "lbl_here_for".tr,
                            loremIpsumDolor: user.whatDoYouWant.toString().tr,
                          ),
                          _buildAvailableLocation(user),
                          ...List.generate(9, (index) {
                            List<AdditionalDetailsWidgetModel>
                                additionalDetailsList =
                                <AdditionalDetailsWidgetModel>[
                              AdditionalDetailsWidgetModel(
                                label: 'lbl_height'.tr,
                                key: 'height',
                                value: user.additionalPersonalInfo?.height !=
                                        null
                                    ? '${user.additionalPersonalInfo?.height} cm'
                                    : '',
                              ),
                              AdditionalDetailsWidgetModel(
                                label: 'lbl_horoscope'.tr,
                                key: 'horoscope',
                                value: user.additionalPersonalInfo?.horoscope ??
                                    '',
                              ),
                              AdditionalDetailsWidgetModel(
                                label: 'lbl_smokingOrNonSmoking'.tr,
                                key: 'smokingStatus',
                                value: user.additionalPersonalInfo
                                        ?.smokingStatus ??
                                    '',
                              ),
                              AdditionalDetailsWidgetModel(
                                label: 'lbl_drinkerOrNonDrinker'.tr,
                                key: 'drinkingStatus',
                                value: user.additionalPersonalInfo
                                        ?.drinkingStatus ??
                                    '',
                              ),
                              AdditionalDetailsWidgetModel(
                                label: 'lbl_religion'.tr,
                                key: 'religion',
                                value:
                                    user.additionalPersonalInfo?.religion ?? '',
                              ),
                              AdditionalDetailsWidgetModel(
                                label: 'lbl_maritalStatus'.tr,
                                key: 'maritalStatus',
                                value: user.additionalPersonalInfo
                                        ?.maritalStatus ??
                                    '',
                              ),
                              AdditionalDetailsWidgetModel(
                                label: 'lbl_children'.tr,
                                key: 'children',
                                value:
                                    user.additionalPersonalInfo?.children ?? '',
                              ),
                              AdditionalDetailsWidgetModel(
                                label: 'lbl_naturalHairColor'.tr,
                                key: 'naturalHairColor',
                                value: user.additionalPersonalInfo
                                        ?.naturalHairColor ??
                                    '',
                              ),
                              AdditionalDetailsWidgetModel(
                                label: 'lbl_musicpreference'.tr,
                                key: 'musicPreference',
                                value: user.additionalPersonalInfo
                                        ?.musicPreference ??
                                    '',
                              ),
                            ];
                            return _buildFrame(
                                onTap: () {},
                                value: additionalDetailsList[index].value,
                                key: additionalDetailsList[index].key,
                                label: additionalDetailsList[index].label);
                          }),
                          _buildAboutMe(user),
                          Padding(
                            padding: EdgeInsets.only(left: 20.h, top: 20.h),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'lbl_about_me'.tr,
                                style: CustomTextStyles
                                    .titleMediumGray900ExtraBold,
                              ),
                            ),
                          ),
                          _buildAboutMe1(user),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget _buildFrame(
      {required String value,
      required String key,
      required String label,
      required VoidCallback onTap}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20.h),
      decoration: AppDecoration.outlineRed50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: theme.textTheme.titleSmall!.copyWith(
              color: appTheme.gray900,
            ),
          ),
          Spacer(),
          Row(
            children: [
              Text(
                value,
                style: theme.textTheme.titleSmall!.copyWith(
                  color: appTheme.gray900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Section Widget
  _buildAppBar(UserModel user) {
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
        text: user.name.toString(),
        margin: EdgeInsets.only(left: 12.h),
      ),
      actions: [],
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildCarouselSlider(List list) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 295.v,
        initialPage: 0,
        autoPlay: true,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
        scrollDirection: Axis.horizontal,
        onPageChanged: (
          index,
          reason,
        ) {
          controller.sliderIndex.value = index;
        },
      ),
      itemCount: list.length,
      itemBuilder: (context, index, realIndex) {
        return CarouselSliderItemWidget(
          list[index],
        );
      },
    );
  }

  /// Section Widget
  Widget _buildVoiceRecording(UserModel user) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
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
              Card(
                clipBehavior: Clip.antiAlias,
                elevation: 0,
                color: appTheme.red50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusStyle.roundedBorder4,
                ),
                child: Container(
                  padding: EdgeInsets.all(10.v),
                  height: 54.v,
                  width: 335.h,
                  decoration: AppDecoration.fillRed.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder4,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                    child: Obx(
                                      () => LinearProgressIndicator(
                                        borderRadius:
                                            BorderRadius.circular(10.h),
                                        minHeight: 8.v,
                                        value: controller.progress.value,
                                        color: appTheme.redA200,
                                        backgroundColor: appTheme.red100,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12.h),
                              child: CustomIconButton(
                                onTap: () async {
                                  if (!controller.isPlaying.value) {
                                    controller.isPlaying.value = true;
                                    controller.startTimer();
                                    await VoiceRecorderController.playAudio(
                                        user.nameAudio ?? '');
                                  } else {
                                    controller.isPlaying.value = false;
                                    VoiceRecorderController.stopAudio();
                                    controller._timer.cancel();
                                  }
                                  // controller.isPlaying.value = true;
                                  // controller.progress.value = 0.0;

                                  // controller.isPlaying.value = false;
                                },
                                height: 30.adaptSize,
                                width: 30.adaptSize,
                                padding: EdgeInsets.all(6.h),
                                decoration: IconButtonStyleHelper.fillRedATL15,
                                child: Obx(
                                  () => controller.isPlaying.value
                                      ? Icon(
                                          Icons.pause,
                                          color: Colors.white,
                                          size: 15.h,
                                        )
                                      : CustomImageView(
                                          imagePath: ImageConstant.imgFavorite,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildInterests(UserModel user) {
    return Container(
      alignment: Alignment.centerLeft,
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
          Wrap(
            runSpacing: 12.v,
            spacing: 12.h,
            children: List<Widget>.generate(
              user.interestList?.length ?? 0,
              (index) {
                return InterestChipWidget(
                  user.interestList?[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAvailableLocation(UserModel user) {
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
          Wrap(
            runSpacing: 12.v,
            spacing: 12.h,
            children: List<Widget>.generate(
              user.availableLocation?.length ?? 0,
              (index) {
                return _buildLocationChip('${user.availableLocation?[index]}');
              },
            ),
          ),
        ],
      ),
    );
  }

  RawChip _buildLocationChip(String text) {
    return RawChip(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 8.v,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        text,
        style: TextStyle(
          color: appTheme.gray900,
          fontSize: 14.fSize,
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: appTheme.red50,
      selectedColor: appTheme.red50,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appTheme.gray900.withOpacity(0.6),
          width: 1.h,
        ),
        borderRadius: BorderRadius.circular(
          18.h,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAboutMe(UserModel _user) {
    Rx<List<DescribeathingsItemModel>> aboutMe = Rx([
      DescribeathingsItemModel(
          question: "lbl_in_my".tr.obs,
          answer: _user.aboutMe?.thingsYouLike.obs,
          key: 'thingsYouLike'.obs),
      DescribeathingsItemModel(
        question: "lbl_abut_culture".tr.obs,
        answer: _user.aboutMe?.aboutMyCulture.obs,
        key: 'aboutMyCulture'.obs,
      ),
      DescribeathingsItemModel(
          question: "lbl_fav_location".tr.obs,
          answer: _user.aboutMe?.favLocation.obs,
          key: 'favLocation'.obs)
    ]);

    return Column(
      children: List.generate(
          aboutMe.value.length,
          (index) => Container(
                //height: 160.v,
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 1.v),
                child: Stack(
                  // alignment: Alignment.b,
                  children: [
                    Obx(
                      () => _buildQuestionAnswer(
                          aboutMyFavorite: aboutMe.value[index].question!.value,
                          loremIpsumDolor: aboutMe.value[index].answer!.value),
                    ),
                  ],
                ),
              )),
    );
  }

  /// Section Widget
  Widget _buildAboutMe1(UserModel _user) {
    Rx<List<DescribeathingsItemModel>> describeathingsItemList = Rx([
      DescribeathingsItemModel(
          question: "lbl_my_fav_location_in_home_country".tr.obs,
          answer: _user.aboutMe?.whatKindPerson.obs,
          key: 'whatKindPerson'.obs),
      DescribeathingsItemModel(
        question: "lbl_hobbies_and_activity".tr.obs,
        answer: _user.aboutMe?.hobbiesAndActivity.obs,
        key: 'hobbiesAndActivity'.obs,
      ),
    ]);

    return Column(
      children: List.generate(
          describeathingsItemList.value.length,
          (index) => Container(
                //height: 160.v,
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 1.v),
                child: Stack(
                  children: [
                    Obx(
                      () => _buildQuestionAnswer(
                          aboutMyFavorite: describeathingsItemList
                              .value[index].question!.value,
                          loremIpsumDolor: describeathingsItemList
                              .value[index].answer!.value),
                    ),
                  ],
                ),
              )),
    );
  }

  /// Common widget
  Widget _buildQuestionAnswer({
    required String aboutMyFavorite,
    required String loremIpsumDolor,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.h, 21.v, 20.h, 19.v),
      decoration: AppDecoration.outlineRed50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.v),
          Text(
            aboutMyFavorite,
            style: CustomTextStyles.titleMediumGray900ExtraBold.copyWith(
              color: appTheme.gray900,
            ),
          ),
          SizedBox(height: 7.v),
          Container(
            width: 307.h,
            margin: EdgeInsets.only(right: 27.h),
            child: Text(
              loremIpsumDolor,
              maxLines: 3,
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

List palyList = [
  'Movie',
  'Gaming',
  'Nature',
  'Photography',
  'Gym & Fitness',
  'Sports',
  'Design',
  'Dancing',
  'Reading',
  'Music',
  'Writing',
  'Cooking',
  'Animals',
];

List palyListImg = [
  ImageConstant.imgPlaylist,
  ImageConstant.imgGamecontroller03,
  ImageConstant.imgSailboatoffshore,
  ImageConstant.imgCamera01,
  ImageConstant.imgDumbbell02,
  ImageConstant.imgBasketball01,
  ImageConstant.imgMaximize,
  ImageConstant.imgMdihumanfemaledance,
  ImageConstant.imgNotebook,
  ImageConstant.imgMusicnote03,
  ImageConstant.imgUser,
  ImageConstant.imgDish01,
  ImageConstant.imgTelevision,
];

// Method to match a string from one list to another list
String matchStringAndGetInterestImage(String inputString) {
  int index = palyList.indexOf(inputString);
  if (index != -1 && index < palyListImg.length) {
    return palyListImg[index];
  } else {
    return ImageConstant.imgPlaylist;
  }
}
