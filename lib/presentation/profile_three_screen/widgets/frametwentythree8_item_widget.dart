import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import '../models/frametwentythree8_item_model.dart';

// ignore: must_be_immutable
class Frametwentythree8ItemWidget extends StatelessWidget {
  Frametwentythree8ItemWidget(
    this.frametwentythree8ItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  Frametwentythree8ItemModel frametwentythree8ItemModelObj;

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
          frametwentythree8ItemModelObj.gamecontrollerThree!.value,
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
        selected: (frametwentythree8ItemModelObj.isSelected?.value ?? false),
        backgroundColor: appTheme.red50,
        selectedColor: appTheme.red50,
        shape: (frametwentythree8ItemModelObj.isSelected?.value ?? false)
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
          frametwentythree8ItemModelObj.isSelected!.value = value;
        },
      ),
    );
  }
}
