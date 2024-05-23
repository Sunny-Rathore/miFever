import 'package:flutter/material.dart';
import 'package:mifever/presentation/chat_screen/models/chat_model.dart';
import 'package:photo_view/photo_view.dart';

import '../../../core/app_export.dart';
import '../../../data/sevices/helper_services.dart';

class ImageMessageWidget extends StatelessWidget {
  const ImageMessageWidget({Key? key, required this.chat}) : super(key: key);
  final ChatModel chat;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: chat.senderId == PrefUtils.getId()
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: chat.url!.isEmpty
          ? loadingWidget()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  onTap: () {
                    Get.to(() => ViewImageWidget(url: chat.url!));
                  },
                  border: Border.all(
                      color: chat.senderId == PrefUtils.getId()
                          ? appTheme.redA200
                          : appTheme.red50,
                      width: 1.v),
                  radius: BorderRadius.circular(5.fSize),
                  width: SizeUtils.width * 0.4,
                  height: 160.adaptSize,
                  fit: BoxFit.contain,
                  imagePath: chat.url,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.h),
                  child: Text(
                    Helpers.formatTime(chat.timestamp ?? ''),
                    style: CustomTextStyles.bodySmall11,
                  ),
                ),
              ],
            ),
    );
  }

  Widget loadingWidget() {
    return Container(
      alignment: Alignment.center,
      width: SizeUtils.width * 0.4,
      height: 160.adaptSize,
      decoration: BoxDecoration(
        border: Border.all(
            color: chat.senderId == PrefUtils.getId()
                ? appTheme.redA200
                : appTheme.red50,
            width: 5.v),
        borderRadius: BorderRadius.circular(5.fSize),
      ),
      child: CircularProgressIndicator(
        backgroundColor: appTheme.redA200,
      ),
    );
  }
}

class ViewImageWidget extends StatelessWidget {
  ViewImageWidget({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: NetworkImage(url),
    );
  }
}
