import 'package:get/get.dart';

import '../controller/edit_personal_details_controller.dart';

class ProflieDetailsEditPersonalDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditPersonalDetailsController());
  }
}
