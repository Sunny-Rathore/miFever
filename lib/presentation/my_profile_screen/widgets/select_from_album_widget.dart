import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import '../../../core/utils/progress_dialog_utils.dart';
import '../../../data/sevices/crop_Image_service.dart';

class SelectFromAlbum extends StatelessWidget {
  SelectFromAlbum({Key? key, required this.album}) : super(key: key);
  final List album;
  final _cropController = CropController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        itemCount: album.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(0.0.h),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black),
                      right: index.isEven
                          ? BorderSide(color: Colors.black)
                          : BorderSide(color: Colors.white))),
              child: CustomImageView(
                onTap: () {
                  ProgressDialogUtils.showProgressDialog();
                  CropImageService.cropAlbumImage(
                      cropController: _cropController, url: album[index]);
                },
                imagePath: album[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
