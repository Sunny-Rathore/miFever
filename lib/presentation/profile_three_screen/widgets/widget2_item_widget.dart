import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import '../controller/profile_three_controller.dart';
import '../models/widget2_item_model.dart';

// ignore: must_be_immutable
class Widget2ItemWidget extends StatelessWidget {
  Widget2ItemWidget(
    this.widget2ItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  Widget2ItemModel widget2ItemModelObj;

  var controller = Get.find<ProfileThreeController>();

  @override
  Widget build(BuildContext context) {
    return CustomImageView(
      imagePath: ImageConstant.imgRectangle17848,
      height: 295.v,
      width: 375.h,
    );
  }
}
