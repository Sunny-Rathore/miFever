import '../../../core/app_export.dart';/// This class is used in the [today2_item_widget] screen.
class Today2ItemModel {Today2ItemModel({this.groupBy, this.id, }) { groupBy = groupBy  ?? Rx("");id = id  ?? Rx(""); }

Rx<String>? groupBy;

Rx<String>? id;

 }
