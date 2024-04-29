// import 'package:flutter/material.dart';
// import 'package:mifever/core/app_export.dart';

// import '../home_screen/home_screen.dart';
// import 'controller/filter_appled_container_controller.dart';

// class FilterAppledContainerScreen
//     extends GetWidget<FilterAppledContainerController> {
//   const FilterAppledContainerScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             body: Navigator(
//                 key: Get.nestedKey(1),
//                 initialRoute: AppRoutes.filterAppledPage,
//                 onGenerateRoute: (routeSetting) => GetPageRoute(
//                     page: () => getCurrentPage(routeSetting.name!),
//                     transition: Transition.noTransition)),
//             bottomNavigationBar: buildBottomBar()));
//   }
// }
