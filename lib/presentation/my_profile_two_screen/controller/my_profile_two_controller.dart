import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/my_profile_two_screen/models/my_profile_two_model.dart';

/// A controller class for the MyProfileTwoScreen.
///
/// This class manages the state of the MyProfileTwoScreen, including the
/// current myProfileTwoModelObj
class MyProfileTwoController extends GetxController {
  Rx<MyProfileTwoModel> myProfileTwoModelObj = MyProfileTwoModel().obs;

  Rx<bool> isSelectedSwitch = false.obs;
}
