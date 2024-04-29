import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import '../controller/my_likes_controller.dart';
import '../models/userprofile6_item_model.dart';

// ignore: must_be_immutable
class Userprofile6ItemWidget extends StatelessWidget {
  Userprofile6ItemWidget(
    this.userprofile6ItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  Userprofile6ItemModel userprofile6ItemModelObj;

  var controller = Get.find<MyLikesController>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => CustomImageView(
              imagePath: userprofile6ItemModelObj.userImage!.value,
              height: 40.adaptSize,
              width: 40.adaptSize,
              radius: BorderRadius.circular(
                20.h,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 8.h,
              top: 9.v,
              bottom: 10.v,
            ),
            child: Obx(
              () => Text(
                userprofile6ItemModelObj.userName!.value,
                style: theme.textTheme.titleSmall,
              ),
            ),
          ),
          Obx(
            () => CustomImageView(
              imagePath: userprofile6ItemModelObj.likedImage!.value,
              height: 32.v,
              width: 16.h,
              margin: EdgeInsets.only(
                left: 15.h,
                top: 3.v,
                bottom: 4.v,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 4.h,
              top: 6.v,
              bottom: 16.v,
            ),
            child: Obx(
              () => Text(
                userprofile6ItemModelObj.likePercentage!.value,
                style: theme.textTheme.labelLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
