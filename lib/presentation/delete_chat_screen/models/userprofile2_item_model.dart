import '../../../core/app_export.dart';/// This class is used in the [userprofile2_item_widget] screen.
class Userprofile2ItemModel {Userprofile2ItemModel({this.circleImageElement, this.nameTextElement, this.messageTextElement, this.timeTextElement, this.countTextElement, this.id, }) { circleImageElement = circleImageElement  ?? Rx(ImageConstant.imgEllipse1591);nameTextElement = nameTextElement  ?? Rx("Theresa Webb");messageTextElement = messageTextElement  ?? Rx("Hii.., How are you?");timeTextElement = timeTextElement  ?? Rx("Just now");countTextElement = countTextElement  ?? Rx("1");id = id  ?? Rx(""); }

Rx<String>? circleImageElement;

Rx<String>? nameTextElement;

Rx<String>? messageTextElement;

Rx<String>? timeTextElement;

Rx<String>? countTextElement;

Rx<String>? id;

 }
