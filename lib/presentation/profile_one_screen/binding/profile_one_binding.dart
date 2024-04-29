import '../controller/profile_one_controller.dart';
import 'package:get/get.dart';

/// A binding class for the ProfileOneScreen.
///
/// This class ensures that the ProfileOneController is created when the
/// ProfileOneScreen is first loaded.
class ProfileOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileOneController());
  }
}
