import 'package:flutter/material.dart';
import 'package:mifever/data/sevices/helper_services.dart';
import 'package:mifever/presentation/chat_screen/models/chat_model.dart';
import 'package:translator_plus/translator_plus.dart';

import '../../../core/app_export.dart';
import '../controller/chat_controller.dart';
import '../models/translation_model.dart';

class TextMessageWidget extends StatelessWidget {
  TextMessageWidget({Key? key, required this.chat}) : super(key: key);
  final ChatModel chat;
  final controller = Get.find<ChatController>();
  @override
  Widget build(BuildContext context) {
    if (chat.senderId == PrefUtils.getId()) {
      return _buildRightChat();
    }
    return _buildLeftChat();
  }

  getChatMessage(elementId, message) {
    var item = controller.translationList
        .firstWhereOrNull((element) => element.id == elementId);
    if (item == null) {
      return message;
    } else {
      return item.text;
    }
  }

  Column _buildLeftChat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.all(10.v),
            decoration: AppDecoration.fillRed.copyWith(
              borderRadius: BorderRadiusStyle.customBorderTL12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 1.v),
                Container(
                  margin: EdgeInsets.only(right: 19.h),
                  child: Obx(
                    () => Text(
                      getChatMessage(chat.dcoId, chat.message ?? ""),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall!.copyWith(
                        height: 1.43,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 2.v),
        Padding(
          padding: EdgeInsets.only(left: 5.h),
          child: Text(
            Helpers.formatTime(chat.timestamp ?? ''),
            style: CustomTextStyles.bodySmall11,
          ),
        ),
        SizedBox(height: 3.v),
        InkWell(
          onTap: () {
            if (controller.translationList
                    .firstWhereOrNull((element) => element.id == chat.dcoId) !=
                null) {
              controller.translationList
                  .removeWhere((element) => element.id == chat.dcoId);
            } else {
              final translator = GoogleTranslator();
              translator
                  .translate(chat.message ?? '', to: PrefUtils.getLang())
                  .then((s) {
                controller.translationList
                    .add(TranslationModel(id: chat.dcoId!, text: s.text));
                controller.translationList.length;
              });
            }
          },
          child: Obx(
            () => Text(
              controller.translationList.firstWhereOrNull(
                          (element) => element.id == chat.dcoId) !=
                      null
                  ? "msg_text_translated".tr
                  : "lbl_see_translation".tr,
              style: CustomTextStyles.labelMediumRedA200,
            ),
          ),
        ),
      ],
    );
  }

  Column _buildRightChat() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: EdgeInsets.only(left: 180.h),
            padding: EdgeInsets.symmetric(
              horizontal: 12.h,
              vertical: 6.v,
            ),
            decoration: AppDecoration.fillRedA.copyWith(
              borderRadius: BorderRadiusStyle.customBorderTL8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 3.v),
                Text(
                  chat.message ?? '',
                  style: CustomTextStyles.titleSmallGray100,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 4.v),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            Helpers.formatTime(chat.timestamp ?? ''),
            style: CustomTextStyles.bodySmall11,
          ),
        ),
      ],
    );
  }
}
