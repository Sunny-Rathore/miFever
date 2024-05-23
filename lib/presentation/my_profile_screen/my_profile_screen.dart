// ignore_for_file: sdk_version_since, deprecated_member_use

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/models/subscriptions/subscription_model.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/presentation/my_profile_screen/widgets/select_from_album_widget.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_switch.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/utils/progress_dialog_utils.dart';
import '../../data/sevices/crop_Image_service.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_icon_button.dart';
import '../chat_screen/widgets/image_message_widget.dart';
import '../travel_Plans/controllers/travel_plan_screen.dart';
import 'controller/my_profile_controller.dart';
import 'models/frame7_item_model.dart';
import 'models/my_profile_one_model.dart';
import 'widgets/frame7_item_widget.dart';

// ignore_for_file: must_be_immutable
class MyProfileScreen extends GetWidget<MyProfileController> {
  MyProfileScreen({Key? key}) : super(key: key);
  final controller = Get.put(MyProfileController(MyProfileOneModel().obs));
  final _cropController = CropController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return isHome();
        },
        child: Scaffold(
          body: SizedBox(
            width: SizeUtils.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: 5.v),
                child: Column(
                  children: [
                    _buildProfileImage(),
                    SizedBox(height: 8.v),
                    _buildPlan(),
                    //SizedBox(height: 28.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: _buildFrame(
                        onTap: () {
                          Get.toNamed(AppRoutes.proflieDetailScreen);
                        },
                        languageSquare: ImageConstant.imgUserAccountRedA200,
                        languages: "lbl_profile_details".tr,
                      ),
                    ),
                    SizedBox(height: 16.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: _buildFrame(
                        onTap: () {
                          Get.to(() => TravelPlanScreen());
                          //Get.toNamed(AppRoutes.createTravelPlanScreen);
                        },
                        languageSquare: ImageConstant.imgAirplane,
                        languages: "msg__my_travel_plan_name".tr,
                      ),
                    ),
                    SizedBox(height: 16.v),
                    _buildFrame2(),
                    SizedBox(height: 16.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: _buildFrame(
                        onTap: () {
                          Get.toNamed(AppRoutes.langaugesScreen);
                        },
                        languageSquare: ImageConstant.imgLanguageSquare,
                        languages: "lbl_languages".tr,
                      ),
                    ),
                    SizedBox(height: 16.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: _buildFrame(
                        onTap: () {
                          Get.toNamed(AppRoutes.helpAndSupportScreen);
                        },
                        languageSquare: ImageConstant.imgHelpCircleRedA200,
                        languages: "lbl_help_support".tr,
                      ),
                    ),
                    SizedBox(height: 16.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: _buildFrame(
                        onTap: () {
                          Get.toNamed(AppRoutes.termsAndConditionsScreen);
                        },
                        languageSquare: ImageConstant.imgTask02RedA200,
                        languages: "msg_terms_conditions".tr,
                      ),
                    ),
                    SizedBox(height: 16.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: _buildFrame(
                        onTap: () {
                          Get.toNamed(AppRoutes.privacyAndPolicyScreen);
                        },
                        languageSquare: ImageConstant.imgSecurityCheck,
                        languages: "lbl_privacy_policy".tr,
                      ),
                    ),
                    SizedBox(height: 16.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: _buildFrame(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                //contentPadding: EdgeInsets.all(0.h),
                                title: Text(
                                    'lbl_are_you_sure_want_to_delete_account'
                                        .tr,
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
                                      UserModel user =
                                          UserModel(isAccountDeleted: true);
                                      await FirebaseServices.updateUser(user);
                                      await FirebaseServices.deleteAccount();
                                      PrefUtils.clearPreferencesData();
                                      ProgressDialogUtils.hideProgressDialog();
                                      Get.offAllNamed(
                                          AppRoutes.onboardingScreen);
                                    },
                                    child: Text(
                                      'Yes',
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        languageSquare: ImageConstant.imgSecurityCheck,
                        languages: "lbl_delete_account".tr,
                      ),
                    ),
                    SizedBox(height: 30.v),
                    CustomElevatedButton(
                      height: 40.v,
                      text: "lbl_log_out".tr,
                      margin: EdgeInsets.symmetric(horizontal: 20.h),
                      buttonStyle: CustomButtonStyles.fillRedTL4,
                      buttonTextStyle: theme.textTheme.titleSmall!,
                      onPressed: onTapLogout,
                    ),
                    SizedBox(height: 30.v),
                    Text(
                      "lbl_version_0_011".tr,
                      style: CustomTextStyles.bodySmall11,
                    ),
                    SizedBox(height: 2.v),
                    Text(
                      "lbl_mifever".tr,
                      style: CustomTextStyles.bodySmall11,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildPlan() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseServices.getSubscription(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox.shrink();
          }
          List<SubscriptionModel> _subscriptionsList = <SubscriptionModel>[];
          _subscriptionsList.clear();
          var snapshotData = snapshot.data?.docs ?? [];
          _subscriptionsList = snapshotData
              .map((e) =>
                  SubscriptionModel.fromJson(e.data() as Map<String, dynamic>))
              .toList();
          print(snapshotData.length);
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 3.v),
                    child: Text(
                      PrefUtils.getUserName(),
                      //_user.name!,
                      style: CustomTextStyles.titleLargeGray900,
                    ),
                  ),
                  Visibility(
                    visible: _subscriptionsList.isNotEmpty,
                    child: CustomImageView(
                      imagePath: _subscriptionsList.isNotEmpty &&
                              _subscriptionsList[0].plan.id!.value ==
                                  PlanType.Platinum.name
                          ? ImageConstant.imgPlatinum
                          : ImageConstant.imgGroup26,
                      height: 30.adaptSize,
                      width: 30.adaptSize,
                      margin: EdgeInsets.only(left: 8.h),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28.v),
              Visibility(
                visible: _subscriptionsList.length == 0,
                child: SizedBox(
                  height: 193.v,
                  child: Obx(
                    () => ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (
                        context,
                        index,
                      ) {
                        return SizedBox(
                          width: 20.h,
                        );
                      },
                      itemCount: controller.myProfileOneModelObj.value
                          .frame7ItemList.value.length,
                      itemBuilder: (context, index) {
                        Frame7ItemModel model = controller.myProfileOneModelObj
                            .value.frame7ItemList.value[index];
                        return Frame7ItemWidget(
                          model,
                        );
                      },
                    ),
                  ),
                ),
              ),
              Visibility(
                  visible: _subscriptionsList.isNotEmpty &&
                      _subscriptionsList[0].plan.id!.value ==
                          PlanType.Gold.name,
                  child: platinumPlan()),
              SizedBox(height: 28.v),
            ],
          );
        });
  }

  /// Section Widget
  Widget _buildProfileImage() {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseServices.getUserById(PrefUtils.getId()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox.shrink();
          }
          var data = snapshot.data;
          UserModel _user =
              UserModel.fromJson(data!.data() as Map<String, dynamic>);
          var profileStrength = 44;
          if (_user.aboutMe!.thingsYouLike != "") {
            profileStrength += 4;
          }
          if (_user.aboutMe!.aboutMyCulture != "") {
            profileStrength += 4;
          }
          if (_user.aboutMe!.favLocation != "") {
            profileStrength += 4;
          }
          if (_user.aboutMe!.hobbiesAndActivity != "") {
            profileStrength += 4;
          }
          if (_user.aboutMe!.whatKindPerson != "") {
            profileStrength += 4;
          }

          if (_user.additionalPersonalInfo!.children != null) {
            profileStrength += 4;
          }
          if (_user.additionalPersonalInfo!.drinkingStatus != null) {
            profileStrength += 4;
          }
          if (_user.additionalPersonalInfo!.height != null) {
            profileStrength += 4;
          }
          if (_user.additionalPersonalInfo!.horoscope != null) {
            profileStrength += 4;
          }
          if (_user.additionalPersonalInfo!.maritalStatus != null) {
            profileStrength += 4;
          }
          if (_user.additionalPersonalInfo!.musicPreference != null) {
            profileStrength += 4;
          }
          if (_user.additionalPersonalInfo!.naturalHairColor != null) {
            profileStrength += 4;
          }
          if (_user.additionalPersonalInfo!.religion != null) {
            profileStrength += 4;
          }
          if (_user.additionalPersonalInfo!.smokingStatus != null) {
            profileStrength += 4;
          }

          return Column(
            children: [
              SizedBox(
                height: 172.v,
                width: double.maxFinite,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 125.v,
                        width: double.maxFinite,
                        decoration: AppDecoration.gradientOnPrimaryToRedA,
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Opacity(
                              opacity: 0.16,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgLayer21,
                                height: 105.v,
                                width: 375.h,
                                alignment: Alignment.center,
                              ),
                            ),
                            CustomImageView(
                              onTap: () {
                                Share.share('text');
                              },
                              imagePath: ImageConstant.imgSend,
                              height: 24.adaptSize,
                              width: 24.adaptSize,
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(
                                top: 20.v,
                                right: 20.h,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Card(
                        clipBehavior: Clip.none,
                        elevation: 0,
                        margin: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusStyle.circleBorder67,
                        ),
                        child: Container(
                          height: 134.adaptSize,
                          width: 134.adaptSize,
                          padding: EdgeInsets.symmetric(
                            horizontal: 1.h,
                            vertical: 2.v,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusStyle.circleBorder67,
                          ),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              // CustomImageView(
                              //   imagePath: ImageConstant.imgSettings,
                              //   height: 58.v,
                              //   width: 38.h,
                              //   alignment: Alignment.topLeft,
                              //   margin: EdgeInsets.only(
                              //     left: 1.h,
                              //     top: 6.v,
                              //   ),
                              // ),
                              CircularPercentageIndicator(
                                percentage:
                                    profileStrength / 100, // Example: 75%
                                radius: 100.0,
                                lineWidth: 8.0,
                                color: appTheme.redA200,
                              ),
                              CustomImageView(
                                onTap: () {
                                  Get.to(() => ViewImageWidget(
                                      url: _user.profileImage!.isNotEmpty
                                          ? _user.profileImage
                                          : _user.wayAlbum![0]));
                                },
                                imagePath: _user.profileImage!.isNotEmpty
                                    ? _user.profileImage
                                    : _user.wayAlbum![0],
                                //ImageConstant.imgEllipse1598120x120,
                                height: 120.adaptSize,
                                width: 120.adaptSize,
                                fit: BoxFit.cover,
                                radius: BorderRadius.circular(
                                  60.h,
                                ),
                                alignment: Alignment.center,
                              ),

                              Padding(
                                padding: EdgeInsets.only(bottom: 5.v),
                                child: CustomIconButton(
                                  onTap: () {
                                    Get.defaultDialog(
                                        title: 'Profile Photo',
                                        titleStyle:
                                            TextStyle(fontSize: 20.fSize),
                                        middleText: '',
                                        content: Column(
                                          children: [
                                            ListTile(
                                              onTap: () {
                                                List album = [];
                                                album.addAll(_user.wayAlbum!);
                                                album.addAll(_user.lifeAlbum!);
                                                Get.back();
                                                Get.to(() => SelectFromAlbum(
                                                      album: album,
                                                    ));
                                              },
                                              title: Text('lbl_album'.tr),
                                            ),
                                            ListTile(
                                              onTap: () {
                                                Get.back();
                                                CropImageService.onProfileEdit(
                                                    _cropController);
                                              },
                                              title: Text('lbl_gallery'.tr),
                                            )
                                          ],
                                        ));
                                  },
                                  height: 40.adaptSize,
                                  width: 40.adaptSize,
                                  padding: EdgeInsets.all(10.h),
                                  decoration:
                                      IconButtonStyleHelper.outlinePrimaryTL20,
                                  alignment: Alignment.bottomRight,
                                  child: CustomImageView(
                                    imagePath: ImageConstant.imgEdit02,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.v),
              CustomElevatedButton(
                height: 28.v,
                width: 150.h,
                text:
                    profileStrength.toString() + "msg_35_profile_completed".tr,
                buttonStyle: CustomButtonStyles.fillRedTL14,
                buttonTextStyle: CustomTextStyles.labelMediumRedA200,
              ),
              SizedBox(height: 8.v),
            ],
          );
        });
  }

  /// Section Widget
  Widget _buildFrame2() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      padding: EdgeInsets.symmetric(
        horizontal: 11.h,
        vertical: 12.v,
      ),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgNotification02,
            height: 20.adaptSize,
            width: 20.adaptSize,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              "lbl_notifications".tr,
              style: theme.textTheme.titleSmall,
            ),
          ),
          Spacer(),
          Obx(
            () => CustomSwitch(
              margin: EdgeInsets.symmetric(vertical: 2.v),
              value: controller.isSelectedSwitch.value,
              onChange: (value) async {
                controller.isSelectedSwitch.value = value;
                PrefUtils.setIsNotificationON(value);
                UserModel userModel = UserModel(
                  isNotificationOn: value,
                );
                await FirebaseServices.updateUser(userModel);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildFrame(
      {required String languageSquare,
      required String languages,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(11.h),
        decoration: AppDecoration.outlineGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImageView(
              imagePath: languageSquare,
              height: 20.adaptSize,
              width: 20.adaptSize,
              margin: EdgeInsets.only(top: 1.v),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 8.h,
                top: 1.v,
              ),
              child: Text(
                languages,
                style: theme.textTheme.titleSmall!.copyWith(
                  color: appTheme.gray900,
                ),
              ),
            ),
            Spacer(),
            CustomImageView(
              imagePath: ImageConstant.imgArrowRightGray6000416x16,
              height: 16.adaptSize,
              width: 16.adaptSize,
              margin: EdgeInsets.only(
                top: 1.v,
                bottom: 3.v,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapLogout() {
    PrefUtils.clearPreferencesData();
    Get.offAllNamed(AppRoutes.onboardingScreen);
  }

  Widget platinumPlan() {
    return Container(
      padding: EdgeInsets.all(12.h),
      margin: EdgeInsets.symmetric(horizontal: 15.h),
      decoration: AppDecoration.gradientGrayToGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder9,
      ),
      width: SizeUtils.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgPlatinum,
                height: 60.adaptSize,
                width: 60.adaptSize,
              ),
              SizedBox(width: 10.v),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "msg_buy_platinum_plan".tr,
                    //frame7ItemModelObj.buyGoldPlanText!.value,
                    style: CustomTextStyles.titleSmallPrimaryExtraBold,
                  ),
                  SizedBox(height: 3.v),
                  SizedBox(
                    width: 250.h,
                    child: Text(
                      'lbl_get_platinum_push'.tr,
                      //frame7ItemModelObj.loremIpsumDolorText!.value,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.bodySmallPrimary.copyWith(
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 11.v),
          CustomElevatedButton(
            onPressed: () {
              Get.toNamed(AppRoutes.subscriptionPlansScreen,
                  parameters: {'index': '1'});
            },
            height: 30.v,
            width: 110.h,
            text: "lbl_view_details".tr,
            buttonStyle: CustomButtonStyles.fillPrimaryTL15,
            buttonTextStyle: CustomTextStyles.labelLargeGray60004,
          ),
        ],
      ),
    );
  }
}

class CircularPercentageIndicator extends StatelessWidget {
  final double percentage; // Should be between 0.0 and 1.0
  final double radius;
  final double lineWidth;
  final Color color;

  const CircularPercentageIndicator({
    Key? key,
    required this.percentage,
    required this.radius,
    required this.lineWidth,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(radius * 2, radius * 2),
      painter: CircularPercentagePainter(
        percentage: percentage,
        lineWidth: lineWidth,
        color: color,
      ),
    );
  }
}

class CircularPercentagePainter extends CustomPainter {
  final double percentage;
  final double lineWidth;
  final Color color;

  CircularPercentagePainter({
    required this.percentage,
    required this.lineWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Paint progressPaint = Paint()
      ..color = color
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    // Draw background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Calculate angle based on percentage
    double sweepAngle = 2 * pi * percentage;

    // Draw progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
