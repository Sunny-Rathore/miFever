import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../video_player/video_player.dart';
import '../models/chat_model.dart';

class VideoMessageWidget extends StatefulWidget {
  const VideoMessageWidget({Key? key, required this.chat}) : super(key: key);

  final ChatModel chat;

  @override
  State<VideoMessageWidget> createState() => _VideoMessageWidgetState();
}

class _VideoMessageWidgetState extends State<VideoMessageWidget> {
  // Uint8List? thumbnailData;

  // @override
  // void initState() {
  //   super.initState();
  //   generateThumbnail(widget.chat.url!).then((data) {
  //     setState(() {
  //       thumbnailData = data;
  //     });
  //   });
  // }

  Widget build(BuildContext context) {
    return Align(
        alignment: widget.chat.senderId == PrefUtils.getId()
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: widget.chat.thumbnailUrl!.isEmpty
            ? loadingWidget()
            : Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: SizeUtils.width * 0.4,
                    height: 160.adaptSize,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.chat.thumbnailUrl ?? '')),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: widget.chat.senderId == PrefUtils.getId()
                              ? appTheme.redA200
                              : appTheme.red50,
                          width: 1.v),
                      // borderRadius: BorderRadius.circular(10.fSize),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => VideoPlayerView(
                            url: widget.chat.url!,
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.all(5.v),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: appTheme.redA200),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
        //: loadingWidget(),
        );
  }

  Widget loadingWidget() {
    return Container(
      alignment: Alignment.center,
      width: SizeUtils.width * 0.4,
      height: 160.adaptSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: widget.chat.senderId == PrefUtils.getId()
                ? appTheme.redA200
                : appTheme.red50,
            width: 1.v),
        // borderRadius: BorderRadius.circular(10.fSize),
      ),
      child: CircularProgressIndicator(
        backgroundColor: appTheme.redA200,
      ),
    );
  }

  // Future<Uint8List?> generateThumbnail(String videoUrl) async {

  //   Uint8List? thumbnailData;
  //   try {
  //     thumbnailData = await VideoThumbnail.thumbnailData(
  //       video: videoUrl,
  //       imageFormat: ImageFormat.JPEG,
  //       maxWidth: 200, // Adjust the thumbnail width as needed
  //       quality: 25, // Adjust the thumbnail quality as needed
  //     );
  //   } catch (e) {
  //     print('Error generating thumbnail: $e');
  //   }
  //   return thumbnailData;
  // }
}
