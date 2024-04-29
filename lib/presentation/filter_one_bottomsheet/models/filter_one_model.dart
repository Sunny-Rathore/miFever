import 'frame3_item_model.dart';import '../../../core/app_export.dart';/// This class defines the variables used in the [filter_one_bottomsheet],
/// and is typically used to hold data that is passed between different parts of the application.
class FilterOneModel {Rx<List<SelectionPopupModel>> dropdownItemList = Rx([SelectionPopupModel(id:1,title:"Item One",isSelected:true,),SelectionPopupModel(id:2,title:"Item Two",),SelectionPopupModel(id:3,title:"Item Three",)]);

Rx<List<Frame3ItemModel>> frame3ItemList = Rx(List.generate(3,(index) =>Frame3ItemModel()));

 }
