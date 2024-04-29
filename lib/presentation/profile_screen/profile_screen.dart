// ignore_for_file: sdk_version_since

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/progress_dialog_utils.dart';
import 'package:mifever/data/models/report/report_model.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/presentation/home_screen/controller/home_controller.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_icon_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../data/models/thermometer_model/thermometer_model.dart';
import '../../data/sevices/firebase_analytics_service/firebase_analytics_service.dart';
import '../../data/sevices/media_services/audio_services.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import '../about_me_page/models/describeathings_item_model.dart';
import '../chat_screen/chat_screen.dart';
import '../my_profile_screen/models/frame7_item_model.dart';
import '../personal_info_page/models/adition_details_model.dart';
import '../text_tries/text_tries.dart';
import 'controller/profile_controller.dart';
import 'widgets/carousel_item_widget.dart';
import 'widgets/frametwentythree_item_widget.dart';

// ignore_for_file: must_be_immutable
class ProfileScreen extends GetWidget<ProfileController> {
  ProfileScreen(this.id, {Key? key}) : super(key: key);
  final String id;
  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    controller.addThermometer(id);
    controller.getLikeData(id);
    controller.checkIsMatched(id);
    return WillPopScope(
      onWillPop: () async {
        final controller = Get.find<HomeController>();
        controller.getThemometerValue(id);
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

              controller.translate(user);

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
                                        buttonStyle: !controller
                                                .isWayAlbum.value
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
                            Obx(
                              () => _buildQuestionAnswer(
                                aboutMyFavorite: "lbl_here_for".tr,
                                loremIpsumDolor: controller.isConverted.value
                                    ? controller.convertedHereFor.value
                                    : user.whatDoYouWant.toString().tr,
                              ),
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
                                  value:
                                      user.additionalPersonalInfo?.horoscope ??
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
                                      user.additionalPersonalInfo?.religion ??
                                          '',
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
                                      user.additionalPersonalInfo?.children ??
                                          '',
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
                            SizedBox(height: 20.h),
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
                            SizedBox(height: 120.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                  bottomSheet: Obx(
                    () => controller.isMatched.value
                        ? SizedBox()
                        : int.parse(controller.textTries.value) > 0
                            ? _buildChat()
                            : _buildUpgradePlan(),
                  ));
            }),
      ),
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
    Rx<List<DescribeathingsItemModel>> convertedAboutMe = Rx([
      DescribeathingsItemModel(
          question: "lbl_in_my".tr.obs,
          answer: controller.convertedInMyFreeTime,
          key: 'thingsYouLike'.obs),
      DescribeathingsItemModel(
        question: "lbl_abut_culture".tr.obs,
        answer: controller.convertedAboutMyCulture,
        key: 'aboutMyCulture'.obs,
      ),
      DescribeathingsItemModel(
          question: "lbl_fav_location".tr.obs,
          answer: controller.convertedFavLocation,
          key: 'favLocation'.obs)
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
                          loremIpsumDolor: controller.isConverted.value
                              ? convertedAboutMe.value[index].answer!.value
                              : describeathingsItemList
                                  .value[index].answer!.value),
                    ),
                  ],
                ),
              )),
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

  _buildChat() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.v, horizontal: 20.v),
      child: CustomElevatedButton(
        onPressed: () async {
          Get.off(() => ChatScreen(id));
        },
        text: "lbl_chat".tr,
      ),
    );
  }

  _buildUpgradePlan() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.v, horizontal: 20.v),
      child: CustomElevatedButton(
        leftIcon: CustomImageView(
            margin: EdgeInsets.all(5.v), imagePath: ImageConstant.imgGroup25),
        onPressed: () {
          Get.off(() => TextTriesPage());
        },
        text: "lbl_upgrade_plan_for_chat".tr,
        //margin: EdgeInsets.only(left: 14.h),
      ),
    );
  }

  /// Section Widget
  _buildAppBar(UserModel user) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseServices.getBlockUser(id),
        builder: (context, blockSnapshot) {
          if (blockSnapshot.connectionState == ConnectionState.waiting) {
            return SizedBox.shrink();
          }
          var blockSnapshotData = blockSnapshot.data!.docs;
          String docId = '';
          for (var doc in blockSnapshotData) {
            docId = doc.id;
          }
          bool _isBlockedByMe = blockSnapshotData.isNotEmpty;

          return CustomAppBar(
            leadingWidth: 40.h,
            leading: AppbarLeadingImage(
              onTap: () {
                final controller = Get.find<HomeController>();
                controller.getThemometerValue(id);
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
              //"lbl_amy_johns_25".tr,
              margin: EdgeInsets.only(left: 12.h),
            ),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        value: 'BLOCK',
                        child: Text(
                          _isBlockedByMe ? 'Unblock' : 'Block',
                          style: CustomTextStyles.titleSmallGray60004,
                        )),
                    PopupMenuItem(
                        value: 'REPORT',
                        child: Text(
                          'Report',
                          style: CustomTextStyles.titleSmallGray60004,
                        )),
                    PopupMenuItem(
                        value: 'TRANSLATE',
                        child: Text(
                          controller.isConverted.value
                              ? 'See Original'
                              : 'Translate',
                          style: CustomTextStyles.titleSmallGray60004,
                        )),
                    if (controller.likeData.value.roomId != null &&
                        controller.likeData.value.isMatched == true &&
                        controller.likeData.value.isDeleted != true)
                      PopupMenuItem(
                          value: 'REMOVE',
                          child: Text(
                            'Unmatch',
                            style: CustomTextStyles.titleSmallGray60004,
                          )),
                  ];
                },
                onSelected: (val) async {
                  if (val == 'BLOCK') {
                    if (_isBlockedByMe) {
                      await FirebaseServices.unBlockUser(docId);
                      Fluttertoast.showToast(msg: 'Unblocked');
                      AnalyticsService.unBlocked(user.name ?? '');
                    } else {
                      Get.toNamed(AppRoutes.blockProflieScreen,
                          arguments: [id, user.name]);
                    }
                  }
                  if (val == 'REPORT') {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.all(10.h),
                          title: Text(
                              'lbl_are_you_sure_want_to_report'.tr +
                                  ' ${user.name} ?',
                              style: TextStyle(
                                  fontSize: 18.fSize,
                                  fontWeight: FontWeight.w400)),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder()),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                        color: appTheme.redA200,
                                        fontSize: 15.fSize),
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      minimumSize: Size(100.v, 30.v),
                                      backgroundColor: appTheme.redA200),
                                  onPressed: () async {
                                    ReportModel reportModel = ReportModel(
                                        reportTo: user.id!,
                                        roomId:
                                            FirebaseServices.createChatRoomId(
                                                user.id!),
                                        reportBy: PrefUtils.getId(),
                                        reason: '');
                                    await FirebaseServices.reportUser(
                                        reportModel);
                                    Fluttertoast.showToast(msg: 'Success');
                                    ThermometerModel thermometerModel =
                                        ThermometerModel(
                                      timestamp: DateTime.now().toString(),
                                      roomId:
                                          FirebaseServices.createChatRoomId(id),
                                      userIds: [id, PrefUtils.getId()],
                                      percentageValue: 0,
                                    );
                                    await FirebaseServices.addThermometerValue(
                                        thermometerModel);
                                    AnalyticsService.report(user.name ?? '');
                                    Get.back();
                                  },
                                  child: Text(
                                    'Yes',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );

                    // Get.defaultDialog(
                    //   contentPadding:
                    //       EdgeInsets.symmetric(horizontal: 10.h, vertical: 2),
                    //   title: 'lbl_are_you_sure_want_to_report'.tr +
                    //       ' ${user.name} ?',
                    //   titleStyle: TextStyle(
                    //       fontSize: 18.fSize, fontWeight: FontWeight.w400),
                    //   middleText: '',
                    //   actions: <Widget>[
                    //     TextButton(
                    //       style: TextButton.styleFrom(
                    //           padding: EdgeInsets.only(right: 50.v),
                    //           shape: RoundedRectangleBorder()),
                    //       onPressed: () {
                    //         Get.back();
                    //       },
                    //       child: Text(
                    //         'No',
                    //         style: TextStyle(
                    //             color: appTheme.redA200, fontSize: 15.fSize),
                    //       ),
                    //     ),
                    //     TextButton(
                    //       style: TextButton.styleFrom(
                    //           minimumSize: Size(100.v, 30.v),
                    //           backgroundColor: appTheme.redA200),
                    //       onPressed: () async {
                    //         ReportModel reportModel = ReportModel(
                    //             reportTo: user.id!,
                    //             roomId:
                    //                 FirebaseServices.createChatRoomId(user.id!),
                    //             reportBy: PrefUtils.getId(),
                    //             reason: '');
                    //         await FirebaseServices.reportUser(reportModel);
                    //         Fluttertoast.showToast(msg: 'Success');
                    //         ThermometerModel thermometerModel =
                    //             ThermometerModel(
                    //           timestamp: DateTime.now().toString(),
                    //           roomId: FirebaseServices.createChatRoomId(id),
                    //           userIds: [id, PrefUtils.getId()],
                    //           percentageValue: 0,
                    //         );
                    //         await FirebaseServices.addThermometerValue(
                    //             thermometerModel);

                    //         Get.back();
                    //       },
                    //       child: Text(
                    //         'Yes',
                    //       ),
                    //     ),
                    //   ],
                    // );
                  }
                  if (val == 'TRANSLATE') {
                    if (!controller.isConverted.value) {
                      Fluttertoast.showToast(msg: 'translating_to_your'.tr);
                    }
                    controller.isConverted.value =
                        !controller.isConverted.value;
                  }
                  if (val == 'REMOVE') {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          //contentPadding: EdgeInsets.all(0.h),
                          title: Text(
                              'lbl_are_you_sure_want_to_unmatch'.tr +
                                  ' ${user.name} ?',
                              style: TextStyle(
                                  fontSize: 16.fSize,
                                  fontWeight: FontWeight.w400)),
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.only(right: 50.v),
                                  shape: RoundedRectangleBorder()),
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'No',
                                style: TextStyle(
                                    color: appTheme.redA200,
                                    fontSize: 15.fSize),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  minimumSize: Size(100.v, 30.v),
                                  backgroundColor: appTheme.redA200),
                              onPressed: () async {
                                ProgressDialogUtils.showProgressDialog();
                                await FirebaseServices.doUnMatch(id);
                                ProgressDialogUtils.hideProgressDialog();
                                final controller =
                                    Get.find<CustomBottomBarController>();
                                controller.selectedIndex.value = 2;
                                AnalyticsService.unMatch(user.name ?? '');
                                Get.off(() => CustomBottomBar());
                              },
                              child: Text(
                                'Yes',
                              ),
                            ),
                          ],
                        );
                      },
                    );

                    // Get.defaultDialog(
                    //   contentPadding:
                    //       EdgeInsets.symmetric(horizontal: 10.h, vertical: 10),
                    //   title: 'lbl_are_you_sure_want_to_unmatch'.tr +
                    //       ' ${user.name} ?',
                    //   titleStyle: TextStyle(fontSize: 16.fSize),
                    //   middleText: '',
                    //   actions: <Widget>[
                    //     TextButton(
                    //       style: TextButton.styleFrom(
                    //           padding: EdgeInsets.only(right: 50.v),
                    //           shape: RoundedRectangleBorder()),
                    //       onPressed: () {
                    //         Get.back();
                    //       },
                    //       child: Text(
                    //         'No',
                    //         style: TextStyle(
                    //             color: appTheme.redA200, fontSize: 15.fSize),
                    //       ),
                    //     ),
                    //     TextButton(
                    //       style: TextButton.styleFrom(
                    //           minimumSize: Size(100.v, 30.v),
                    //           backgroundColor: appTheme.redA200),
                    //       onPressed: () async {
                    //         ProgressDialogUtils.showProgressDialog();
                    //         await FirebaseServices.doUnMatch(id);
                    //         ProgressDialogUtils.hideProgressDialog();
                    //         final controller =
                    //             Get.find<CustomBottomBarController>();
                    //         controller.selectedIndex.value = 2;
                    //         Get.off(() => CustomBottomBar());
                    //         // Get.back();
                    //       },
                    //       child: Text(
                    //         'Yes',
                    //       ),
                    //     ),
                    //   ],

                    // );
                  }
                },
              )
            ],
            styleType: Style.bgFill,
          );
        });
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
                                onTap: () {
                                  controller.progress.value = 0.0;
                                  controller.isPlaying.value = true;
                                  VoiceRecorderController.playAudio(
                                          user.nameAudio ?? '')
                                      .then((value) => VoiceRecorderController
                                          .audioPosition.value = 0);
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
        _showSubscriptionBadge(padding: 30.v)
      ],
    );
  }

  bool isHide() {
    if (PrefUtils.getUserGender() == 'Female') {
      var item = controller.planName.value;
      return false;
    } else {
      if (controller.planName.value == PlanType.Platinum.name) {
        return false;
      } else {
        return true;
      }
    }
  }

  Widget _showSubscriptionBadge({double? padding}) {
    return Obx(
      () => Visibility(
        visible: isHide(),
        child: InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.subscriptionPlansScreen);
          },
          child: Container(
            margin: EdgeInsets.only(top: padding ?? 50.v),
            padding: EdgeInsets.symmetric(
              horizontal: 167.h,
              //vertical: 32.v,
            ),
            //color: Colors.red,
            decoration: AppDecoration.fillPrimary1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: padding != null ? 5.v : 35.v),
                CustomImageView(
                  imagePath: ImageConstant.imgGroup25,
                  height: 40.adaptSize,
                  width: 40.adaptSize,
                ),
                SizedBox(height: 30.v),
              ],
            ),
          ),
        ),
      ),
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
          Obx(
            () => Wrap(
              runSpacing: 12.v,
              spacing: 12.h,
              children: List<Widget>.generate(
                user.interestList?.length ?? 0,
                (index) {
                  return InterestChipWidget(
                    controller.isConverted.value
                        ? controller.convertedInterest[index]
                        : user.interestList?[index],
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
                return _buildLocationChip(controller.isConverted.value
                    ? controller.convertedAvailableLocation[index]
                    : '${user.availableLocation?[index]}');
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
    Rx<List<DescribeathingsItemModel>> convertedAboutMe = Rx([
      DescribeathingsItemModel(
          question: "lbl_in_my".tr.obs,
          answer: controller.convertedInMyFreeTime,
          key: 'thingsYouLike'.obs),
      DescribeathingsItemModel(
        question: "lbl_abut_culture".tr.obs,
        answer: controller.convertedAboutMyCulture,
        key: 'aboutMyCulture'.obs,
      ),
      DescribeathingsItemModel(
          question: "lbl_fav_location".tr.obs,
          answer: controller.convertedFavLocation,
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
                          loremIpsumDolor: controller.isConverted.value
                              ? convertedAboutMe.value[index].answer!.value
                              : aboutMe.value[index].answer!.value),
                    ),
                    _showSubscriptionBadge()
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
              maxLines: 6,
              //overflow: TextOverflow.ellipsis,
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
