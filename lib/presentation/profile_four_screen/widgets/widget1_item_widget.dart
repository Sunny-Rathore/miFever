import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import '../controller/profile_four_controller.dart';
import '../models/widget1_item_model.dart';

// ignore: must_be_immutable
class Widget1ItemWidget extends StatelessWidget {
  Widget1ItemWidget(
    this.widget1ItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  Widget1ItemModel widget1ItemModelObj;

  var controller = Get.find<ProfileFourController>();

  @override
  Widget build(BuildContext context) {
    return CustomImageView(
      imagePath: ImageConstant.imgRectangle17848,
      height: 295.v,
      width: 375.h,
    );
  }
}
