// ignore_for_file: must_be_immutable, sdk_version_since

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/empty_state_one_page/empty_state_one_page.dart';
import 'package:mifever/presentation/liked_me_page/widgets/today_item_widget.dart';
import 'package:skeletons/skeletons.dart';

import '../../data/models/notification/notification.dart';
import '../../data/models/user/user_model.dart';
import '../../data/sevices/firebase_services.dart';
import '../liked_me_page/controller/liked_me_controller.dart';
import '../liked_me_page/models/liked_me_model.dart';
import '../liked_me_page/models/notification_item_model.dart';
import '../liked_me_page/models/today_item_model.dart';
import '../liked_me_page/widgets/notification_item_widget.dart';

class MyLikesPage extends StatelessWidget {
  MyLikesPage({Key? key}) : super(key: key);

  LikedMeController controller = Get.put(LikedMeController(LikedMeModel().obs));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: SizeUtils.width,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseServices.getMyLikes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SkeletonListView();
              }
              var data = snapshot.data?.docs ?? [];
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
                return EmptyStateOnePage();
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
      ),
    );
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
  Widget _buildNotification(List notifications) {
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
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseServices.getUserById(
                notifications[index].notificationTo),
            builder: (context, usersSnapshot) {
              if (usersSnapshot.connectionState == ConnectionState.waiting) {
                return SkeletonListView();
              }

              UserModel _user = UserModel();
              DocumentSnapshot<Object?> data = usersSnapshot.data!;
              _user = UserModel.fromJson(data.data() as Map<String, dynamic>);
              NotificationItemModel model = NotificationItemModel()
                ..id = RxString(_user.id!)
                ..notificationImage = RxString(_user.profileImage!.isNotEmpty
                    ? _user.profileImage
                    : _user.wayAlbum![0])
                ..notificationText = RxString(getNotificationText(
                    notification: notifications[index], user: _user))
                ..time = RxString(notifications[index].createdAt);
              return NotificationItemWidget(
                model,
              );
            });
      },
    );
  }

  String getNotificationText(
      {required NotificationModel notification, required UserModel user}) {
    if (notification.type == NotificationType.View.name) {
      return "lbl_you_viewed".tr + " ${user.name} " + "lbl_profile".tr;
    } else if (notification.type == NotificationType.Chat.name) {
      return "lbl_you_sent_message".tr + " ${user.name}";
    }
    return "lbl_you_liked".tr + " ${user.name} ";
    //+ "lbl_profile".tr;
  }
}
