import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/progress_dialog_utils.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_text_form_field.dart';

import '../../../data/models/user/about_me_model.dart';
import '../controller/about_me_controller.dart.dart';

// ignore_for_file: must_be_immutable
class AddAboutMeView extends GetWidget<AboutMePageController> {
  const AddAboutMeView(
      {Key? key,
      required this.question,
      required this.answer,
      required this.aboutMe,
      required this.mapKey})
      : super(key: key);
  final String answer;
  final String question;
  final AboutMe aboutMe;
  final String mapKey;

  @override
  Widget build(BuildContext context) {
    if (answer.isNotEmpty) {
      controller.descriptionController.text = answer;
    } else {
      controller.descriptionController.clear();
    }
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 20.h,
            vertical: 25.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question,
                //"msg_describe_a_things".tr,
                style: theme.textTheme.titleSmall,
              ),
              SizedBox(height: 11.v),
              CustomTextFormField(
                maxLength: 250,
                controller: controller.descriptionController,
                hintText: 'lbl_enter_text_here'.tr,
                //"msg_lorem_ipsum_dolor".tr,
                hintStyle: CustomTextStyles.bodyMediumGray900,
                textInputAction: TextInputAction.done,
                maxLines: 8,
                contentPadding: EdgeInsets.all(12.h),
              ),
              SizedBox(height: 8.v),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "msg_max_250_characters".tr,
                  style: CustomTextStyles.bodySmall11,
                ),
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
        bottomSheet: _buildSave(),
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
        text: "lbl_about_me".tr,
        margin: EdgeInsets.only(left: 12.h),
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildSave() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.h,
        right: 20.h,
        bottom: 16.v,
      ),
      child: CustomElevatedButton(
        text: "lbl_save".tr,
        onPressed: () async {
          ProgressDialogUtils.showProgressDialog();
          var newMap = aboutMe.toJson();
          newMap[mapKey] = controller.descriptionController.text;
          UserModel userModel = UserModel(aboutMe: AboutMe.fromJson(newMap));
          await FirebaseServices.updateUser(userModel);
          ProgressDialogUtils.hideProgressDialog();
          Fluttertoast.showToast(msg: 'Success');
          Get.back();
        },
      ),
    );
  }
}
