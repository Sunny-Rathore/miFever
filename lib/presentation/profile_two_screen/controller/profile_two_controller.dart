import 'package:mifever/core/app_export.dart';import 'package:mifever/presentation/profile_two_screen/models/profile_two_model.dart';/// A controller class for the ProfileTwoScreen.
///
/// This class manages the state of the ProfileTwoScreen, including the
/// current profileTwoModelObj
class ProfileTwoController extends GetxController {Rx<ProfileTwoModel> profileTwoModelObj = ProfileTwoModel().obs;

Rx<int> sliderIndex = 0.obs;

 }
