import '../../../core/app_export.dart';
import 'userprofile1_item_model.dart';

/// This class defines the variables used in the [my_chats_one_page],
/// and is typically used to hold data that is passed between different parts of the application.
class MyChatsOneModel {
  Rx<List<Userprofile1ItemModel>> userprofile1ItemList = Rx([
    Userprofile1ItemModel(
        userImage: ImageConstant.imgEllipse1591.obs,
        username: "Theresa Webb".obs,
        greeting: "Hii.., How are you?".obs,
        timestamp: "Just now".obs,
        notificationCount: "1".obs),
    Userprofile1ItemModel(
        userImage: ImageConstant.imgEllipse159148x48.obs,
        username: "Darlene Robertson".obs,
        greeting: "What's going on?".obs,
        timestamp: "10 min ago".obs,
        notificationCount: "2".obs),
    Userprofile1ItemModel(
        userImage: ImageConstant.imgEllipse15911.obs,
        username: "Robert Fox".obs,
        greeting: "Share You Location".obs),
    Userprofile1ItemModel(
        userImage: ImageConstant.imgEllipse15912.obs,
        username: "Albert Flores".obs,
        greeting: "Wonna go  outside Someday?".obs),
    Userprofile1ItemModel(
        userImage: ImageConstant.imgEllipse15913.obs,
        username: "Cody Fisher".obs,
        greeting: "Share You Location".obs),
    Userprofile1ItemModel(
        userImage: ImageConstant.imgEllipse15914.obs,
        username: "Darrell Steward".obs,
        greeting: "Okay.".obs),
    Userprofile1ItemModel(
        userImage: ImageConstant.imgEllipse15915.obs,
        username: "Jenny Wilson".obs,
        greeting: "Wann go  outside Someday?".obs),
    Userprofile1ItemModel(
        userImage: ImageConstant.imgEllipse15915.obs,
        username: "Jenny Wilson".obs,
        greeting: "Wonna go  outside Someday?".obs)
  ]);
}
