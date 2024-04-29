import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/progress_dialog_utils.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/presentation/help_and_support_screen/models/help_and_support_screen_model.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';

import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/help_and_support_controller.dart';

// ignore_for_file: must_be_immutable
class HelpAndSupportScreen extends GetWidget<HelpAndSupportController> {
  HelpAndSupportScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildAppBar(),
                SizedBox(height: 8.v),
                Padding(
                  padding: EdgeInsets.all(12.0.h),
                  child: CustomTextFormField(
                    controller: controller.helpController,
                    hintText: 'lbl_enter_text_here'.tr,
                    //"msg_lorem_ipsum_dolor".tr,
                    hintStyle: CustomTextStyles.bodyMediumGray900,
                    textInputAction: TextInputAction.done,
                    maxLines: 8,
                    contentPadding: EdgeInsets.all(12.h),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'err_msg_please_enter_valid_text'.tr;
                      }
                      return null;
                    },
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.all(8.0.h),
                //   child: CustomTextFormField(
                //     controller: controller.helpController,
                //     hintText: "msg_enter_email_address".tr,
                //     hintStyle: CustomTextStyles.bodySmall12,
                //     textInputType: TextInputType.emailAddress,
                //     prefix: Container(
                //       margin: EdgeInsets.fromLTRB(12.h, 12.v, 8.h, 12.v),
                //       child: CustomImageView(
                //         imagePath: ImageConstant.imgMail02RedA200,
                //         height: 20.adaptSize,
                //         width: 20.adaptSize,
                //       ),
                //     ),
                //     prefixConstraints: BoxConstraints(
                //       maxHeight: 44.v,
                //     ),
                //     validator: (value) {
                //       if (value == null ||
                //           (!isValidEmail(value, isRequired: true))) {
                //         return "err_msg_please_enter_valid_email".tr;
                //       }
                //       return null;
                //     },
                //     onChanged: (val) {
                //       if (controller.helpController.text.isEmpty) {
                //         // controller.isButtonDisable.value = true;
                //       } else {
                //         //controller.isButtonDisable.value = false;
                //       }
                //     },
                //   ),
                // ),

                SizedBox(height: 24.v),

                // Container(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 20.h,
                //     vertical: 24.v,
                //   ),
                //   child: Column(
                //       children: List.generate(
                //     5,
                //     (index) => Padding(
                //       padding: EdgeInsets.only(bottom: 10.h),
                //       child: Container(
                //         decoration: BoxDecoration(
                //             border: Border.all(
                //               color: appTheme.gray200,
                //             ),
                //             borderRadius: BorderRadius.circular(10)),
                //         child: ExpansionTile(
                //           iconColor: Colors.black,
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(5),
                //               side: BorderSide(color: appTheme.redA200)),
                //           title: Text(
                //             '${index + 1}.  ' + 'msg_lorem_ipsum_dolor10'.tr,
                //             style: theme.textTheme.titleSmall!
                //                 .copyWith(fontSize: 14),
                //           ),
                //           children: [
                //             _buildFrame1(),
                //           ],
                //         ),
                //       ),
                //     ),
                //   )),
                // ),
              ],
            ),
          ),
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 20.v),
          child: CustomElevatedButton(
              text: "lbl_continue".tr,
              rightIcon: Container(
                margin: EdgeInsets.only(left: 4.h),
                child: CustomImageView(
                  imagePath: ImageConstant.imgArrowleft02sharp,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                ),
              ),
              buttonStyle: null,
              onPressed: _onTapContinue
              //controller.isButtonDisable.value ? null : _onTapContinue,
              ),
        ),
      ),
    );
  }

  _onTapContinue() async {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      ProgressDialogUtils.showProgressDialog();
      HelpAndSupportModel model = HelpAndSupportModel(
          userId: PrefUtils.getId(),
          email: controller.helpController.text,
          status: '');
      await FirebaseServices.addHelAndSupport(model);
      controller.helpController.clear();
      ProgressDialogUtils.hideProgressDialog();
      Fluttertoast.showToast(msg: 'We will get you soon');
      Get.back();
    }
  }

  /// Section Widget
  Widget _buildAppBar() {
    return Container(
      decoration: AppDecoration.top,
      child: CustomAppBar(
        height: 53.v,
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
          onTap: () {
            Get.back();
          },
          imagePath: ImageConstant.imgArrowLeft02SharpGray90024x24,
          margin: EdgeInsets.only(
            left: 16.h,
            top: 13.v,
            bottom: 16.v,
          ),
        ),
        title: AppbarSubtitle(
          text: "msg_help_and_support".tr,
          margin: EdgeInsets.only(left: 12.h),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFrame1() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 11.h,
        vertical: 9.v,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 310.h,
                child: Text(
                  "msg_lorem_ipsum_dolor9".tr,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall!.copyWith(
                    height: 1.50,
                  ),
                ),
              ),
              SizedBox(height: 16.v),
              Padding(
                padding: EdgeInsets.only(left: 6.h),
                child: Text(
                  "msg_lorem_ipsum_dolor5".tr,
                  style: theme.textTheme.bodySmall,
                ),
              ),
              SizedBox(height: 5.v),
              Padding(
                padding: EdgeInsets.only(left: 6.h),
                child: Text(
                  "msg_lorem_ipsum_dolor5".tr,
                  style: theme.textTheme.bodySmall,
                ),
              ),
              SizedBox(height: 5.v),
              Padding(
                padding: EdgeInsets.only(left: 6.h),
                child: Text(
                  "msg_lorem_ipsum_dolor5".tr,
                  style: theme.textTheme.bodySmall,
                ),
              ),
              SizedBox(height: 5.v),
              Padding(
                padding: EdgeInsets.only(left: 6.h),
                child: Text(
                  "msg_lorem_ipsum_dolor5".tr,
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
