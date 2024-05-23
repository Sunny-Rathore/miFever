import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/models/thermometer_model/thermometer_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';

import '../../../data/models/like/like_model.dart';
import '../../../widgets/thermometer_cold.dart';
import '../../../widgets/thermometer_widget.dart';
import '../../profile_screen/profile_screen.dart';
import '../controller/liked_me_controller.dart';
import '../models/notification_item_model.dart';

// ignore: must_be_immutable
class NotificationItemWidget extends StatelessWidget {
  NotificationItemWidget(
    this.notificationItemModelObj, {
    Key? key,
  }) : super(key: key);

  NotificationItemModel notificationItemModelObj;

  var controller = Get.find<LikedMeController>();

  @override
  Widget build(BuildContext context) {
    print(notificationItemModelObj.id);
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseServices.getThermometerValueAsStream(
            notificationItemModelObj.id!.value),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox.shrink();
          }
          var snapShotData = snapshot.data;
          ThermometerModel thermometerModel = ThermometerModel(
              timestamp: DateTime.now().toString(),
              roomId: '',
              percentageValue: 0);
          if (snapShotData!.data() != null) {
            thermometerModel = ThermometerModel.fromJson(
                snapShotData.data() as Map<String, dynamic>);
          }

          return InkWell(
            onTap: () async {
              bool isAccountDeleted =
                  await FirebaseServices.getIsAccountDeleted(
                      notificationItemModelObj.id!.value);

              bool isDeleted =
                  await getIsDeleted(notificationItemModelObj.id!.value);
              print(isDeleted);
              if (!isDeleted && !isAccountDeleted) {
                Get.to(() => ProfileScreen(notificationItemModelObj.id!.value));
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(
                  () => CustomImageView(
                    imagePath:
                        notificationItemModelObj.notificationImage!.value,
                    height: 40.h,
                    width: 40.v,
                    fit: BoxFit.cover,
                    radius: BorderRadius.circular(
                      20.h,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 8.h,
                    top: 11.v,
                    bottom: 8.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 210.v),
                        child: Text(
                          notificationItemModelObj.notificationText!.value,
                          style: theme.textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        notificationItemModelObj.time == null
                            ? DateTime.now().toLocal().toString()
                            : getTimeAgo(DateTime.parse(
                                notificationItemModelObj.time?.value ?? '')),
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                // _thermoWidget(notificationItemModelObj.id!.value),
                SizedBox(
                    height: 40.v,
                    width: 19.h,
                    child: thermometerModel.percentageValue == 0
                        ? ThermoTestCold(
                            value: thermometerModel.percentageValue.toDouble() /
                                100)
                        : ThermoTest(
                            value: thermometerModel.percentageValue.toDouble() /
                                100)),
                Padding(
                  padding: EdgeInsets.only(
                    left: 4.h,
                    top: 6.v,
                    bottom: 16.v,
                  ),
                  child: Text(
                    thermometerModel.percentageValue.toString() + '%',
                    //notificationItemModelObj.notificationText1!.value,
                    style: theme.textTheme.labelLarge,
                  ),
                ),
              ],
            ),
          );
        });
  }
}

Future<bool> getIsDeleted(String receiverId) async {
  return await FirebaseServices.getAllMatchedDataByUserId(receiverId)
      .then((value) {
    if (value != null) {
      LikeModel likeData = LikeModel();
      likeData = value;
      print("likeData=> ${likeData.isDeleted}");
      return likeData.isDeleted ?? false;
    } else {
      return false;
    }
  });
}
