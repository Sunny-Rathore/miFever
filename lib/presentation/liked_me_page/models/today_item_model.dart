import '../../../core/app_export.dart';/// This class is used in the [today_item_widget] screen.
class TodayItemModel {TodayItemModel({this.groupBy, this.id, }) { groupBy = groupBy  ?? Rx("");id = id  ?? Rx(""); }

Rx<String>? groupBy;

Rx<String>? id;

 }
