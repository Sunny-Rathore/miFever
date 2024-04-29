import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_outlined_button.dart';

import '../../data/models/user/user_model.dart';
import '../../data/sevices/firebase_analytics_service/firebase_analytics_service.dart';
import '../chat_screen/chat_screen.dart';
import 'controller/match_screen_two_controller.dart';

// ignore_for_file: must_be_immutable
class MatchScreenTwoScreen extends GetWidget<MatchScreenTwoController> {
  MatchScreenTwoScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String receiverId = Get.arguments[0];
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.5, 0),
              end: Alignment(0.5, 1),
              colors: [
                appTheme.redA200,
                theme.colorScheme.onPrimary.withOpacity(1),
              ],
            ),
          ),
          child: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: SizedBox(
                height: 768.v,
                width: double.maxFinite,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Opacity(
                        opacity: 0.5,
                        child: SizedBox(
                          height: 768.v,
                          width: double.maxFinite,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgLayer22,
                                height: 472.v,
                                width: 375.h,
                                alignment: Alignment.topCenter,
                              ),
                              CustomImageView(
                                imagePath: ImageConstant.imgLayer23,
                                height: 562.v,
                                width: 375.h,
                                alignment: Alignment.bottomCenter,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.h,
                                    vertical: 40.v,
                                  ),
                                  decoration:
                                      AppDecoration.gradientRedAToOnPrimary,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(height: 588.v),
                                      CustomElevatedButton(
                                        onPressed: () {
                                          Get.off(() => ChatScreen(receiverId));
                                        },
                                        text: "lbl_say_hi".tr,
                                        buttonStyle:
                                            CustomButtonStyles.fillPrimary,
                                        buttonTextStyle:
                                            CustomTextStyles.titleMediumRedA200,
                                      ),
                                      SizedBox(height: 16.v),
                                      CustomOutlinedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        height: 42.v,
                                        text: "lbl_keep_scrolling".tr,
                                        buttonStyle: CustomButtonStyles
                                            .outlinePrimaryTL21,
                                        buttonTextStyle:
                                            theme.textTheme.titleMedium!,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              ImageConstant.imgGroup31,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 171.v),
                            SizedBox(
                              height: 90.v,
                              width: 156.h,
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseServices.getUserById(
                                          receiverId),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return SizedBox.shrink();
                                        }
                                        var data = snapshot.data;
                                        UserModel _user = UserModel.fromJson(
                                            data!.data()
                                                as Map<String, dynamic>);
                                        AnalyticsService.match(
                                            _user.name ?? '');
                                        return CustomImageView(
                                          imagePath:
                                              _user.profileImage!.isNotEmpty
                                                  ? _user.profileImage
                                                  : _user.lifeAlbum![0],
                                          fit: BoxFit.cover,
                                          // ImageConstant.imgEllipse2005,
                                          height: 90.adaptSize,
                                          width: 90.adaptSize,
                                          radius: BorderRadius.circular(
                                            45.h,
                                          ),
                                          alignment: Alignment.centerRight,
                                        );
                                      }),
                                  StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseServices.getUserById(
                                          PrefUtils.getId()),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return SizedBox.shrink();
                                        }
                                        var data = snapshot.data;
                                        UserModel _user = UserModel.fromJson(
                                            data!.data()
                                                as Map<String, dynamic>);
                                        return CustomImageView(
                                          imagePath:
                                              _user.profileImage!.isNotEmpty
                                                  ? _user.profileImage
                                                  : _user.lifeAlbum![0],
                                          fit: BoxFit.cover,
                                          // ImageConstant.imgEllipse2005,
                                          height: 90.adaptSize,
                                          width: 90.adaptSize,
                                          radius: BorderRadius.circular(
                                            45.h,
                                          ),
                                          alignment: Alignment.centerLeft,
                                        );
                                      }),
                                ],
                              ),
                            ),
                            SizedBox(height: 27.v),
                            Text(
                              "msg_congratulations".tr,
                              style: CustomTextStyles.titleLargeExtraBold,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 2.v),
                            Text(
                              "msg_start_chatting_now".tr,
                              style: CustomTextStyles.bodyMediumGray200,
                            ),
                            SizedBox(height: 65.v),
                            Container(
                              alignment: Alignment.center,
                              height: 82.adaptSize,
                              width: 82.adaptSize,
                              decoration: BoxDecoration(
                                  color: Colors.white38,
                                  shape: BoxShape.circle),
                              child: Obx(
                                () => Text(
                                  '0' +
                                      controller.elapsedSeconds.value
                                          .toString(),
                                  style: CustomTextStyles.headlineSmallPrimary,
                                ),
                              ),
                            ),
                            SizedBox(height: 19.v),
                            Container(
                              width: 256.h,
                              margin: EdgeInsets.only(
                                left: 37.h,
                                right: 45.h,
                              ),
                              child: Text(
                                "msg_after_the_countdown".tr,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style:
                                    CustomTextStyles.bodyMediumGray200.copyWith(
                                  height: 1.43,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
}
