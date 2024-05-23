// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/presentation/personal_info_page/models/adition_details_model.dart';
import 'package:mifever/presentation/personal_info_page/widgets/edit_adition_details.dart';
import 'package:readmore/readmore.dart';

import '../../data/models/user/about_me_model.dart';
import '../../data/models/user/user_model.dart';
import '../../widgets/custom_outlined_button.dart';
import '../about_me_page/models/describeathings_item_model.dart';
import '../about_me_page/widgets/add_about_me_widget.dart';
import 'controller/personal_info_controller.dart';
import 'models/personal_info_model.dart';
import 'widgets/available_location_widget.dart';
import 'widgets/your_interest_chip_widget.dart';

class PersonalInfoPage extends StatelessWidget {
  PersonalInfoPage({Key? key}) : super(key: key);

  PersonalInfoController controller =
      Get.put(PersonalInfoController(PersonalInfoModel().obs));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 25.v),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.h,
                    right: 17.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 3.h),
                        child: _buildFrameTitle(
                            otherDetails: "msg_personal_details".tr,
                            onTap: () {
                              Get.toNamed(AppRoutes.editPersonalDetailsScreen);
                            }),
                      ),
                      SizedBox(height: 16.v),
                      _buildPersonalDetail(),
                      SizedBox(height: 25.v),
                      Padding(
                        padding: EdgeInsets.only(right: 3.h),
                        child: _buildFrameTitle(
                          otherDetails: "lbl_other_details".tr,
                          onTap: () {
                            Get.toNamed(AppRoutes.editOtherDetailsScreen);
                          },
                        ),
                      ),
                      SizedBox(height: 16.v),
                      _buildOtherDetails(),
                      Text(
                        'lbl_info'.tr,
                        style: CustomTextStyles.titleMediumGray900ExtraBold
                            .copyWith(
                          color: appTheme.gray900,
                        ),
                      ),
                      _buildInfo()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //info
  _buildInfo() {
    return Container(
      width: double.maxFinite,
      decoration: AppDecoration.fillPrimary,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 24.v),
            _buildDescribeAThings(),
            SizedBox(height: 24.v)
          ],
        ),
      ),
    );
  }

  Widget _buildDescribeAThings() {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseServices.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox.shrink();
          }
          var data = snapshot.data;
          UserModel _user = UserModel();
          _user = UserModel.fromJson(data?.data() as Map<String, dynamic>);
          Rx<List<DescribeathingsItemModel>> describeathingsItemList = Rx([
            DescribeathingsItemModel(
                question:
                    //'Things I really like to do'.obs,
                    "lbl_in_my".tr.obs,
                answer: _user.aboutMe?.thingsYouLike.obs,
                key: 'thingsYouLike'.obs),
            DescribeathingsItemModel(
              question:
                  //'Things I love about my culture'.obs,
                  "lbl_abut_culture".tr.obs,
              answer: _user.aboutMe?.aboutMyCulture.obs,
              key: 'aboutMyCulture'.obs,
            ),
            DescribeathingsItemModel(
                question:
                    // 'What kind of person I am'.obs,
                    "lbl_fav_location".tr.obs,
                answer: _user.aboutMe?.favLocation.obs,
                key: 'favLocation'.obs)
          ]);

          return Obx(
            () => ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (
                context,
                index,
              ) {
                return SizedBox(
                  height: 16.v,
                );
              },
              itemCount: describeathingsItemList.value.length,
              itemBuilder: (context, index) {
                DescribeathingsItemModel model =
                    describeathingsItemList.value[index];
                return editView(model, _user.aboutMe!);

                // return DescribeathingsItemWidget(
                //   model,
                // );
              },
            ),
          );
        });
  }

  Widget editView(
      DescribeathingsItemModel describeathingsItemModelObj, AboutMe aboutMe) {
    return Container(
      padding: EdgeInsets.all(11.h),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            //'dd',
            describeathingsItemModelObj.question?.value ?? '',
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(height: 7.v),
          SizedBox(
            width: 307.h,
            child: ReadMoreText(
              describeathingsItemModelObj.answer?.value ?? '',
              //"msg_lorem_ipsum_dolor6".tr,
              trimLines: 4,
              colorClickableText: appTheme.redA200,
              trimMode: TrimMode.Line,
              trimCollapsedText: "lbl_read_more".tr,
              trimExpandedText: 'lbl_read_less'.tr,
              moreStyle: theme.textTheme.bodyMedium!.copyWith(
                height: 1.43,
                color: appTheme.redA200,
              ),
              lessStyle: theme.textTheme.bodyMedium!.copyWith(
                height: 1.43,
                color: appTheme.redA200,
              ),
            ),
          ),
          SizedBox(height: 10.v),
          describeathingsItemModelObj.answer!.value.isNotEmpty
              ? CustomOutlinedButton(
                  width: 77.h,
                  text: "lbl_edit".tr,
                  buttonTextStyle: CustomTextStyles.titleSmallRedA200,
                  onPressed: () {
                    Get.to(() => AddAboutMeView(
                          aboutMe: aboutMe,
                          question:
                              describeathingsItemModelObj.question?.value ?? '',
                          answer:
                              describeathingsItemModelObj.answer?.value ?? '',
                          mapKey: describeathingsItemModelObj.key?.value ?? '',
                        ));
                  },
                )
              : CustomOutlinedButton(
                  width: 77.h,
                  text: "lbl_add".tr,
                  buttonTextStyle: CustomTextStyles.titleSmallRedA200,
                  onPressed: () {
                    Get.to(() => AddAboutMeView(
                          aboutMe: aboutMe,
                          question:
                              describeathingsItemModelObj.question?.value ?? '',
                          answer:
                              describeathingsItemModelObj.answer?.value ?? '',
                          mapKey: describeathingsItemModelObj.key?.value ?? '',
                        ));
                  },
                ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPersonalDetail() {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseServices.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox.shrink();
          }
          var data = snapshot.data;
          UserModel _user = UserModel();
          _user = UserModel.fromJson(data?.data() as Map<String, dynamic>);
          return Container(
            width: 335.h,
            margin: EdgeInsets.only(left: 3.h),
            padding: EdgeInsets.all(14.h),
            decoration: AppDecoration.outlineGray200.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder4,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 2.v),
                Text(
                  "lbl_name".tr,
                  style: CustomTextStyles.labelLargeGray60004,
                ),
                SizedBox(height: 3.v),
                Text(
                  _user.name.toString(),
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 17.v),
                Text(
                  "lbl_email".tr,
                  style: CustomTextStyles.labelLargeGray60004,
                ),
                SizedBox(height: 5.v),
                Text(
                  _user.email ?? '',
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 15.v),
                Text(
                  "lbl_birth_date".tr,
                  style: CustomTextStyles.labelLargeGray60004,
                ),
                SizedBox(height: 3.v),
                Text(
                  _user.dob ?? '',
                  // "lbl_20_oct_1999".tr,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 17.v),
                Text(
                  "lbl_gender".tr,
                  style: CustomTextStyles.labelLargeGray60004,
                ),
                SizedBox(height: 3.v),
                Text(
                  _user.gender ?? '',
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 18.v),
                Text(
                  "lbl_location".tr,
                  style: CustomTextStyles.labelLargeGray60004,
                ),
                SizedBox(height: 3.v),
                Text(
                  _user.locationText ?? '',
                  //"${_user.city},${_user.country}",
                  style: theme.textTheme.titleSmall,
                ),
              ],
            ),
          );
        });
  }

  /// Section Widget
  Widget _buildOtherDetails() {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseServices.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox.shrink();
          }
          var data = snapshot.data;
          UserModel _user = UserModel();
          _user = UserModel.fromJson(data?.data() as Map<String, dynamic>);
          return Column(
            children: [
              Container(
                width: 335.h,
                margin: EdgeInsets.only(right: 3.h),
                padding: EdgeInsets.all(15.h),
                decoration: AppDecoration.outlineGray200.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder4,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "lbl_your_interest".tr,
                      style: CustomTextStyles.labelLargeGray60004,
                    ),
                    SizedBox(height: 9.v),
                    Wrap(
                      runSpacing: 12.v,
                      spacing: 12.h,
                      children: List<Widget>.generate(
                        _user.interestList?.length ?? 0,
                        (index) {
                          return YourInterestChipWidget(
                            text: _user.interestList?[index] ?? '',
                            //yourInterestModel: model,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 17.v),
                    Text(
                      "lbl_you_re_here_for".tr,
                      style: CustomTextStyles.labelLargeGray60004,
                    ),
                    SizedBox(height: 5.v),
                    Text(
                      _user.whatDoYouWant ?? '',
                      // "msg_serious_relationship2".tr,
                      style: theme.textTheme.titleSmall,
                    ),
                    SizedBox(height: 15.v),
                    Text(
                      "msg_available_locations".tr,
                      style: CustomTextStyles.labelLargeGray60004,
                    ),
                    SizedBox(height: 7.v),
                    Wrap(
                      runSpacing: 12.v,
                      spacing: 12.h,
                      children: List<Widget>.generate(
                        _user.availableLocation?.length ?? 0,
                        (index) {
                          return AvailableLocationWidget(
                              "${_user.availableLocation![index].locationName}");
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.v),
              ...List.generate(9, (index) {
                List<AdditionalDetailsWidgetModel> additionalDetailsList =
                    <AdditionalDetailsWidgetModel>[
                  AdditionalDetailsWidgetModel(
                    label: 'lbl_height'.tr,
                    key: 'height',
                    value: _user.additionalPersonalInfo?.height != null
                        ? '${_user.additionalPersonalInfo?.height} cm'
                        : '',
                  ),
                  AdditionalDetailsWidgetModel(
                    label: 'lbl_horoscope'.tr,
                    key: 'horoscope',
                    value: _user.additionalPersonalInfo?.horoscope ?? '',
                  ),
                  AdditionalDetailsWidgetModel(
                    label: 'lbl_smokingOrNonSmoking'.tr,
                    key: 'smokingStatus',
                    value: _user.additionalPersonalInfo?.smokingStatus ?? '',
                  ),
                  AdditionalDetailsWidgetModel(
                    label: 'lbl_drinkerOrNonDrinker'.tr,
                    key: 'drinkingStatus',
                    value: _user.additionalPersonalInfo?.drinkingStatus ?? '',
                  ),
                  AdditionalDetailsWidgetModel(
                    label: 'lbl_religion'.tr,
                    key: 'religion',
                    value: _user.additionalPersonalInfo?.religion ?? '',
                  ),
                  AdditionalDetailsWidgetModel(
                    label: 'lbl_maritalStatus'.tr,
                    key: 'maritalStatus',
                    value: _user.additionalPersonalInfo?.maritalStatus ?? '',
                  ),
                  AdditionalDetailsWidgetModel(
                    label: 'lbl_children'.tr,
                    key: 'children',
                    value: _user.additionalPersonalInfo?.children ?? '',
                  ),
                  AdditionalDetailsWidgetModel(
                    label: 'lbl_naturalHairColor'.tr,
                    key: 'naturalHairColor',
                    value: _user.additionalPersonalInfo?.naturalHairColor ?? '',
                  ),
                  AdditionalDetailsWidgetModel(
                    label: 'lbl_musicpreference'.tr,
                    key: 'musicPreference',
                    value: _user.additionalPersonalInfo?.musicPreference ?? '',
                  ),
                ];
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _buildFrame(
                      onTap: () {
                        Get.to(() => EditAdditionalDetailsPage(
                              mapKey: additionalDetailsList[index].key,
                              value: additionalDetailsList[index].value,
                              additionalPersonalInfo:
                                  _user.additionalPersonalInfo!,
                            ));

                        // Get.toNamed(AppRoutes.privacyAndPolicyScreen);
                      },
                      value: additionalDetailsList[index].value,
                      key: additionalDetailsList[index].key,
                      label: additionalDetailsList[index].label
                      //"lbl_privacy_policy".tr,
                      ),
                );
              }),
              SizedBox(height: 24.v),
            ],
          );
        });
  }

  /// Common widget
  Widget _buildFrameTitle(
      {required String otherDetails, required VoidCallback onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          otherDetails,
          style: CustomTextStyles.titleMediumGray900ExtraBold.copyWith(
            color: appTheme.gray900,
          ),
        ),
        CustomImageView(
          onTap: onTap,
          imagePath: ImageConstant.imgEdit02RedA200,
          height: 20.adaptSize,
          width: 20.adaptSize,
        ),
      ],
    );
  }

  /// Common widget
  Widget _buildFrame(
      {required String value,
      required String key,
      required String label,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(11.h),
        decoration: AppDecoration.outlineGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // CustomImageView(
            //   imagePath: languageSquare,
            //   height: 20.adaptSize,
            //   width: 20.adaptSize,
            //   margin: EdgeInsets.only(top: 1.v),
            // ),
            Padding(
              padding: EdgeInsets.only(
                left: 8.h,
                top: 1.v,
              ),
              child: Text(
                label,
                style: theme.textTheme.titleSmall!.copyWith(
                  color: appTheme.gray900,
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                Text(
                  value,
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: appTheme.gray900,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgArrowRightGray6000416x16,
                  height: 16.adaptSize,
                  width: 16.adaptSize,
                  margin: EdgeInsets.only(
                    top: 1.v,
                    bottom: 3.v,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
