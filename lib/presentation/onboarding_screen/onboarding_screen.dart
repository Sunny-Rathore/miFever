import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_icon_button.dart';
import 'package:mifever/widgets/custom_outlined_button.dart';

import '../community_guidelines /community_guidelines.dart';
import 'controller/onboarding_controller.dart';

// ignore_for_file: must_be_immutable
class OnboardingScreen extends GetWidget<OnboardingController> {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 20.h,
            // vertical: 34.v,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.v),
                _buildStackOne(),
                SizedBox(height: 53.v),
                Container(
                  width: 272.h,
                  margin: EdgeInsets.only(right: 63.h),
                  child: Text(
                    "msg_find_your_perfect".tr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.headlineSmall!.copyWith(
                      height: 1.33,
                    ),
                  ),
                ),
                SizedBox(height: 8.v),
                Text(
                  "msg_connect_with_people".tr,
                  style: theme.textTheme.bodyMedium,
                ),
                SizedBox(height: 28.v),
                Obx(
                  () => CustomElevatedButton(
                    onPressed: controller.isAgree.value
                        ? () {
                            FirebaseServices.signInWithGoogle();
                          }
                        : null,
                    height: 48.v,
                    text: "msg_continue_with_google".tr,
                    leftIcon: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 9.h,
                        vertical: 6.v,
                      ),
                      margin: EdgeInsets.only(right: 8.h),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(
                          15.h,
                        ),
                      ),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgImage1599,
                        height: 18.adaptSize,
                        width: 18.adaptSize,
                      ),
                    ),
                    buttonStyle: controller.isAgree.value
                        ? CustomButtonStyles.fillRedA
                        : CustomButtonStyles.fillGray,
                  ),
                ),
                SizedBox(height: 20.v),
                Obx(
                  () => CustomOutlinedButton(
                    height: 48.v,
                    text: "msg_continue_with_email".tr,
                    leftIcon: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 9.h,
                        vertical: 6.v,
                      ),
                      margin: EdgeInsets.only(right: 8.h),
                      decoration: BoxDecoration(
                        color: controller.isAgree.value
                            ? appTheme.redA200
                            : appTheme.gray200,
                        borderRadius: BorderRadius.circular(
                          15.h,
                        ),
                      ),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgMail02,
                        height: 18.adaptSize,
                        width: 18.adaptSize,
                      ),
                    ),
                    buttonStyle: controller.isAgree.value
                        ? CustomButtonStyles.outlineRedA
                        : CustomButtonStyles.outlineGray,
                    onPressed: controller.isAgree.value
                        ? _onTapContinueWithEmail
                        : null,
                  ),
                ),
                SizedBox(height: 15.v),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 1.v),
                        child: Text(
                          "msg_don_t_have_an_account".tr,
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                      Obx(
                        () => Padding(
                          padding: EdgeInsets.only(left: 8.h),
                          child: InkWell(
                            onTap:
                                controller.isAgree.value ? onTapSIngUp : null,
                            child: Text(
                              "lbl_sign_up".tr,
                              style: controller.isAgree.value
                                  ? CustomTextStyles.titleSmallRedA200
                                  : CustomTextStyles.titleSmallGray60004Medium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          side: BorderSide(color: Colors.grey),
                          checkColor: Colors.white,
                          activeColor: Colors.red,
                          value: controller.isAgree.value,
                          onChanged: (val) {
                            controller.isAgree.value = val!;
                          }),
                    ),
                    Expanded(
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                          text: 'I agree to the, ',
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(AppRoutes.termsAndConditionsScreen);
                            },
                          text: 'Terms and Conditions, ',
                          style: TextStyle(color: Colors.red),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(AppRoutes.privacyAndPolicyScreen);
                            },
                          text: 'Privacy Policy, ',
                          style: TextStyle(color: Colors.red),
                        ),
                        TextSpan(
                          text: 'and ',
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(() => CommunityGuidelines());
                              //Get.toNamed(AppRoutes.privacyAndPolicyScreen);
                            },
                          text: 'Community Guidelines.',
                          style: TextStyle(color: Colors.red),
                        ),
                      ])),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapSIngUp() {
    Get.toNamed(AppRoutes.signUpScreen);
  }

  Future<void> _onTapContinueWithEmail() async {
    Get.toNamed(AppRoutes.signInScreen);
  }

  /// Section Widget
  Widget _buildStackOne() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 296.v,
        width: 309.h,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20.h,
                  right: 15.h,
                ),
                child: DottedBorder(
                  color: appTheme.red100,
                  padding: EdgeInsets.only(
                    left: 1.h,
                    top: 1.v,
                    right: 1.h,
                    bottom: 1.v,
                  ),
                  strokeWidth: 1.h,
                  radius: Radius.circular(137),
                  borderType: BorderType.RRect,
                  dashPattern: [
                    8,
                    8,
                  ],
                  child: Container(
                    decoration: AppDecoration.outlineRed.copyWith(
                      borderRadius: BorderRadiusStyle.circleBorder137,
                    ),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 0,
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusStyle.circleBorder137,
                      ),
                      child: Container(
                        height: 274.adaptSize,
                        width: 274.adaptSize,
                        padding: EdgeInsets.symmetric(
                          horizontal: 33.h,
                          vertical: 10.v,
                        ),
                        decoration: AppDecoration.gradientRedAToRedA.copyWith(
                          borderRadius: BorderRadiusStyle.circleBorder137,
                        ),
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 7.h,
                                  vertical: 30.v,
                                ),
                                decoration: AppDecoration.outlineRed.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.circleBorder97,
                                ),
                                child: DottedBorder(
                                  color: appTheme.red100,
                                  padding: EdgeInsets.only(
                                    left: 1.h,
                                    top: 1.v,
                                    right: 1.h,
                                    bottom: 1.v,
                                  ),
                                  strokeWidth: 1.h,
                                  radius: Radius.circular(97),
                                  borderType: BorderType.RRect,
                                  dashPattern: [
                                    8,
                                    8,
                                  ],
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 22.v),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomImageView(
                                          imagePath: ImageConstant.imgEllipse11,
                                          height: 40.adaptSize,
                                          width: 40.adaptSize,
                                          radius: BorderRadius.circular(
                                            20.h,
                                          ),
                                          margin:
                                              EdgeInsets.only(bottom: 108.v),
                                        ),
                                        Container(
                                          height: 80.adaptSize,
                                          width: 80.adaptSize,
                                          margin: EdgeInsets.only(
                                            left: 17.h,
                                            top: 34.v,
                                            bottom: 34.v,
                                          ),
                                          padding: EdgeInsets.all(4.h),
                                          decoration:
                                              AppDecoration.fillRedA.copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .circleBorder40,
                                          ),
                                          child: CustomImageView(
                                            imagePath:
                                                ImageConstant.imgEllipse4,
                                            height: 72.adaptSize,
                                            width: 72.adaptSize,
                                            radius: BorderRadius.circular(
                                              36.h,
                                            ),
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                        CustomImageView(
                                          imagePath: ImageConstant.imgEllipse5,
                                          height: 30.adaptSize,
                                          width: 30.adaptSize,
                                          radius: BorderRadius.circular(
                                            15.h,
                                          ),
                                          margin: EdgeInsets.only(
                                            left: 22.h,
                                            top: 114.v,
                                            bottom: 4.v,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgEllipse7,
                              height: 40.adaptSize,
                              width: 40.adaptSize,
                              radius: BorderRadius.circular(
                                20.h,
                              ),
                              alignment: Alignment.bottomLeft,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 27.v,
                                right: 39.h,
                              ),
                              child: CustomIconButton(
                                height: 36.adaptSize,
                                width: 36.adaptSize,
                                padding: EdgeInsets.all(8.h),
                                alignment: Alignment.topRight,
                                decoration: IconButtonStyleHelper.fillRedA,
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgVideo01,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            CustomImageView(
              imagePath: ImageConstant.imgEllipse9,
              height: 32.adaptSize,
              width: 32.adaptSize,
              radius: BorderRadius.circular(
                16.h,
              ),
              alignment: Alignment.topCenter,
            ),
            CustomImageView(
              imagePath: ImageConstant.imgEllipse6,
              height: 40.adaptSize,
              width: 40.adaptSize,
              radius: BorderRadius.circular(
                20.h,
              ),
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: 97.v),
            ),
            Padding(
              padding: EdgeInsets.only(right: 80.h),
              child: CustomIconButton(
                decoration: IconButtonStyleHelper.fillRedA,
                height: 39.adaptSize,
                width: 39.adaptSize,
                padding: EdgeInsets.all(8.h),
                alignment: Alignment.bottomRight,
                child: CustomImageView(
                  imagePath: ImageConstant.imgEllipse6,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 112.v),
              child: CustomIconButton(
                decoration: IconButtonStyleHelper.fillRedA,
                height: 40.adaptSize,
                width: 40.adaptSize,
                padding: EdgeInsets.all(8.h),
                alignment: Alignment.bottomLeft,
                child: CustomImageView(
                  imagePath: ImageConstant.imgLocationFavourite01,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
