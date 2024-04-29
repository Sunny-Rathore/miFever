// ignore_for_file: must_be_immutable, sdk_version_since, deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/models/block/block_model.dart';
import 'package:mifever/data/models/like/like_model.dart';
import 'package:mifever/data/models/travel_plan/travel_plan_model.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/presentation/travel_Plans/widgets/user_Itmewidget.dart';
import 'package:mifever/widgets/app_bar/appbar_title.dart';
import 'package:mifever/widgets/app_bar/appbar_trailing_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_bottom_bar.dart';
import 'package:skeletons/skeletons.dart';

import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../chat_screen/controller/chat_controller.dart';
import '../../chat_screen/models/chat_model.dart';
import '../../my_chats_one_page/controller/my_chats_one_controller.dart';
import '../../my_chats_one_page/models/my_chats_one_model.dart';
import '../../my_chats_one_page/models/userprofile1_item_model.dart';

class TravelPlanUserList extends StatelessWidget {
  TravelPlanUserList({Key? key, required this.planModel}) : super(key: key);
  final TravelPlanModel planModel;
  MyChatsOneController controller =
      Get.put(MyChatsOneController(MyChatsOneModel().obs));
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return isHome();
        },
        child: Scaffold(
          appBar: _buildAppBar(),
          body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseServices.getAllBlockedUser(),
              builder: (context, blockSnapshot) {
                if (blockSnapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox.shrink();
                }
                var blockedData = blockSnapshot.data?.docs ?? [];
                List<BlockModel> blockList = <BlockModel>[];
                blockList.clear();
                blockList = blockedData
                    .map((e) =>
                        BlockModel.fromJson(e.data() as Map<String, dynamic>))
                    .toList();
                List blockedUserIds = [];
                for (var blockUser in blockList) {
                  if (blockUser.roomId.contains(PrefUtils.getId())) {
                    var otherUserId = blockUser.roomId
                        .replaceAll(PrefUtils.getId(), "")
                        .replaceAll("_", "");
                    blockedUserIds.add(otherUserId);
                  }
                }

                return Container(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseServices.getNotDeletedUser(),
                      builder: (context, matchSnapshot) {
                        if (matchSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SkeletonListView();
                        }
                        var _matchedData = matchSnapshot.data!.docs;
                        List<LikeModel> _matchedUser = <LikeModel>[];
                        _matchedUser.clear();
                        _matchedUser = _matchedData
                            .map((e) => LikeModel.fromJson(
                                e.data() as Map<String, dynamic>))
                            .toList();
                        _matchedUser.sort((a, b) =>
                            b.chatTimeStamp!.compareTo(a.chatTimeStamp!));
                        Set<dynamic> combinedSet = {};
                        for (var x in _matchedUser) {
                          combinedSet.addAll(x.userIds!);
                        }
                        List<dynamic> combinedList = combinedSet.toList();
                        combinedList.remove(PrefUtils.getId());

                        var chatListUserIds = [];
                        for (var combinedUserId in combinedList) {
                          if (!blockedUserIds.contains(combinedUserId)) {
                            chatListUserIds.add(combinedUserId);
                          }
                        }

                        return chatListUserIds.isEmpty
                            ? _noUsers()
                            : ListView.builder(
                                itemCount: chatListUserIds.length,
                                itemBuilder: (context, userIndex) {
                                  return Container(
                                    child: StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseServices.getUserById(
                                            chatListUserIds[userIndex]),
                                        builder: (context, userSnapshot) {
                                          if (userSnapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return SkeletonListView();
                                          }
                                          var data = userSnapshot.data!;
                                          UserModel _user = UserModel.fromJson(
                                              data.data()
                                                  as Map<String, dynamic>);
                                          return StreamBuilder<QuerySnapshot>(
                                              stream:
                                                  FirebaseServices.getLastChats(
                                                      _user.id!),
                                              builder: (context, chatSnapshot) {
                                                if (chatSnapshot
                                                        .connectionState ==
                                                    ConnectionState.waiting) {
                                                  return SizedBox.shrink();
                                                }
                                                var data =
                                                    chatSnapshot.data?.docs ??
                                                        [];
                                                List<ChatModel> _chats =
                                                    <ChatModel>[];
                                                _chats.clear();
                                                _chats = data
                                                    .map((e) =>
                                                        ChatModel.fromJson(
                                                            e.data() as Map<
                                                                String,
                                                                dynamic>))
                                                    .toList();
                                                return Obx(
                                                  () => Visibility(
                                                    visible: controller
                                                        .isVisible(_user.name
                                                            .toString()),
                                                    child: UserItemWidget(Userprofile1ItemModel(
                                                        id: _user.id
                                                            .toString()
                                                            .obs,
                                                        userImage: _user
                                                            .lifeAlbum?[0]
                                                            .toString()
                                                            .obs,
                                                        username: _user.name
                                                            .toString()
                                                            .obs,
                                                        greeting: _chats.length == 0
                                                            ? ''.obs
                                                            : lastMessages(_chats)
                                                                .obs,
                                                        timestamp: _chats
                                                                    .length ==
                                                                0
                                                            ? ''.obs
                                                            : getTimeAgo(DateTime.parse(_chats[0].timestamp ?? ""))
                                                                .obs,
                                                        notificationCount:
                                                            messageCount(_chats) == 0
                                                                ? ''.obs
                                                                : messageCount(
                                                                        _chats)
                                                                    .toString()
                                                                    .obs)),
                                                  ),
                                                );
                                              });
                                        }),
                                  );
                                });
                      }),
                );
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.onSharePlan(planModel);
            },
            child: Icon(
              Icons.done,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
        preferredSize: Size(SizeUtils.width, 56.v),
        child: Obx(() => controller.isSelected.value
            ? _buildDeleteScreenAppBar()
            : controller.isSearch.value
                ? TextFormField(
                    cursorColor: appTheme.gray300,
                    cursorWidth: 1.v,
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      prefixIconConstraints: BoxConstraints(maxWidth: 50.v),
                      prefixIcon: CustomImageView(
                          margin: EdgeInsets.only(
                            left: 20.h,
                            right: 5.v,
                          ),
                          imagePath: ImageConstant.imgSearch),
                      contentPadding: EdgeInsets.only(top: 9.v),
                      border: InputBorder.none,
                      hintText: 'Search',
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.isSearch.value = false;
                          },
                          icon: Icon(Icons.close)),
                    ),
                    onChanged: (val) {
                      controller.query.value = val;
                    },
                  )
                : CustomAppBar(
                    title: AppbarTitle(
                      text: "lbl_my_chats".tr,
                      margin: EdgeInsets.only(left: 20.h),
                    ),
                    actions: [
                      AppbarTrailingImage(
                        onTap: () {
                          controller.isSearch.value = true;
                        },
                        imagePath: ImageConstant.imgSearch,
                        margin: EdgeInsets.fromLTRB(20.h, 12.v, 20.h, 19.v),
                      ),
                    ],
                  )));
  }

  /// Section Widget
  PreferredSizeWidget _buildDeleteScreenAppBar() {
    return CustomAppBar(
      height: 64.v,
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        onTap: () {
          controller.selectedUser.clear();
          controller.isSelected.value = false;
        },
        imagePath: ImageConstant.imgArrowLeft02SharpPrimarycontainer,
        margin: EdgeInsets.only(
          left: 12.h,
          top: 12.v,
          bottom: 12.v,
        ),
      ),
      title: Obx(
        () => AppbarSubtitleOne(
          text: "${controller.selectedUser.length} " + "lbl_2_selected".tr,
          margin: EdgeInsets.only(left: 12.h),
        ),
      ),
      actions: [],
      styleType: Style.bgFill,
    );
  }

  String lastMessages(List<ChatModel> _chats) {
    if (_chats.length == 0) {
      return '';
    } else if (_chats[0].type == MessageType.Voice.name) {
      return '🎵 ${_chats[0].type}';
    } else if (_chats[0].type == MessageType.Media.name) {
      return '📂 ${_chats[0].type}';
    } else if (_chats[0].type == MessageType.Video.name) {
      return '🎥 ${_chats[0].type}';
    } else if (_chats[0].type == MessageType.Text.name) {
      return '${_chats[0].message}';
    } else {
      return '';
    }
  }

  int messageCount(List<ChatModel> _chats) {
    int count = 0;
    if (_chats.isNotEmpty) {
      for (var chat in _chats) {
        if (!chat.isSeen! && chat.receiverId == PrefUtils.getId()) {
          count++;
        }
      }
    }
    return count;
  }

  Widget _noUsers() {
    return Container(
      width: double.maxFinite,
      decoration: AppDecoration.fillPrimary,
      child: Column(
        children: [
          SizedBox(height: 160.v),
          _buildKeepScrolling(),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildKeepScrolling() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.h),
      child: Column(
        children: [
          Container(
            height: 120.h,
            width: 120.v,
            decoration: AppDecoration.fillRed.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder60,
            ),
            child: CustomImageView(
              imagePath: ImageConstant.imgUserOnprimary,
              alignment: Alignment.center,
            ),
          ),
          SizedBox(height: 19.v),
          Text(
            "lbl_people_whom".tr,
            textAlign: TextAlign.center,
            style: CustomTextStyles.titleMediumGray900,
          ),
        ],
      ),
    );
  }
}
