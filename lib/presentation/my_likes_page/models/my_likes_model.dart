import 'today2_item_model.dart';import '../../../core/app_export.dart';import 'userprofile6_item_model.dart';/// This class defines the variables used in the [my_likes_page],
/// and is typically used to hold data that is passed between different parts of the application.
class MyLikesModel {Rx<List<Today2ItemModel>> today2ItemList = Rx([Today2ItemModel(groupBy: "Today".obs),Today2ItemModel(groupBy: "Today".obs),Today2ItemModel(groupBy: "Today".obs),Today2ItemModel(groupBy: "Yesterday".obs),Today2ItemModel(groupBy: "Yesterday".obs)]);

Rx<List<Userprofile6ItemModel>> userprofile6ItemList = Rx([Userprofile6ItemModel(userImage:ImageConstant.imgEllipse159140x40.obs,userName: "You liked Kane Williamson Profile".obs,likedImage:ImageConstant.imgGroup63Red50.obs,likePercentage: "10%".obs),Userprofile6ItemModel(userName: "You sent message to Tom cooper.".obs,likedImage:ImageConstant.imgGroup63Red50.obs,likePercentage: "30%".obs)]);

 }
