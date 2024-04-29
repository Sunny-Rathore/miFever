// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/about_me_page/widgets/add_about_me_widget.dart';
import 'package:readmore/readmore.dart';

import '../../data/models/user/about_me_model.dart';
import '../../data/models/user/user_model.dart';
import '../../data/sevices/firebase_services.dart';
import '../../widgets/custom_outlined_button.dart';
import 'controller/about_me_controller.dart.dart';
import 'models/describeathings_item_model.dart';

class AboutMePage extends StatelessWidget {
  AboutMePage({Key? key}) : super(key: key);

  AboutMePageController controller = Get.put(AboutMePageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildDescribeAThings() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: StreamBuilder<DocumentSnapshot>(
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
                  question: "lbl_my_fav_location_in_home_country".tr.obs,
                  answer: _user.aboutMe?.whatKindPerson.obs,
                  key: 'whatKindPerson'.obs),
              DescribeathingsItemModel(
                question: "lbl_hobbies_and_activity".tr.obs,
                answer: _user.aboutMe?.hobbiesAndActivity.obs,
                key: 'hobbiesAndActivity'.obs,
              ),
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
          }),
    );
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
}
