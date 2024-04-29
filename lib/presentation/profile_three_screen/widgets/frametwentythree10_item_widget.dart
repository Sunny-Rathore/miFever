import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import '../models/frametwentythree10_item_model.dart';

// ignore: must_be_immutable
class Frametwentythree10ItemWidget extends StatelessWidget {
  Frametwentythree10ItemWidget(
    this.frametwentythree10ItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  Frametwentythree10ItemModel frametwentythree10ItemModelObj;

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
          frametwentythree10ItemModelObj.madridEupore!.value,
          style: TextStyle(
            color: appTheme.gray900,
            fontSize: 14.fSize,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
          ),
        ),
        selected: (frametwentythree10ItemModelObj.isSelected?.value ?? false),
        backgroundColor: appTheme.red50,
        selectedColor: appTheme.red50,
        shape: (frametwentythree10ItemModelObj.isSelected?.value ?? false)
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
          frametwentythree10ItemModelObj.isSelected!.value = value;
        },
      ),
    );
  }
}
