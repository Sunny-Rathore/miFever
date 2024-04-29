import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import '../controller/profile_one_controller.dart';
import '../models/eightyseven_item_model.dart';

// ignore: must_be_immutable
class EightysevenItemWidget extends StatelessWidget {
  EightysevenItemWidget(
    this.eightysevenItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  EightysevenItemModel eightysevenItemModelObj;

  var controller = Get.find<ProfileOneController>();

  @override
  Widget build(BuildContext context) {
    return CustomImageView(
      imagePath: ImageConstant.imgRectangle17848,
      height: 295.v,
      width: 375.h,
    );
  }
}
