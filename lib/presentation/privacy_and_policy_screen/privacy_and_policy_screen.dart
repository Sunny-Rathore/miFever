import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_super_html_viewer/flutter_super_html_viewer.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';

import 'controller/privacy_and_policy_controller.dart';
import 'models/privacy_and_policy_model.dart';

// ignore_for_file: must_be_immutable
class PrivacyAndPolicyScreen extends GetWidget<PrivacyAndPolicyController> {
  const PrivacyAndPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: AppbarSubtitle(
            text: "msg_privacy_and_policy".tr,
            // margin: EdgeInsets.only(left: 12.h),
          ),
        ),
        body: SizedBox(
          height: SizeUtils.height,
          width: SizeUtils.width,
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseServices.getSettings(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox.shrink();
                } else if (!snapshot.hasData) {
                  return SizedBox.shrink();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Something Went Wrong'));
                }
                var snapShotData = snapshot.data!;
                SettingsModel settingsModel = SettingsModel.fromJson(
                    snapShotData.data() as Map<String, dynamic>);
                return Container(
                  height: SizeUtils.height,
                  width: SizeUtils.width,
                  //color: Colors.red,
                  child: SingleChildScrollView(
                    child: HtmlContentViewer(
                        htmlContent: settingsModel.privacyPolicy,
                        initialContentHeight:
                            MediaQuery.of(context).size.height),
                  ),
                );
              }),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFrame() {
    return Container(
      decoration: AppDecoration.top,
      child: CustomAppBar(
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
          text: "msg_privacy_and_policy".tr,
          margin: EdgeInsets.only(left: 12.h),
        ),
      ),
    );
  }
}
