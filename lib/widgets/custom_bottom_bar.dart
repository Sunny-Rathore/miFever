// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/home_screen/home_screen.dart';
import 'package:mifever/presentation/my_profile_screen/my_profile_screen.dart';

import '../presentation/like_screen/like_screen.dart';
import '../presentation/my_chats_one_page/my_chats_one_page.dart';

class CustomBottomBar extends StatelessWidget {
  CustomBottomBar({Key? key}) : super(key: key);
  final controller = Get.put(CustomBottomBarController());

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgComponent5,
      activeIcon: ImageConstant.imgComponent5,
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgComponent3,
      activeIcon: ImageConstant.imgComponent3,
      type: BottomBarEnum.Like,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgUserGray60004,
      activeIcon: ImageConstant.imgUserGray60004,
      type: BottomBarEnum.Chat,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgComponent2,
      activeIcon: ImageConstant.imgComponent2,
      type: BottomBarEnum.Profile,
    )
  ];
  List<Widget> _body = [
    HomeScreen(),
    LikeScreen(),
    MyChatsOnePage(),
    MyProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _body[controller.selectedIndex.value],
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: Colors.transparent,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedFontSize: 0,
            elevation: 0,
            currentIndex: controller.selectedIndex.value,
            type: BottomNavigationBarType.fixed,
            items: List.generate(bottomMenuList.length, (index) {
              return BottomNavigationBarItem(
                icon: CustomImageView(
                  imagePath: bottomMenuList[index].icon,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  color: appTheme.gray60004,
                ),
                activeIcon: Container(
                  decoration: AppDecoration.outlineRedA200,
                  child: CustomImageView(
                    imagePath: bottomMenuList[index].activeIcon,
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                    color: appTheme.redA200,
                    margin: EdgeInsets.symmetric(vertical: 20.v),
                  ),
                ),
                label: '',
              );
            }),
            onTap: (index) {
              controller.selectedIndex.value = index;
              // controller.selectedIndex.value = index;
              // onChanged?.call(bottomMenuList[index].type);
            },
          ),
        ),
      ),
    );
  }
}

enum BottomBarEnum {
  Home,
  Like,
  Chat,
  Profile,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    required this.type,
  });

  String icon;

  String activeIcon;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBottomBarController extends GetxController {
  RxInt selectedIndex = 0.obs;
}

Future<bool> isHome() async {
  final controller = Get.find<CustomBottomBarController>();
  if (controller.selectedIndex.value != 0) {
    controller.selectedIndex.value = 0;
    return false;
  } else {
    return true;
  }
}
