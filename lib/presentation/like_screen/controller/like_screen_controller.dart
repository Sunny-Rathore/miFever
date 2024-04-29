import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/like_screen/models/empty_state_tab_container_model.dart';

/// A controller class for the EmptyStateTabContainerScreen.
///
/// This class manages the state of the EmptyStateTabContainerScreen, including the
/// current emptyStateTabContainerModelObj
class LikeScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<EmptyStateTabContainerModel> emptyStateTabContainerModelObj =
      EmptyStateTabContainerModel().obs;

  late TabController tabviewController =
      Get.put(TabController(vsync: this, length: 2));
  var selectedIndex = 0.obs;
}
