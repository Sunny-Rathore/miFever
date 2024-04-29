import 'package:get/get.dart';

import '../controller/proflie_details_controller.dart';

/// A binding class for the ProflieDetailsEditMyAlbumTabContainerScreen.
///
/// This class ensures that the ProflieDetailsEditMyAlbumTabContainerController is created when the
/// ProflieDetailsEditMyAlbumTabContainerScreen is first loaded.
class ProflieDetailsEditMyAlbumTabContainerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProflieDetailsController());
  }
}
