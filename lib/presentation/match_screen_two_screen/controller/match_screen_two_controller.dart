import 'dart:async';

import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/match_screen_two_screen/models/match_screen_two_model.dart';

import '../../../widgets/custom_bottom_bar.dart';

class MatchScreenTwoController extends GetxController {
  Rx<MatchScreenTwoModel> matchScreenTwoModelObj = MatchScreenTwoModel().obs;

  late Timer _timer;
  RxInt elapsedSeconds = 10.obs;

  void startTime() async {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      elapsedSeconds.value--;
      if (elapsedSeconds.value == 0) {
        _timer.cancel();
        // Get.back();
        Get.offAll(() => CustomBottomBar());
      }
    });
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
