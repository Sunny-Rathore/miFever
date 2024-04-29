import '../../../core/app_export.dart';/// This class is used in the [userprofile5_item_widget] screen.
class Userprofile5ItemModel {Userprofile5ItemModel({this.amount, this.duration, this.savings, this.id, }) { amount = amount  ?? Rx(" 20");duration = duration  ?? Rx("3 months");savings = savings  ?? Rx("20% Save");id = id  ?? Rx(""); }

Rx<String>? amount;

Rx<String>? duration;

Rx<String>? savings;

Rx<String>? id;

 }
