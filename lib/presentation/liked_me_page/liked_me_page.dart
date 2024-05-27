// ignore_for_file: must_be_immutable, sdk_version_since

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:mifever/core/app_export.dart';

import '../../data/models/like/like_model.dart';
import '../../data/models/notification/notification.dart';
import '../../data/models/user/user_model.dart';
import '../../data/sevices/firebase_services.dart';
import '../empty_state_page/empty_state_page.dart';
import '../liked_me_page/widgets/today_item_widget.dart';
import 'controller/liked_me_controller.dart';
import 'models/frame13_item_model.dart';
import 'models/liked_me_model.dart';
import 'models/notification_item_model.dart';
import 'models/today_item_model.dart';
import 'widgets/frame13_item_widget.dart';
import 'widgets/notification_item_widget.dart';

class LikedMePage extends StatelessWidget {
  LikedMePage({Key? key}) : super(key: key);
  LikedMeController controller = Get.put(LikedMeController(LikedMeModel().obs));
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseServices.getLikedMe(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox.shrink();
            }

            List<QueryDocumentSnapshot<Object?>> data =
                snapshot.data?.docs ?? [];
            List<NotificationModel> notifications = <NotificationModel>[];
            notifications.clear();
            notifications = data
                .where((e) =>
                    e['type'] !=
                    NotificationType
                        .DisLike.name) // Filter out items with null ID
                .map((e) => NotificationModel.fromJson(
                    e.data() as Map<String, dynamic>))
                .toList();
            // notifications = data
            //     .map((e) => NotificationModel.fromJson(
            //         e.data() as Map<String, dynamic>))
            //     .toList();
            if (notifications.length == 0) {
              return EmptyStatePage();
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 24.v),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 18.h,
                      right: 22.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFrame(notifications),
                        // SizedBox(height: 25.v),
                        // _buildToday(),
                        // SizedBox(height: 22.v),
                        // Text(
                        //   "lbl_17_feb_2024".tr,
                        //   style: CustomTextStyles.labelMediumGray60004,
                        // ),
                        SizedBox(height: 11.v),
                        _buildNotification(notifications),
                        SizedBox(height: 15.v),
                        Divider(),
                        SizedBox(height: 15.v),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFrame(List<NotificationModel> notifications) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseServices.getAllMatchRealUser(directMatch: true),
        builder: (context, matchSnapshot) {
          if (matchSnapshot.connectionState == ConnectionState.waiting) {
            SizedBox.shrink();
          }
          var _matchedData = matchSnapshot.data?.docs ?? [];
          List<LikeModel> _matchedUser = <LikeModel>[];
          _matchedUser.clear();
          _matchedUser = _matchedData
              .map((e) => LikeModel.fromJson(e.data() as Map<String, dynamic>))
              .toList();
          return SizedBox(
            height: 66.v,
            child: Obx(
              () => ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (
                  context,
                  index,
                ) {
                  return SizedBox(
                    width: 16.h,
                  );
                },
                itemCount: controller
                    .likedMeModelObj.value.frame13ItemList.value.length,
                itemBuilder: (context, index) {
                  Rx<List<Frame13ItemModel>> frame13ItemList = Rx([
                    Frame13ItemModel(
                        dynamicText: (notifications.where((element) =>
                                element.type == NotificationType.Like.name))
                            .length
                            .toString()
                            .obs,
                        dynamicText1: "Liked Profile".obs),
                    Frame13ItemModel(
                        dynamicText: (notifications.where((element) =>
                                element.type == NotificationType.View.name))
                            .length
                            .toString()
                            .obs,
                        dynamicText1: "Viewed Profile".obs),
                    Frame13ItemModel(
                        dynamicText: _matchedUser.length.toString().obs,
                        dynamicText1: "Sent Chat".obs)
                  ]);
                  Frame13ItemModel model = frame13ItemList.value[index];
                  //controller.likedMeModelObj.value.frame13ItemList.value[index];
                  return Frame13ItemWidget(
                    model,
                  );
                },
              ),
            ),
          );
        });
  }

  /// Section Widget
  Widget _buildToday() {
    return Obx(
      () => GroupedListView<TodayItemModel, String>(
        shrinkWrap: true,
        stickyHeaderBackgroundColor: Colors.transparent,
        elements: controller.likedMeModelObj.value.todayItemList.value,
        groupBy: (element) => element.groupBy!.value,
        sort: false,
        groupSeparatorBuilder: (String value) {
          return Padding(
            padding: EdgeInsets.only(
              top: 23.v,
              bottom: 10.v,
            ),
            child: Column(
              children: [
                Text(
                  value,
                  style: CustomTextStyles.labelMediumGray60004.copyWith(
                    color: appTheme.gray60004,
                  ),
                ),
              ],
            ),
          );
        },
        itemBuilder: (context, model) {
          return TodayItemWidget(
            model,
          );
        },
        separator: SizedBox(
          height: 15.v,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildNotification(List<NotificationModel> notifications) {
    List<NotificationModel> likes = notifications
        .where((element) => element.type == NotificationType.Like.name)
        .toList();
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (
        context,
        index,
      ) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0.v),
          child: SizedBox(
            width: 335.h,
            child: Divider(
              height: 1.v,
              thickness: 1.v,
              color: appTheme.gray200,
            ),
          ),
        );
      },
      itemCount: likes.length,
      itemBuilder: (context, index) {
        return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseServices.getUserById(likes[index].notificationBy),
            builder: (context, usersSnapshot) {
              if (usersSnapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: 50.h,
                );
              }
              UserModel _user = UserModel();
              var data = usersSnapshot.data!;
              _user = UserModel.fromJson(data.data() as Map<String, dynamic>);
              NotificationItemModel model = NotificationItemModel()
                ..id = RxString(_user.id!)
                ..notificationImage = RxString(_user.profileImage!.isNotEmpty
                    ? _user.profileImage
                    : _user.wayAlbum![0])
                ..notificationText = RxString(getNotificationText(
                    notification: likes[index], user: _user))
                ..time = RxString(likes[index].createdAt);
              return NotificationItemWidget(
                model,
              );
            });
      },
    );
  }

  /// Section Widget
  Widget _buildFrame1() {
    return Row(
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgEllipse200240x40,
          height: 40.adaptSize,
          width: 40.adaptSize,
          radius: BorderRadius.circular(
            20.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "msg_tom_cooper_sent2".tr,
                style: theme.textTheme.titleSmall,
              ),
              SizedBox(height: 2.v),
              Text(
                "lbl_12_min_ago".tr,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgGroup63Red50,
          height: 32.v,
          width: 16.h,
          margin: EdgeInsets.only(
            left: 16.h,
            top: 3.v,
            bottom: 4.v,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 4.h,
            top: 5.v,
            bottom: 17.v,
          ),
          child: Text(
            "lbl_302".tr,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelLarge,
          ),
        ),
      ],
    );
  }

  String getNotificationText(
      {required NotificationModel notification, required UserModel user}) {
    if (notification.type == NotificationType.View.name) {
      return "${user.name} " + 'lbl_viewed_your_profile'.tr;
    } else if (notification.type == NotificationType.Chat.name) {
      return "${user.name} " + 'lbl_send_message_to_you'.tr;
    }
    return "${user.name} " + 'lbl_liked_your_profile'.tr;
  }

  String getNotificationCount(
      {required NotificationModel notification, required UserModel user}) {
    if (notification.type == NotificationType.View.name) {
      return "${user.name} " + 'lbl_viewed_your_profile'.tr;
    } else if (notification.type == NotificationType.Chat.name) {
      return "${user.name} " + 'lbl_send_message_to_you'.tr;
    }
    return "${user.name} " + 'lbl_liked_your_profile'.tr;
  }
}
