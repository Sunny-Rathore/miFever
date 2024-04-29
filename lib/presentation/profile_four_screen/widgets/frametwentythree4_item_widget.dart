import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import '../models/frametwentythree4_item_model.dart';

// ignore: must_be_immutable
class Frametwentythree4ItemWidget extends StatelessWidget {
  Frametwentythree4ItemWidget(
    this.frametwentythree4ItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  Frametwentythree4ItemModel frametwentythree4ItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RawChip(
        padding: EdgeInsets.only(
          top: 8.v,
          right: 16.h,
          bottom: 8.v,
        ),
        showCheckmark: false,
        labelPadding: EdgeInsets.zero,
        label: Text(
          frametwentythree4ItemModelObj.gamecontrollerThree!.value,
          style: TextStyle(
            color: appTheme.gray900,
            fontSize: 14.fSize,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
          ),
        ),
        avatar: CustomImageView(
          imagePath: ImageConstant.imgGameController03Gray900,
          height: 16.v,
          width: 15.h,
          margin: EdgeInsets.only(right: 6.h),
        ),
        selected: (frametwentythree4ItemModelObj.isSelected?.value ?? false),
        backgroundColor: appTheme.red50,
        selectedColor: appTheme.red50,
        shape: (frametwentythree4ItemModelObj.isSelected?.value ?? false)
            ? RoundedRectangleBorder(
                side: BorderSide(
                  color: appTheme.gray900.withOpacity(0.6),
                  width: 1.h,
                ),
                borderRadius: BorderRadius.circular(
                  18.h,
                ),
              )
            : RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  18.h,
                ),
              ),
        onSelected: (value) {
          frametwentythree4ItemModelObj.isSelected!.value = value;
        },
      ),
    );
  }
}
