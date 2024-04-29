import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import '../controller/delete_chat_controller.dart';
import '../models/userprofile2_item_model.dart';

// ignore: must_be_immutable
class Userprofile2ItemWidget extends StatelessWidget {
  Userprofile2ItemWidget(
    this.userprofile2ItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  Userprofile2ItemModel userprofile2ItemModelObj;

  var controller = Get.find<DeleteChatController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 20.adaptSize,
          width: 20.adaptSize,
          margin: EdgeInsets.only(
            top: 14.v,
            bottom: 31.v,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10.h,
            ),
            border: Border.all(
              color: appTheme.gray200,
              width: 1.h,
            ),
          ),
        ),
        Obx(
          () => CustomImageView(
            imagePath: userprofile2ItemModelObj.circleImageElement!.value,
            height: 48.adaptSize,
            width: 48.adaptSize,
            radius: BorderRadius.circular(
              24.h,
            ),
            margin: EdgeInsets.only(
              left: 8.h,
              bottom: 17.v,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 12.h,
            top: 2.v,
            bottom: 16.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  userprofile2ItemModelObj.nameTextElement!.value,
                  style: CustomTextStyles.titleMediumBlack900,
                ),
              ),
              SizedBox(height: 4.v),
              Obx(
                () => Text(
                  userprofile2ItemModelObj.messageTextElement!.value,
                  style: CustomTextStyles.bodyMediumRedA200,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(
            top: 3.v,
            bottom: 20.v,
          ),
          child: Column(
            children: [
              Obx(
                () => Text(
                  userprofile2ItemModelObj.timeTextElement!.value,
                  style: theme.textTheme.labelMedium,
                ),
              ),
              SizedBox(height: 5.v),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 20.adaptSize,
                  padding: EdgeInsets.symmetric(
                    horizontal: 7.h,
                    vertical: 1.v,
                  ),
                  decoration: AppDecoration.fillRedA.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder9,
                  ),
                  child: Obx(
                    () => Text(
                      userprofile2ItemModelObj.countTextElement!.value,
                      style: CustomTextStyles.labelMediumPrimary_1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
