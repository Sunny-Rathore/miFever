import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/chat_screen/chat_screen.dart';

import '../../chat_screen/widgets/image_message_widget.dart';
import '../controller/my_chats_one_controller.dart';
import '../models/userprofile1_item_model.dart';

// ignore: must_be_immutable
class Userprofile1ItemWidget extends StatelessWidget {
  Userprofile1ItemWidget(this.userprofile1ItemModelObj, {Key? key})
      : super(key: key);

  Userprofile1ItemModel userprofile1ItemModelObj;

  var controller = Get.find<MyChatsOneController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        controller.selectedUser.add(userprofile1ItemModelObj.id!.value);
        controller.isSelected.value = true;
      },
      onTap: () {
        controller.clearSearchBar();
        if (controller.isSelected.value) {
          if (controller.selectedUser
              .contains(userprofile1ItemModelObj.id!.value)) {
            controller.selectedUser.remove(userprofile1ItemModelObj.id!.value);
          } else {
            controller.selectedUser.add(userprofile1ItemModelObj.id!.value);
          }
        } else {
          Get.to(() => ChatScreen(userprofile1ItemModelObj.id!.value));
        }
      },
      child: Obx(
        () => Container(
          padding: controller.isSelected.value
              ? EdgeInsets.symmetric(vertical: 8.v, horizontal: 8.v)
              : EdgeInsets.only(left: 16.h, bottom: 8.v, right: 16.v),
          decoration: controller.selectedUser
                  .contains(userprofile1ItemModelObj.id!.value)
              ? AppDecoration.fillRed
              : null,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Visibility(
                        visible: controller.isSelected.value,
                        child: Radio(
                            value: controller.selectedUser
                                .contains(userprofile1ItemModelObj.id!.value),
                            groupValue: true,
                            onChanged: (val) {})),
                  ),
                  Obx(
                    () => CustomImageView(
                      onTap: () {
                        Get.to(() => ViewImageWidget(
                              url: userprofile1ItemModelObj.userImage!.value,
                            ));
                      },
                      imagePath: userprofile1ItemModelObj.userImage!.value,
                      height: 48.adaptSize,
                      width: 48.adaptSize,
                      radius: BorderRadius.circular(
                        24.h,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 12.h,
                      top: 2.v,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            userprofile1ItemModelObj.username!.value,
                            style: CustomTextStyles.titleMediumBlack900,
                          ),
                        ),
                        SizedBox(height: 4.v),
                        Obx(
                          () => Text(
                            userprofile1ItemModelObj.greeting!.value,
                            style: userprofile1ItemModelObj
                                    .notificationCount!.value.isEmpty
                                ? CustomTextStyles.bodyMediumGray900
                                : CustomTextStyles.bodyMediumRedA200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.v),
                    child: Column(
                      children: [
                        Obx(
                          () => Text(
                            userprofile1ItemModelObj.timestamp!.value,
                            style: theme.textTheme.labelMedium,
                          ),
                        ),
                        SizedBox(height: 5.v),
                        Visibility(
                          visible: userprofile1ItemModelObj
                              .notificationCount!.value.isNotEmpty,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              alignment: Alignment.center,
                              // width: 25.adaptSize,
                              padding: EdgeInsets.symmetric(
                                horizontal: 7.h,
                                vertical: 1.v,
                              ),
                              decoration: AppDecoration.fillRedA.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder9,
                              ),
                              child: Obx(
                                () => Text(
                                  userprofile1ItemModelObj
                                      .notificationCount!.value,
                                  style: CustomTextStyles.labelMediumPrimary_1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: !controller.isSelected.value,
                child: Column(
                  children: [SizedBox(height: 5.v), Divider()],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
