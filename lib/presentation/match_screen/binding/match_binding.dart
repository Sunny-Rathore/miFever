import '../controller/match_controller.dart';
import 'package:get/get.dart';

/// A binding class for the MatchScreen.
///
/// This class ensures that the MatchController is created when the
/// MatchScreen is first loaded.
class MatchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MatchController());
  }
}
