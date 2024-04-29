import 'package:mifever/core/app_export.dart';import 'package:mifever/presentation/profile_three_screen/models/profile_three_model.dart';/// A controller class for the ProfileThreeScreen.
///
/// This class manages the state of the ProfileThreeScreen, including the
/// current profileThreeModelObj
class ProfileThreeController extends GetxController {Rx<ProfileThreeModel> profileThreeModelObj = ProfileThreeModel().obs;

Rx<int> sliderIndex = 0.obs;

 }
