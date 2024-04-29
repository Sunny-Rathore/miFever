import 'package:get/get.dart';

import '../controller/edit_other_details_controller.dart';

class EditOtherDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditOtherDetailsController());
  }
}
