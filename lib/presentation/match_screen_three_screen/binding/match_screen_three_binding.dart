import '../controller/match_screen_three_controller.dart';
import 'package:get/get.dart';

/// A binding class for the MatchScreenThreeScreen.
///
/// This class ensures that the MatchScreenThreeController is created when the
/// MatchScreenThreeScreen is first loaded.
class MatchScreenThreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MatchScreenThreeController());
  }
}
