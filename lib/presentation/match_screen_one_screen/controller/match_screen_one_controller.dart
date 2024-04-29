import 'dart:async';

import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/match_screen_one_screen/models/match_screen_one_model.dart';
import 'package:vibration/vibration.dart';

class MatchScreenOneController extends GetxController {
  Rx<MatchScreenOneModel> matchScreenOneModelObj = MatchScreenOneModel().obs;
  late Timer _timer;
  RxInt elapsedSeconds = 3.obs;
  void startTime() async {
    String receiverId = Get.arguments[0];
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      elapsedSeconds.value--;
      if (elapsedSeconds.value == 0) {
        _timer.cancel();
        _triggerHapticFeedback();
        Get.offNamed(AppRoutes.matchScreenTwoScreen, arguments: [receiverId]);
      }
    });
  }

  void _triggerHapticFeedback() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(
          duration: 250, amplitude: 528); // Duration in milliseconds
    }
  }

  @override
  void onReady() {
    startTime();
    super.onReady();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
