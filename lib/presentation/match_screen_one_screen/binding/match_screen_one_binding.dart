import '../controller/match_screen_one_controller.dart';
import 'package:get/get.dart';

/// A binding class for the MatchScreenOneScreen.
///
/// This class ensures that the MatchScreenOneController is created when the
/// MatchScreenOneScreen is first loaded.
class MatchScreenOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MatchScreenOneController());
  }
}
