import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/splash_screen/models/splash_model.dart';

import '../../../data/sevices/firebase_services.dart';
import '../../../widgets/custom_bottom_bar.dart';

class SplashController extends GetxController {
  Rx<SplashModel> splashModelObj = SplashModel().obs;

  @override
  void onReady() {
    Future.delayed(Duration(seconds: 6), () {
      if (PrefUtils.getId().isNotEmpty) {
        FirebaseServices.getCurrentUser().then((user) {
          if (user != null) {
            if (user.isProfileComplete ?? false) {
              Get.offAll(() => CustomBottomBar());
            } else {
              Get.offAllNamed(AppRoutes.questionOneScreen);
            }
          }
        });
      } else {
        Get.offNamed(
          AppRoutes.onboardingScreen,
        );
      }
    });
    // }
  }
}
