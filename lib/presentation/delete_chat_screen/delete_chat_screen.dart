import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:mifever/widgets/app_bar/appbar_trailing_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';

import 'controller/delete_chat_controller.dart';
import 'models/userprofile2_item_model.dart';
import 'widgets/userprofile2_item_widget.dart';

// ignore_for_file: must_be_immutable
class DeleteChatScreen extends GetWidget<DeleteChatController> {
  const DeleteChatScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 24.v),
              _buildUserProfile(),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: 64.v,
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft02SharpPrimarycontainer,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 20.v,
          bottom: 20.v,
        ),
      ),
      title: AppbarSubtitleOne(
        text: "lbl_2_selected".tr,
        margin: EdgeInsets.only(left: 12.h),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgDelete01,
          margin: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 20.v,
          ),
        ),
      ],
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildUserProfile() {
    return Obx(
      () => ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (
          context,
          index,
        ) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 7.5.v),
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
        itemCount: controller
            .deleteChatModelObj.value.userprofile2ItemList.value.length,
        itemBuilder: (context, index) {
          Userprofile2ItemModel model = controller
              .deleteChatModelObj.value.userprofile2ItemList.value[index];
          return Userprofile2ItemWidget(
            model,
          );
        },
      ),
    );
  }
}
