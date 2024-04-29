import '../controller/match_screen_two_controller.dart';
import 'package:get/get.dart';

/// A binding class for the MatchScreenTwoScreen.
///
/// This class ensures that the MatchScreenTwoController is created when the
/// MatchScreenTwoScreen is first loaded.
class MatchScreenTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MatchScreenTwoController());
  }
}
