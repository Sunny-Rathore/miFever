import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import '../controller/my_album_controller.dart';

// ignore: must_be_immutable
class AlbumWidget extends StatelessWidget {
  AlbumWidget({
    Key? key,
    required this.onEdit,
    required this.url,
    required this.onDelete,
    required this.index,
  }) : super(key: key);

  String url;
  VoidCallback onEdit;
  var controller = Get.find<MyAlbumController>();
  VoidCallback onDelete;
  int index;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.v,
      width: 95.h,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          CustomImageView(
            //border: ,
            fit: BoxFit.cover,
            imagePath: url,
            height: 100.v,
            width: 95.h,
            radius: BorderRadius.circular(
              10.h,
            ),
            alignment: Alignment.center,
          ),
          Container(
            height: 100.v,
            width: 95.h,
            decoration: BoxDecoration(
                border: Border.all(color: appTheme.redA200, width: 2.v),
                borderRadius: BorderRadius.circular(10.h),
                color: Colors.black.withOpacity(0.2)),
          ),
          CustomImageView(
            onTap: onEdit,
            imagePath: ImageConstant.imgEdit02,
            height: 20.adaptSize,
            width: 20.adaptSize,
            alignment: Alignment.center,
          ),
          Visibility(
            visible: index >= 2,
            child: Positioned(
                right: 0.h,
                top: 0.v,
                child: InkWell(
                  onTap: onDelete,
                  child: Icon(
                    Icons.close,
                    color: appTheme.redA200,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
