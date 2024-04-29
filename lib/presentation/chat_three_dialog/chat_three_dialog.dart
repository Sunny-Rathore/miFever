// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_super_html_viewer/flutter_super_html_viewer.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_icon_button.dart';

class ChatThreeDialog extends StatelessWidget {
  ChatThreeDialog({Key? key, required this.subTitle, required this.onTap})
      : super(key: key);
  final String subTitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseServices.getLaws(subTitle),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox.shrink();
          }
          var data = snapshot.data?.docs ?? [];
          print(data.length);
          return Material(
            borderRadius: BorderRadiusStyle.roundedBorder4,
            child: Container(
              width: 335.h,
              padding: EdgeInsets.all(24.h),
              decoration: AppDecoration.fillPrimary.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder4,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomIconButton(
                    height: 72.adaptSize,
                    width: 72.adaptSize,
                    padding: EdgeInsets.all(14.h),
                    decoration: IconButtonStyleHelper.fillRed,
                    alignment: Alignment.center,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgAirplane02,
                    ),
                  ),
                  SizedBox(height: 14.v),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      subTitle,
                      //data[0]['country'],
                      // "lbl_about_tokyo".tr,
                      style: CustomTextStyles.titleMediumGray900ExtraBold,
                    ),
                  ),
                  SizedBox(height: 16.v),
                  Container(
                      height: 200.h,
                      margin: EdgeInsets.only(
                        left: 6.h,
                        right: 17.h,
                      ),
                      child: data.length == 0
                          ? Center(child: Text('No data'))
                          : HtmlContentViewer(
                              htmlContent: data[0]['content'],
                              initialContentHeight:
                                  MediaQuery.of(context).size.height)),
                  SizedBox(height: 14.v),
                  CustomElevatedButton(
                    text: "lbl_book_now".tr,
                    onPressed: onTap,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
