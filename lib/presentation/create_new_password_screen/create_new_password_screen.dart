import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/validation_functions.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_text_form_field.dart';

import '../sucess_msg_dialog/controller/sucess_msg_controller.dart';
import '../sucess_msg_dialog/sucess_msg_dialog.dart';
import 'controller/create_new_password_controller.dart';

// ignore_for_file: must_be_immutable
class CreateNewPasswordScreen extends GetWidget<CreateNewPasswordController> {
  CreateNewPasswordScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.h,
                  vertical: 10.v,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "msg_create_new_password".tr,
                      style: theme.textTheme.headlineSmall,
                    ),
                    SizedBox(height: 23.v),
                    Text(
                      "msg_create_new_password".tr,
                      style: CustomTextStyles.titleSmallGray60002,
                    ),
                    SizedBox(height: 8.v),
                    Obx(
                      () => CustomTextFormField(
                        controller: controller.newpasswordController,
                        hintText: "msg_enter_new_password".tr,
                        hintStyle: CustomTextStyles.bodySmall12,
                        textInputType: TextInputType.visiblePassword,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(12.h, 12.v, 8.h, 12.v),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgCirclepassword,
                            height: 20.adaptSize,
                            width: 20.adaptSize,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 44.v,
                        ),
                        suffix: InkWell(
                          onTap: () {
                            controller.isShowPassword.value =
                                !controller.isShowPassword.value;
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(12.h, 12.v, 12.h, 12.v),
                            child: CustomImageView(
                              imagePath: controller.isShowPassword.value
                                  ? ImageConstant.imgView
                                  : ImageConstant.imgViewoff,
                              height: 20.adaptSize,
                              width: 20.adaptSize,
                            ),
                          ),
                        ),
                        suffixConstraints: BoxConstraints(
                          maxHeight: 44.v,
                        ),
                        validator: (value) {
                          if (value == null ||
                              (!isValidPassword(value, isRequired: true))) {
                            return "err_msg_please_enter_valid_password".tr;
                          }
                          return null;
                        },
                        onChanged: (val) {
                          if (val.isEmpty) {
                            controller.isButtonDisable.value = true;
                          } else {
                            controller.isButtonDisable.value = false;
                          }
                        },
                        obscureText: controller.isShowPassword.value,
                        contentPadding: EdgeInsets.symmetric(vertical: 13.v),
                      ),
                    ),
                    SizedBox(height: 24.v),
                    Text(
                      "msg_re_enter_new_password".tr,
                      style: CustomTextStyles.titleSmallGray60002,
                    ),
                    SizedBox(height: 7.v),
                    Obx(
                      () => CustomTextFormField(
                        controller: controller.newpasswordController1,
                        hintText: "msg_re_enter_new_password2".tr,
                        hintStyle: CustomTextStyles.bodySmall12,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.visiblePassword,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(12.h, 12.v, 8.h, 12.v),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgCirclepassword,
                            height: 20.adaptSize,
                            width: 20.adaptSize,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 44.v,
                        ),
                        suffix: InkWell(
                          onTap: () {
                            controller.isShowPassword1.value =
                                !controller.isShowPassword1.value;
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(12.h, 12.v, 12.h, 12.v),
                            child: CustomImageView(
                              imagePath: controller.isShowPassword1.value
                                  ? ImageConstant.imgView
                                  : ImageConstant.imgViewoff,
                              height: 20.adaptSize,
                              width: 20.adaptSize,
                            ),
                          ),
                        ),
                        suffixConstraints: BoxConstraints(
                          maxHeight: 44.v,
                        ),
                        validator: (value) {
                          if (value == null ||
                              (!isValidPassword(value, isRequired: true))) {
                            return "err_msg_please_enter_valid_password".tr;
                          }
                          return null;
                        },
                        obscureText: controller.isShowPassword1.value,
                        contentPadding: EdgeInsets.symmetric(vertical: 13.v),
                        onChanged: (val) {
                          controller.isButtonDisable(val.isEmpty);
                        },
                      ),
                    ),
                    SizedBox(height: 24.v),
                    Obx(
                      () => CustomElevatedButton(
                        text: "lbl_continue".tr,
                        rightIcon: Container(
                          margin: EdgeInsets.only(left: 4.h),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgArrowleft02sharp,
                            height: 24.adaptSize,
                            width: 24.adaptSize,
                          ),
                        ),
                        buttonStyle: controller.isButtonDisable.value
                            ? CustomButtonStyles.fillGray
                            : null,
                        onPressed: controller.isButtonDisable.value
                            ? null
                            : _onTapContinue,
                      ),
                    ),
                    SizedBox(height: 5.v),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgElementsGray900,
        margin: EdgeInsets.fromLTRB(25.h, 21.v, 330.h, 22.v),
      ),
    );
  }

  _onTapContinue() {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      Get.dialog(
        Center(
            child: SucessMsgDialog(
          SucessMsgController(),
          "msg_your_new_password".tr,
        )),
        barrierColor: Colors.black.withOpacity(0.7),
        barrierDismissible: false,
      );
    }
  }
}
