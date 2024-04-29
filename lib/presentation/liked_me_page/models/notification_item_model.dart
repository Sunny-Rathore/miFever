import '../../../core/app_export.dart';

/// This class is used in the [notification_item_widget] screen.
class NotificationItemModel {
  NotificationItemModel({
    this.notificationImage,
    this.notificationText,
    this.notificationText1,
    this.time,
    this.id,
  }) {
    notificationImage =
        notificationImage ?? Rx(ImageConstant.imgEllipse159140x40);
    notificationText =
        notificationText ?? Rx("Kane Williamson liked your profile");
    notificationText1 = notificationText1 ?? Rx("10%");
    time = time ?? Rx("");
    id = id ?? Rx("");
  }

  Rx<String>? notificationImage;

  Rx<String>? notificationText;

  Rx<String>? notificationText1;

  Rx<String>? time;

  Rx<String>? id;
}
