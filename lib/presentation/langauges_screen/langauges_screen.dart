import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';

import 'controller/langauges_controller.dart';
import 'models/language_options_widgetModel.dart';
import 'widgets/language_options_widget.dart';

// ignore_for_file: must_be_immutable
class LangaugesScreen extends GetWidget<LangaugesController> {
  const LangaugesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 24.v),
              _buildFrameThirtyTwo(),
            ],
          ),
        ),
        bottomNavigationBar: _buildSave(),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Get.back();
        },
        imagePath: ImageConstant.imgArrowLeft02SharpGray90024x24,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 16.v,
          bottom: 16.v,
        ),
      ),
      title: AppbarSubtitle(
        text: "lbl_languages".tr,
        margin: EdgeInsets.only(left: 12.h),
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildFrameThirtyTwo() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Obx(
          () => ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (
              context,
              index,
            ) {
              return SizedBox(
                height: 12.v,
              );
            },
            itemCount: controller
                .langaugesModelObj.value.languageOptionsList.value.length,
            itemBuilder: (context, index) {
              LanguageOptionsWidgetModel model = controller
                  .langaugesModelObj.value.languageOptionsList.value[index];
              return LanguageOptionsWidget(
                model,
              );
            },
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSave() {
    return CustomElevatedButton(
      onPressed: () {
        LocalizationService.changeLocale(
            controller.languageModel.value.id!.value);
        Get.back();
      },
      text: "lbl_save".tr,
      margin: EdgeInsets.only(
        left: 20.h,
        right: 20.h,
        bottom: 36.v,
      ),
    );
  }
}
