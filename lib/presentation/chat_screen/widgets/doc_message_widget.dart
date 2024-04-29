import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/chat_screen/models/chat_model.dart';
import 'package:mifever/presentation/chat_screen/widgets/image_message_widget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/utils/progress_dialog_utils.dart';

class DocMessageWidget extends StatelessWidget {
  const DocMessageWidget({Key? key, required this.chat}) : super(key: key);
  final ChatModel chat;
  @override
  Widget build(BuildContext context) {
    return isImage(chat.fileExtension!)
        ? ImageMessageWidget(chat: chat)
        : docsWidget(chat);
  }

  Widget docsWidget(ChatModel chat) {
    return Align(
      alignment: chat.senderId == PrefUtils.getId()
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
          decoration: BoxDecoration(
              color: chat.senderId == PrefUtils.getId()
                  ? appTheme.redA200
                  : appTheme.red50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              )),
          width: SizeUtils.width * 0.6,
          height: 60.v,
          padding: EdgeInsets.symmetric(horizontal: 10.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(chat.fileName!,
                        style: theme.textTheme.titleSmall!.copyWith(
                            color: chat.senderId == PrefUtils.getId()
                                ? appTheme.gray100
                                : null,
                            overflow: TextOverflow.ellipsis)),
                  ),
                  SizedBox(
                    width: 20.h,
                  ),
                  chat.url!.isEmpty
                      ? SizedBox(
                          width: 10.h,
                          height: 10.h,
                          child: CircularProgressIndicator(
                            color: appTheme.redA200,
                            backgroundColor: Colors.white,
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            print('${chat.fileName}');

                            try {
                              print("downloadURL" + chat.url!);
                              ProgressDialogUtils.showProgressDialog();
                              await FileDownloader.downloadFile(
                                url: chat.url ?? '',
                                name: '${chat.fileName}',
                                notificationType: NotificationType.all,
                                downloadDestination:
                                    DownloadDestinations.appFiles,
                              );
                              ProgressDialogUtils.hideProgressDialog();
                            } catch (e) {
                              ProgressDialogUtils.hideProgressDialog();
                              print('error :$e');
                            }
                            //await downloadFile(chat.url, chat.fileName);
                          },
                          child: CircleAvatar(
                              backgroundColor:
                                  chat.senderId == PrefUtils.getId()
                                      ? appTheme.redA200
                                      : appTheme.red50,
                              child: Icon(
                                Icons.download,
                                color: chat.senderId == PrefUtils.getId()
                                    ? Colors.white
                                    : appTheme.redA200,
                              )),
                        )
                ],
              ),
              SizedBox(height: 12.h),
            ],
          )),
    );
  }

  downloadFile(docUrl, fileName) async {
    final dio = Dio();
    var filePath = await _getFilePath();
    final response = await dio.download(docUrl, filePath,
        onReceiveProgress: (received, total) {});
    Get.rawSnackbar(
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.green.shade300,
        icon: Icon(Icons.done, color: Colors.white),
        title: 'Success',
        message: 'downloaded successfully',
        mainButton: TextButton(
          onPressed: () async {
            try {
              await OpenFile.open(filePath);
            } catch (e) {
              print('e=>$e');
            }
          },
          child: const Text(
            'Open',
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  Future<String> _getFilePath() async {
    if (Platform.isIOS) {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      return '${documentsDirectory.path}/yourFile.pdf'; // Replace with your desired file name
    } else {
      Directory dir;
      dir = Directory('/storage/emulated/0/Download/');
      return '${dir.path}/yourFile.pdf';
    }
  }
}

isImage(String fileExtension) {
  List imageExtensions = ['.image', '.jpg', '.png', '.jpeg', '.gif'];
  return imageExtensions.contains(fileExtension.toLowerCase());
}
