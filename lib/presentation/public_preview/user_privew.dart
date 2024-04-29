import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/public_preview/public_preview.dart';

import '../../data/models/user/user_model.dart';
import '../../data/sevices/firebase_services.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/themometer_horizontal.dart';

class UserPreviewPage extends StatelessWidget {
  const UserPreviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          height: 660.h,
          width: double.maxFinite,
          padding: EdgeInsets.only(top: 2.v),
          child: Stack(
            children: [
              _themometerHot(),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  _buildLikeDislikeButtons(),
                  Container(
                    height: 550,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        StreamBuilder<DocumentSnapshot>(
                            stream:
                                FirebaseServices.getUserById(PrefUtils.getId()),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SizedBox.shrink();
                              }
                              var data = snapshot.data;
                              UserModel user = UserModel();
                              user = UserModel.fromJson(
                                  data!.data() as Map<String, dynamic>);

                              return Container(
                                  height: 550, child: _buildUserCard(user));
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  _themometerHot() {
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                color: appTheme.red50,
                borderRadius: BorderRadius.circular(40.h)),
            margin: EdgeInsets.symmetric(horizontal: 20.h),
            width: SizeUtils.width,
            height: 60.h,
            child: InkWell(
              onTap: () {
                Get.defaultDialog(
                    titleStyle: TextStyle(fontSize: 15.fSize),
                    title: 'lbl_how_thermometer_works'.tr,
                    middleText: 'lbl_thermometer_is_a'.tr);
              },
              child: ThermoTestHorizontal(value: 20 / 100),
            )),
        Positioned(
          left: 43.h,
          top: 20.v,
          child: CustomImageView(
            height: 20.v,
            width: 20.h,
            imagePath: 'assets/images/fire.svg',
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          right: 30.v,
          top: 20.h,
          child: Text(
            '20' + '%',
            style: CustomTextStyles.labelLargeBlack900,
          ),
        ),
      ],
    );
  }

  _buildUserCard(UserModel user) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              Get.to(() => PublicPreview(PrefUtils.getId()));
            },
            child: Container(
              height: 452.v,
              width: 335.h,
              margin: EdgeInsets.only(top: 80.v),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomImageView(
                    imagePath: user.lifeAlbum?[0],
                    //ImageConstant.imgRectangle17844,
                    height: 482.v,
                    width: 335.h,
                    radius: BorderRadius.circular(
                      12.h,
                    ),
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 120.v,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            // Color.fromRGBO(0, 0, 0, 0.18),
                            Color.fromRGBO(0, 0, 0, 0.5),
                            Color.fromRGBO(0, 0, 0, 0.9),
                          ],
                          stops: [0.0004, 0.5633, 0.9996],
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 24.h,
                            right: 16.h,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 75.h,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.h,
                                  vertical: 5.v,
                                ),
                                decoration: AppDecoration.fillPrimary2.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder12,
                                ),
                                child: Text(
                                  '0' + "lbl_2_km_away".tr,
                                  style: CustomTextStyles.labelMediumPrimary_1,
                                ),
                              ),
                              SizedBox(height: 5.v),
                              Text(
                                user.name.toString(),
                                style: theme.textTheme.titleLarge,
                              ),
                              Row(
                                children: [
                                  CustomImageView(
                                    imagePath:
                                        ImageConstant.imgLocation01Gray200,
                                    height: 16.adaptSize,
                                    width: 16.adaptSize,
                                    margin: EdgeInsets.only(bottom: 2.v),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4.h),
                                    child: Text(
                                      "${user.locationText}",
                                      style: CustomTextStyles.labelLargeGray200,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildLikeDislikeButtons() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 422.v),
        padding: EdgeInsets.symmetric(
          horizontal: 70.h,
          vertical: 25.v,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImageConstant.imgFrame427320779,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 98.v),
              child: CustomIconButton(
                onTap: () {
                  // controller.isWantToDislike.value = true;
                  // _matchEngine.currentItem!.nope();
                },
                height: 64.adaptSize,
                width: 64.adaptSize,
                padding: EdgeInsets.all(14.h),
                child: CustomImageView(
                  imagePath: ImageConstant.imgRemove,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 98.v),
              child: CustomIconButton(
                onTap: () {
                  //_matchEngine.currentItem!.like();
                },
                height: 64.adaptSize,
                width: 64.adaptSize,
                padding: EdgeInsets.all(14.h),
                child: CustomImageView(
                  imagePath: ImageConstant.imgFavourite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
