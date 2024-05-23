import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/sevices/firebase_services.dart';

import '../../data/models/notification/notification.dart';
import '../../data/models/user/user_model.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppbarSubtitle(text: 'lbl_notifications'.tr),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseServices.getAllNotifications(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox.shrink();
            }
            var data = snapshot.data?.docs ?? [];
            List<NotificationModel> notifications = <NotificationModel>[];
            notifications.clear();
            notifications = data
                .map((e) => NotificationModel.fromJson(
                    e.data() as Map<String, dynamic>))
                .toList();
            return notifications.length == 0
                ? _buildNoNotifications()
                : _buildNotifications(notifications);
          }),
    );
  }

  Center _buildNoNotifications() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CustomImageView(
              imagePath: 'assets/images/Empty_notification.svg',
            ),
          ),
          SizedBox(height: 16.h),
          Text('lbl_no_notifications'.tr)
        ],
      ),
    );
  }

  ListView _buildNotifications(List<NotificationModel> notifications) {
    return ListView.builder(
      padding: EdgeInsets.all(20.h),
      itemCount: notifications.length,
      itemBuilder: (BuildContext context, int index) {
        return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseServices.getUserById(
                notifications[index].notificationBy),
            builder: (context, usersSnapshot) {
              if (usersSnapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: 50.h,
                );
              }
              UserModel _user = UserModel();
              var data = usersSnapshot.data!;
              _user = UserModel.fromJson(data.data() as Map<String, dynamic>);
              return SizedBox(
                width: SizeUtils.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: appTheme.red100,
                          ),
                          padding: EdgeInsets.all(5.h),
                          child: CustomImageView(
                            color: appTheme.redA200,
                            imagePath: 'assets/images/bell_icon.svg',
                          ),
                        ),
                        SizedBox(width: 20.h),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTimeAgo(DateTime.parse(
                                    notifications[index].createdAt)),
                                style: TextStyle(fontSize: 11.fSize),
                              ),
                              Text(
                                getNotificationText(
                                    notification: notifications[index],
                                    user: _user),
                                style: CustomTextStyles.titleSmallBlack900,
                              ),
                              // Text(
                              //   'Lorem ipsum dolor sit amet consectetur. Nec lorem pretium enim lectus id. Aenean.',
                              //   style:
                              //       CustomTextStyles.bodyMediumGray900,
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Divider(),
                    SizedBox(height: 10.h),
                  ],
                ),
              );
            });
      },
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
}
