import 'widget2_item_model.dart';import 'frametwentythree8_item_model.dart';import 'frametwentythree10_item_model.dart';import '../../../core/app_export.dart';/// This class defines the variables used in the [profile_three_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class ProfileThreeModel {Rx<List<Widget2ItemModel>> widget2ItemList = Rx(List.generate(1,(index) => Widget2ItemModel()));

Rx<List<Frametwentythree8ItemModel>> frametwentythree8ItemList = Rx(List.generate(3,(index) =>Frametwentythree8ItemModel()));

Rx<List<Frametwentythree10ItemModel>> frametwentythree10ItemList = Rx(List.generate(2,(index) =>Frametwentythree10ItemModel()));

 }
