import 'widget1_item_model.dart';import 'frametwentythree4_item_model.dart';import 'frametwentythree6_item_model.dart';import '../../../core/app_export.dart';/// This class defines the variables used in the [profile_four_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class ProfileFourModel {Rx<List<Widget1ItemModel>> widget1ItemList = Rx(List.generate(1,(index) => Widget1ItemModel()));

Rx<List<Frametwentythree4ItemModel>> frametwentythree4ItemList = Rx(List.generate(3,(index) =>Frametwentythree4ItemModel()));

Rx<List<Frametwentythree6ItemModel>> frametwentythree6ItemList = Rx(List.generate(2,(index) =>Frametwentythree6ItemModel()));

 }
