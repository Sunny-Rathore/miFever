import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/proflie_details_screen/models/proflie_details_model.dart';

/// A controller class for the ProflieDetailsEditMyAlbumTabContainerScreen.
///
/// This class manages the state of the ProflieDetailsEditMyAlbumTabContainerScreen, including the
/// current proflieDetailsEditMyAlbumTabContainerModelObj
class ProflieDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<ProflieDetailsModel> proflieDetailsEditMyAlbumTabContainerModelObj =
      ProflieDetailsModel().obs;

  late TabController tabviewController =
      Get.put(TabController(vsync: this, length: 3));
}
