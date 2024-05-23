// ignore_for_file: sdk_version_since

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/profile_screen/profile_screen.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_trailing_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_icon_button.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../data/models/notification/notification.dart';
import '../../data/models/thermometer_model/thermometer_model.dart';
import '../../data/models/user/user_model.dart';
import '../../data/sevices/firebase_analytics_service/firebase_analytics_service.dart';
import '../../data/sevices/firebase_services.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/themometer_horizontal.dart';
import '../../widgets/thermomerter_horizontal_cold.dart';
import '../fileter_bottomsheet/filter_bottomsheet.dart';
import '../notifications/notifications.dart';
import 'controller/home_controller.dart';

// ignore_for_file: must_be_immutable
class HomeScreen extends GetWidget<HomeController> {
  HomeScreen({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final controller = Get.put(HomeController());
  late MatchEngine _matchEngine;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: Container(
          height: 660.h,
          width: double.maxFinite,
          padding: EdgeInsets.only(top: 2.v),
          child: Stack(
            children: [
              Obx(
                () => StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseServices.getThermometerValueAsStream(
                        controller.receiverId.value),
                    builder: (context, thermoSnapshot) {
                      if (thermoSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SizedBox.shrink();
                      }
                      var snapShotData = thermoSnapshot.data;
                      ThermometerModel thermometerModel = ThermometerModel(
                          timestamp: DateTime.now().toString(),
                          roomId: '',
                          percentageValue: 0);
                      if (snapShotData!.data() != null) {
                        thermometerModel = ThermometerModel.fromJson(
                            snapShotData.data() as Map<String, dynamic>);
                      }
                      print(
                          'thermoMeter value:${thermometerModel.percentageValue}');
                      return thermometerModel.percentageValue == 0
                          ? _themometerCold(
                              thermometerModel.percentageValue.toDouble())
                          : _themometerHot(
                              thermometerModel.percentageValue.toDouble());
                    }),
              ),
              // Obx(
              //   () => controller.thermoValue.value == 0
              //       ? _themometerCold()
              //       : _themometerHot(),
              // ),
              FutureBuilder<List<UserModel>>(
                future: controller.getUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ));
                  }
                  List<SwipeItem> _swipeItems = <SwipeItem>[];
                  List<UserModel> _users = <UserModel>[];
                  _users.clear();
                  _swipeItems.clear();
                  var data = snapshot.data;
                  _users = data?.map((e) => e).toList() ?? <UserModel>[];
                  int userIndex = 0;

                  for (var user in _users) {
                    _swipeItems.add(SwipeItem(
                      content: InkWell(
                        onTap: () {
                          controller.onSwipe(
                              token: user.token!,
                              type: NotificationType.View.name,
                              notificationTo: user.id!);
                          // controller.sendNotification(
                          //     user: user, type: NotificationType.View.name);
                          Get.to(() => ProfileScreen(user.id!));
                          AnalyticsService.view(user.name ?? '');
                        },
                        onDoubleTap: () {
                          _matchEngine.currentItem!.like();
                        },
                        child: _buildUserCard(user),
                      ),
                      likeAction: () async {
                        UserModel? currentUser =
                            await FirebaseServices.getCurrentUser();
                        int likeCount = await FirebaseServices.getTodaysLike();
                        if (currentUser!.planName!.isNotEmpty &&
                            likeCount > 100) {
                          Fluttertoast.showToast(
                              msg: 'lbl_upgrade_your_plan'.tr);
                          Get.toNamed(AppRoutes.subscriptionPlansScreen,
                              parameters: {'index': '0'});
                        } else {
                          controller.onSwipe(
                              token: user.token!,
                              type: NotificationType.Like.name,
                              notificationTo: user.id!);
                          FirebaseServices.addLike(receiverId: user.id!);
                          controller.sendNotification(
                              user: user, type: NotificationType.Like.name);
                          userIndex++;
                          if (_users.length > userIndex) {
                            controller.receiverId.value =
                                _users[userIndex].id ?? '';
                            controller.stopTimer();
                            controller
                                .addThermometer(_users[userIndex].id ?? '');
                          } else {
                            controller.stopTimer();
                          }
                          Fluttertoast.showToast(
                              msg: 'Liked', gravity: ToastGravity.TOP_RIGHT);
                          AnalyticsService.like(user.name ?? '');
                          controller.profileIndex.value = 0;
                        }
                      },
                      nopeAction: () {
                        userIndex++;
                        if (_users.length > userIndex) {
                          controller.receiverId.value =
                              _users[userIndex].id ?? '';
                          controller.stopTimer();
                          controller.addThermometer(_users[userIndex].id ?? '');
                        } else {
                          controller.stopTimer();
                        }
                        controller.profileIndex.value = 0;
                        if (controller.isWantToDislike.value) {
                          controller.onSwipe(
                              token: user.token!,
                              type: NotificationType.DisLike.name,
                              notificationTo: user.id!);
                          ThermometerModel thermometerModel = ThermometerModel(
                              timestamp: DateTime.now().toString(),
                              roomId:
                                  FirebaseServices.createChatRoomId(user.id!),
                              percentageValue: 0,
                              userIds: [user.id, PrefUtils.getId()]);
                          FirebaseServices.addThermometerValue(
                              thermometerModel);
                          controller.isWantToDislike.value = false;
                          Fluttertoast.showToast(
                              msg: 'Dislike', gravity: ToastGravity.TOP_RIGHT);
                          AnalyticsService.dislike(user.name ?? '');
                        }
                      },
                      onSlideUpdate: (SlideRegion? region) async {
                        print("Region $region");
                      },
                    ));
                  }
                  _matchEngine = MatchEngine(swipeItems: _swipeItems);
                  return Obx(
                    () => controller.userLength.value == 0
                        ? _buildEmptyHome()
                        : Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              _buildLikeDislikeButtons(),
                              Container(
                                height: 550,
                                child: SwipeCards(
                                  nopeTag: CustomImageView(
                                    imagePath: ImageConstant.imgRemove,
                                  ),
                                  upSwipeAllowed: false,
                                  rightSwipeAllowed: true,
                                  matchEngine: _matchEngine,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                        child: _swipeItems[index].content);
                                  },
                                  onStackFinished: () {
                                    controller.stopTimer();

                                    // ScaffoldMessenger.of(context)
                                    //     .showSnackBar(SnackBar(
                                    //   content: Text("Stack Finished"),
                                    //   duration: Duration(milliseconds: 500),
                                    // ));
                                    controller.userLength.value = 0;
                                    controller.profileIndex.value = 0;
                                  },
                                  itemChanged: (SwipeItem item, int index) {
                                    print("item: Swiped, index: $index");
                                  },
                                  fillSpace: true,
                                ),
                              ),
                            ],
                          ),
                  );
                },
              ),
            ],
          )),
    );
  }

  _themometerHot(double value) {
    return Obx(
      () => Visibility(
        visible: controller.userLength.value != 0,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: appTheme.red50,
                  borderRadius: BorderRadius.circular(40.h)),
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              width: SizeUtils.width,
              height: 60.h,
              child: InkWell(
                onTap: () {
                  Get.defaultDialog(
                      titleStyle: TextStyle(fontSize: 15.fSize),
                      title: 'lbl_how_thermometer_works'.tr,
                      middleText: 'lbl_thermometer_is_a'.tr);
                },
                child: ThermoTestHorizontal(value: value / 100
                    //controller.thermoValue.value / 100,
                    ),
              ),
            ),
            Positioned(
              left: 43.h,
              top: 20.v,
              child: CustomImageView(
                height: 20.v,
                width: 20.h,
                imagePath: 'assets/images/fire.svg',
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              right: 30.v,
              top: 20.h,
              child: Text(
                value.round().toString() + '%',
                //controller.thermoValue.value.toString() + '%',
                //"lbl_10".tr,
                style: CustomTextStyles.labelLargeBlack900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _themometerCold(double value) {
    return Obx(
      () => Visibility(
        visible: controller.userLength.value != 0,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color(0XFFE1EEFB),
                  borderRadius: BorderRadius.circular(40.h)),
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              width: SizeUtils.width,
              height: 60.h,
              child: InkWell(
                onTap: () {
                  Get.defaultDialog(
                      titleStyle: TextStyle(fontSize: 15.fSize),
                      title: 'lbl_how_thermometer_works'.tr,
                      middleText: 'lbl_thermometer_is_a'.tr);
                },
                child: ThermoTestHorizontalCold(
                  value: value / 100,
                  //value: controller.thermoValue.value / 100,
                ),
              ),
            ),
            Positioned(
              left: 43.h,
              top: 21.v,
              child: CustomImageView(
                height: 20.v,
                width: 20.h,
                imagePath: 'assets/images/Frame 12.svg',
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              right: 30.v,
              top: 20.h,
              child: Text(
                value.round().toString() + '%',
                //controller.thermoValue.value.toString() + '%',
                //"lbl_10".tr,
                style: CustomTextStyles.labelLargeBlack900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildEmptyHome() => Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 13.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: 'assets/images/Group 175989.svg',
              height: 120.adaptSize,
              width: 120.adaptSize,
              alignment: Alignment.center,
            ),
            SizedBox(height: 26.v),
            Text(
              "lbl_no_match".tr,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall,
            ),
            SizedBox(height: 1.v),
            Text(
              "lbl_adjust_filter".tr,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            SizedBox(height: 22.v),
            CustomElevatedButton(
              onPressed: () {
                Get.to(
                  () => FilterBottomsheet(),
                  transition: Transition.downToUp,
                );
              },
              text: "lbl_filter_your_profile".tr,
              margin: EdgeInsets.only(left: 14.h),
            ),
            SizedBox(height: 24.v),
            SizedBox(height: 5.v),
          ],
        ),
      );

  _buildUserCard(UserModel user) {
    List allImages = [];
    List wayAlbum = user.wayAlbum ?? [];
    List lifeAlbum = user.lifeAlbum ?? [];
    allImages.addAll(wayAlbum);
    allImages.addAll(lifeAlbum);

    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 452.v,
            width: 335.h,
            margin: EdgeInsets.only(top: 80.v),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Obx(
                  () => CustomImageView(
                    imagePath: allImages[controller.profileIndex.value],
                    //ImageConstant.imgRectangle17844,
                    height: 482.v,
                    width: 335.h,
                    radius: BorderRadius.circular(
                      12.h,
                    ),
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.h),
                    child: Row(
                      children: List.generate(
                        allImages.length,
                        (index) => Expanded(
                          child: Obx(
                            () => Stack(
                              children: [
                                Container(
                                  constraints: BoxConstraints(maxHeight: 8.v),
                                  margin: EdgeInsets.only(
                                      left: 2, top: 5.h, right: 2),
                                  height: 8.v,
                                  decoration: BoxDecoration(
                                      color:
                                          controller.profileIndex.value >= index
                                              ? Colors.white
                                              : Colors.grey.shade600,
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.profileIndex.value = index;
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    height: 50.v,
                                    // color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 120.v,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color.fromRGBO(0, 0, 0, 0.5),
                          Color.fromRGBO(0, 0, 0, 0.9),
                        ],
                        stops: [0.0004, 0.5633, 0.9996],
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 24.h,
                          right: 16.h,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 75.h,
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.h,
                                vertical: 5.v,
                              ),
                              decoration: AppDecoration.fillPrimary2.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder12,
                              ),
                              child: Obx(
                                () => Text(
                                  controller
                                          .calculateDistance(
                                              controller.filteredLocation.value,
                                              user.isCurrentLocation!
                                                  ? user.location!
                                                  : user.currentLocationLatLng!)
                                          .round()
                                          .toString() +
                                      "lbl_2_km_away".tr,
                                  style: CustomTextStyles.labelMediumPrimary_1,
                                ),
                              ),
                            ),
                            SizedBox(height: 5.v),
                            Text(
                              user.name.toString(),
                              style: theme.textTheme.titleLarge,
                            ),
                            Row(
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.imgLocation01Gray200,
                                  height: 16.adaptSize,
                                  width: 16.adaptSize,
                                  margin: EdgeInsets.only(bottom: 2.v),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.h),
                                  child: SizedBox(
                                    width: SizeUtils.width * 0.5,
                                    child: Text(
                                      "${user.locationText}",
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyles.labelLargeGray200,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: 63.h,
      leading: AppbarLeadingImage(
        onTap: () {
          // Get.toNamed(AppRoutes.matchScreenOneScreen);
        },
        imagePath: ImageConstant.imgGroup58,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 12.v,
          bottom: 12.v,
        ),
      ),
      actions: [
        AppbarTrailingImage(
          onTap: () {
            Get.to(() => NotificationsScreen());
          },
          imagePath: 'assets/images/bell_icon.svg',
          //ImageConstant.imgFilterHorizontalGray60004,
          margin: EdgeInsets.symmetric(
            // horizontal: 20.h,
            vertical: 13.v,
          ),
        ),
        AppbarTrailingImage(
          onTap: () {
            Get.to(
              () => FilterBottomsheet(),
              transition: Transition.downToUp,
            );
          },
          imagePath: ImageConstant.imgFilterHorizontalGray60004,
          margin: EdgeInsets.symmetric(
            horizontal: 20.h,
            vertical: 13.v,
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildLikeDislikeButtons() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 422.v),
        padding: EdgeInsets.symmetric(
          horizontal: 70.h,
          vertical: 25.v,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImageConstant.imgFrame427320779,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 98.v),
              child: CustomIconButton(
                onTap: () {
                  controller.isWantToDislike.value = true;
                  _matchEngine.currentItem!.nope();
                },
                height: 64.adaptSize,
                width: 64.adaptSize,
                padding: EdgeInsets.all(14.h),
                child: CustomImageView(
                  imagePath: ImageConstant.imgRemove,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 98.v),
              child: CustomIconButton(
                onTap: () {
                  _matchEngine.currentItem!.like();
                },
                height: 64.adaptSize,
                width: 64.adaptSize,
                padding: EdgeInsets.all(14.h),
                child: CustomImageView(
                  imagePath: ImageConstant.imgFavourite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
