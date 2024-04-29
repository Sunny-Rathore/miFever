// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/liked_me_page/liked_me_page.dart';
import 'package:mifever/presentation/matches/matches.dart';
import 'package:mifever/presentation/my_likes_page/my_likes_page.dart';

import '../../widgets/custom_bottom_bar.dart';
import 'controller/like_screen_controller.dart';

// ignore_for_file: must_be_immutable
class LikeScreen extends GetWidget<LikeScreenController> {
  LikeScreen({Key? key}) : super(key: key);
  final controller = Get.put(LikeScreenController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return isHome();
        },
        child: Scaffold(
          body: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                SizedBox(height: 24.v),
                _buildTabview(),
                SizedBox(
                  height: 624.v,
                  child: Obx(
                    () => IndexedStack(
                      index: controller.selectedIndex.value,
                      children: [
                        LikedMePage(),
                        MyLikesPage(),
                        MatchesPage(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTabview() {
    return Container(
      height: 56.v,
      width: 335.h,
      padding: EdgeInsets.all(8.v),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(
          28.h,
        ),
        border: Border.all(
          color: appTheme.gray200,
          width: 1.h,
        ),
      ),
      child: Obx(
        () => Row(
          children: [
            // _tabIndicator(),
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.selectedIndex.value = 0;
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8.v),
                  decoration: controller.selectedIndex.value.isEqual(0)
                      ? BoxDecoration(
                          color: appTheme.redA200,
                          borderRadius: BorderRadius.circular(
                            20.h,
                          ),
                        )
                      : null,
                  child: Text(
                    "lbl_liked_me".tr,
                    style: TextStyle(
                      fontSize: 16.fSize,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      color: controller.selectedIndex.value.isEqual(0)
                          ? theme.colorScheme.primary
                          : appTheme.gray60004,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 12.v,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.selectedIndex.value = 1;
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8.v),
                  decoration: controller.selectedIndex.value.isEqual(1)
                      ? BoxDecoration(
                          color: appTheme.redA200,
                          borderRadius: BorderRadius.circular(
                            20.h,
                          ),
                        )
                      : null,
                  child: Text(
                    "lbl_my_likes2".tr,
                    style: TextStyle(
                      fontSize: 16.fSize,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      color: controller.selectedIndex.value.isEqual(1)
                          ? theme.colorScheme.primary
                          : appTheme.gray60004,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.selectedIndex.value = 2;
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8.v),
                  decoration: controller.selectedIndex.value.isEqual(2)
                      ? BoxDecoration(
                          color: appTheme.redA200,
                          borderRadius: BorderRadius.circular(
                            20.h,
                          ),
                        )
                      : null,
                  child: Text(
                    "lbl_matches".tr,
                    style: TextStyle(
                      fontSize: 16.fSize,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      color: controller.selectedIndex.value.isEqual(2)
                          ? theme.colorScheme.primary
                          : appTheme.gray60004,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
