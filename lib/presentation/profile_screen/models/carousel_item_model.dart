import '../../../core/app_export.dart';

class CarouselItemModel {
  CarouselItemModel({this.id, this.url}) {
    id = id ?? Rx("");
    url = url ?? Rx('');
  }

  Rx<String>? id;
  Rx<String>? url;
}
