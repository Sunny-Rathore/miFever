// ignore_for_file: must_be_immutable, sdk_version_since

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/matches/widgets/matched_user_item.dart';
import 'package:skeletons/skeletons.dart';

import '../../data/models/like/like_model.dart';
import '../../data/models/user/user_model.dart';
import '../../data/sevices/firebase_services.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../liked_me_page/controller/liked_me_controller.dart';
import '../liked_me_page/models/liked_me_model.dart';
import '../liked_me_page/models/notification_item_model.dart';

class MatchesPage extends StatelessWidget {
  MatchesPage({Key? key}) : super(key: key);

  LikedMeController controller = Get.put(LikedMeController(LikedMeModel().obs));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: SizeUtils.width,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseServices.getAllMatchRealUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SkeletonListView();
              }
              var _matchedData = snapshot.data?.docs ?? [];
              List<LikeModel> _matchedUser = <LikeModel>[];
              _matchedUser.clear();
              _matchedUser = _matchedData
                  .map((e) =>
                      LikeModel.fromJson(e.data() as Map<String, dynamic>))
                  .toList();
              _matchedUser.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
              Set<dynamic> combinedSet = {};
              for (var x in _matchedUser) {
                combinedSet.addAll(x.userIds!);
              }
              List<dynamic> combinedList = combinedSet.toList();
              combinedList.remove(PrefUtils.getId());

              return combinedList.isEmpty
                  ? _noUsers()
                  : SingleChildScrollView(
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
                                SizedBox(height: 11.v),
                                _buildNotification(
                                    notifications: combinedList,
                                    likeModel: _matchedUser),
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
  Widget _buildNotification(
      {required List notifications, required List<LikeModel> likeModel}) {
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
            stream: FirebaseServices.getUserById(notifications[index]),
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
                ..notificationText = RxString(getNotificationText(user: _user))
                ..time = RxString(likeModel[index].updateTimestamp ??
                    DateTime.now().toString());
              return MatchedUerItem(
                model,
              );
            });
      },
    );
  }

  String getNotificationText({required UserModel user}) {
    return 'lbl_your_profile_matched'.tr + " ${user.name}";
  }

  _noUsers() {
    return Container(
      width: double.maxFinite,
      decoration: AppDecoration.fillPrimary,
      child: Column(
        children: [
          SizedBox(height: 151.v),
          _buildUpgradeYourPlan(),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildUpgradeYourPlan() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.h),
      child: Column(
        children: [
          CustomImageView(
            imagePath: 'assets/images/no_match.svg',
          ),
          SizedBox(height: 19.v),
          Text(
            "lbl_you_have_not".tr,
            style: CustomTextStyles.titleMediumGray900,
          ),
          SizedBox(height: 8.v),
          Container(
            width: 317.h,
            margin: EdgeInsets.only(
              left: 2.h,
              right: 3.h,
            ),
            child: Text(
              "lbl_keep_scrolling_be_matched".tr,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall!.copyWith(
                height: 1.50,
              ),
            ),
          ),
          SizedBox(height: 14.v),
          CustomElevatedButton(
            onPressed: () {
              final controller = Get.find<CustomBottomBarController>();
              controller.selectedIndex.value = 0;
            },
            text: "lbl_keep_scrolling2".tr,
          ),
        ],
      ),
    );
  }
}
