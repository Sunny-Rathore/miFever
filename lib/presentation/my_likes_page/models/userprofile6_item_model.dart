import '../../../core/app_export.dart';/// This class is used in the [userprofile6_item_widget] screen.
class Userprofile6ItemModel {Userprofile6ItemModel({this.userImage, this.userName, this.likedImage, this.likePercentage, this.id, }) { userImage = userImage  ?? Rx(ImageConstant.imgEllipse159140x40);userName = userName  ?? Rx("You liked Kane Williamson Profile");likedImage = likedImage  ?? Rx(ImageConstant.imgGroup63Red50);likePercentage = likePercentage  ?? Rx("10%");id = id  ?? Rx(""); }

Rx<String>? userImage;

Rx<String>? userName;

Rx<String>? likedImage;

Rx<String>? likePercentage;

Rx<String>? id;

 }
