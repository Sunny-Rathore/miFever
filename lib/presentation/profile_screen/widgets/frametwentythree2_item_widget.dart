import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import '../models/frametwentythree2_item_model.dart';

// ignore: must_be_immutable
class Frametwentythree2ItemWidget extends StatelessWidget {
  Frametwentythree2ItemWidget(
    this.frametwentythree2ItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  Frametwentythree2ItemModel frametwentythree2ItemModelObj;

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
          frametwentythree2ItemModelObj.madridEupore!.value,
          style: TextStyle(
            color: appTheme.gray900,
            fontSize: 14.fSize,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: appTheme.red50,
        selectedColor: appTheme.red50,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: appTheme.gray900.withOpacity(0.6),
            width: 1.h,
          ),
          borderRadius: BorderRadius.circular(
            18.h,
          ),
        ),
      ),
    );
  }
}
