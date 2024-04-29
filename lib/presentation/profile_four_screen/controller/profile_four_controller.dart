import 'package:mifever/core/app_export.dart';import 'package:mifever/presentation/profile_four_screen/models/profile_four_model.dart';/// A controller class for the ProfileFourScreen.
///
/// This class manages the state of the ProfileFourScreen, including the
/// current profileFourModelObj
class ProfileFourController extends GetxController {Rx<ProfileFourModel> profileFourModelObj = ProfileFourModel().obs;

Rx<int> sliderIndex = 0.obs;

 }
