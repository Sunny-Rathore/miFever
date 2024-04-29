import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_super_html_viewer/flutter_super_html_viewer.dart';
import 'package:mifever/core/app_export.dart';

import '../../data/sevices/firebase_services.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../privacy_and_policy_screen/models/privacy_and_policy_model.dart';

class CommunityGuidelines extends StatelessWidget {
  const CommunityGuidelines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: AppbarSubtitle(
            text: "lbl_community_guidelines".tr,
            // margin: EdgeInsets.only(left: 12.h),
          ),
        ),
        body: SizedBox(
          height: SizeUtils.height,
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseServices.getSettings(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox.shrink();
                  }
                  var snapShotData = snapshot.data!;
                  SettingsModel settingsModel = SettingsModel.fromJson(
                      snapShotData.data() as Map<String, dynamic>);
                  return Column(
                    children: [
                      HtmlContentViewer(
                        htmlContent: settingsModel.communityGuidelines,
                        initialContentHeight:
                            MediaQuery.of(context).size.height,
                        initialContentWidth: MediaQuery.of(context).size.width,
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
