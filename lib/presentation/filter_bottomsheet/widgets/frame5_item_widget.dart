import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import '../models/frame5_item_model.dart';

// ignore: must_be_immutable
class Frame5ItemWidget extends StatelessWidget {
  Frame5ItemWidget(
    this.frame5ItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  Frame5ItemModel frame5ItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Theme(
        data: ThemeData(
          canvasColor: Colors.transparent,
        ),
        child: RawChip(
          padding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 8.v,
          ),
          showCheckmark: false,
          labelPadding: EdgeInsets.zero,
          label: Text(
            frame5ItemModelObj.man!.value,
            style: TextStyle(
              color: (frame5ItemModelObj.isSelected?.value ?? false)
                  ? theme.colorScheme.primary
                  : appTheme.gray60004,
              fontSize: 14.fSize,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
            ),
          ),
          selected: (frame5ItemModelObj.isSelected?.value ?? false),
          backgroundColor: Colors.transparent,
          selectedColor: appTheme.redA200,
          shape: (frame5ItemModelObj.isSelected?.value ?? false)
              ? RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(
                    18.h,
                  ),
                )
              : RoundedRectangleBorder(
                  side: BorderSide(
                    color: appTheme.gray200,
                    width: 1.h,
                  ),
                  borderRadius: BorderRadius.circular(
                    18.h,
                  ),
                ),
          onSelected: (value) {
            frame5ItemModelObj.isSelected!.value = value;
          },
        ),
      ),
    );
  }
}
