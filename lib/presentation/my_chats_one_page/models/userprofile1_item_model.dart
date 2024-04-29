import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/app_export.dart';

/// This class is used in the [userprofile1_item_widget] screen.
class Userprofile1ItemModel {
  Userprofile1ItemModel({
    this.userImage,
    this.username,
    this.greeting,
    this.timestamp,
    this.notificationCount,
    this.id,
  }) {
    userImage = userImage ?? Rx(ImageConstant.imgEllipse1591);
    username = username ?? Rx("Theresa Webb");
    greeting = greeting ?? Rx("Hii.., How are you?");
    timestamp = timestamp ?? Rx("Just now");
    notificationCount = notificationCount ?? Rx("1");
    lastOnline = lastOnline ?? Rx(Timestamp.now());
    id = id ?? Rx("");
  }
  Rx<Timestamp>? lastOnline;

  Rx<String>? userImage;

  Rx<String>? username;

  Rx<String>? greeting;

  Rx<String>? timestamp;

  Rx<String>? notificationCount;

  Rx<String>? id;
}
