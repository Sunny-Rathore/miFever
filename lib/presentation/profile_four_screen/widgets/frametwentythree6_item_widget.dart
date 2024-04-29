import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import '../models/frametwentythree6_item_model.dart';

// ignore: must_be_immutable
class Frametwentythree6ItemWidget extends StatelessWidget {
  Frametwentythree6ItemWidget(
    this.frametwentythree6ItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  Frametwentythree6ItemModel frametwentythree6ItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RawChip(
        padding: EdgeInsets.symmetric(
          horizontal: 16.h,
          vertical: 8.v,
        ),
        showCheckmark: false,
        labelPadding: EdgeInsets.zero,
        label: Text(
          frametwentythree6ItemModelObj.madridEupore!.value,
          style: TextStyle(
            color: appTheme.gray900,
            fontSize: 14.fSize,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
          ),
        ),
        selected: (frametwentythree6ItemModelObj.isSelected?.value ?? false),
        backgroundColor: appTheme.red50,
        selectedColor: appTheme.red50,
        shape: (frametwentythree6ItemModelObj.isSelected?.value ?? false)
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
          frametwentythree6ItemModelObj.isSelected!.value = value;
        },
      ),
    );
  }
}
