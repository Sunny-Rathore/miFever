import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/onboarding_screen/models/onboarding_model.dart';

class OnboardingController extends GetxController {
  Rx<OnboardingModel> onboardingModelObj = OnboardingModel().obs;
  var isAgree = false.obs;
  // @override
  // void onInit() {
  //   if (PrefUtils.getId().isNotEmpty) {
  //     FirebaseServices.getCurrentUser().then((user) {
  //       if (user != null) {
  //         if (user.isProfileComplete ?? false) {
  //           Get.offAll(() => CustomBottomBar());
  //         } else {
  //           Get.offAllNamed(AppRoutes.questionOneScreen);
  //         }
  //       }
  //     });
  //   } else {
  //     // Get.offNamed(
  //     //   AppRoutes.onboardingScreen,
  //     // );
  //   }
  //   super.onInit();
  // }
}
