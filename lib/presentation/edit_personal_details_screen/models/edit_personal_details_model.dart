import '../../../core/app_export.dart';
import 'profliedetailseditpersonaldeta_item_model.dart';

class EditPersonalDetailsModel {
  static List gender = ['Male', "Female", 'Other'];
  Rx<List<ProfliedetailseditpersonaldetaItemModel>>
      profliedetailseditpersonaldetaItemList = Rx(List.generate(
    gender.length,
    (index) => ProfliedetailseditpersonaldetaItemModel()
      ..title = Rx(gender[index])
      ..isSelected = false.obs,
  ));
}
