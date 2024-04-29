import '../../../core/app_export.dart';
import 'frame13_item_model.dart';
import 'notification_item_model.dart';

/// This class defines the variables used in the [liked_me_page],
import 'today_item_model.dart';

/// and is typically used to hold data that is passed between different parts of the application.
class LikedMeModel {
  Rx<List<Frame13ItemModel>> frame13ItemList = Rx([
    Frame13ItemModel(dynamicText: "122".obs, dynamicText1: "Liked Profile".obs),
    Frame13ItemModel(dynamicText: "23".obs, dynamicText1: "Viewed Profile".obs),
    Frame13ItemModel(dynamicText: "12".obs, dynamicText1: "Sent Chat".obs)
  ]);

  Rx<List<TodayItemModel>> todayItemList = Rx([
    TodayItemModel(groupBy: "Today".obs),
    TodayItemModel(groupBy: "Today".obs),
    TodayItemModel(groupBy: "Today".obs),
    TodayItemModel(groupBy: "Yesterday".obs),
    TodayItemModel(groupBy: "Yesterday".obs)
  ]);

  Rx<List<NotificationItemModel>> notificationItemList = Rx([
    NotificationItemModel(
        notificationImage: ImageConstant.imgEllipse159140x40.obs,
        notificationText: "Kane Williamson liked your profile".obs,
        notificationText1: "10%".obs)
  ]);
}
