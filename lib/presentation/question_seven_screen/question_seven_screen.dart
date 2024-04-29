import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';

import '../../data/sevices/media_services/media_services.dart';
import 'controller/question_seven_controller.dart';

// ignore_for_file: must_be_immutable
class QuestionSevenScreen extends GetWidget<QuestionSevenController> {
  const QuestionSevenScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 11.v),
          child: Column(
            children: [
              SizedBox(height: 11.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5.v),
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 8.v,
                          width: 335.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              4.h,
                            ),
                            gradient: LinearGradient(
                              begin: Alignment(-0.04, 0.06),
                              end: Alignment(1.04, 0.95),
                              colors: [
                                theme.colorScheme.onPrimary.withOpacity(1),
                                appTheme.redA200,
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 23.v),
                        Text(
                          "msg_add_your_photos".tr,
                          style: theme.textTheme.headlineSmall,
                        ),
                        SizedBox(height: 26.v),
                        Text(
                          "lbl_your_way_album".tr,
                          style: CustomTextStyles.titleMediumGray900ExtraBold,
                        ),
                        SizedBox(height: 4.v),
                        Container(
                          width: 258.h,
                          margin: EdgeInsets.only(right: 76.h),
                          child: Text(
                            "msg_min_add_2_photos".tr,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.bodySmall12.copyWith(
                              height: 1.50,
                            ),
                          ),
                        ),
                        SizedBox(height: 13.v),
                        _buildEditTwo(),
                        SizedBox(height: 24.v),

                        Text(
                          "lbl_your_life_album".tr,
                          style: CustomTextStyles.titleMediumGray900ExtraBold,
                        ),
                        SizedBox(height: 6.v),
                        Container(
                          width: 258.h,
                          margin: EdgeInsets.only(right: 76.h),
                          child: Text(
                            "msg_min_add_2_photos".tr,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.bodySmall12.copyWith(
                              height: 1.50,
                            ),
                          ),
                        ),
                        SizedBox(height: 13.v),
                        _buildLifeAlbum(),
                        //_buildEditTwo(),
                        SizedBox(height: 24.v),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildContinue(),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingImage(
        onTap: () {
          Get.back();
        },
        imagePath: ImageConstant.imgElementsGray900,
        margin: EdgeInsets.fromLTRB(25.h, 21.v, 330.h, 22.v),
      ),
    );
  }

  /// Section Widget
  Widget _buildContinue() {
    return Obx(
      () => CustomElevatedButton(
        text: "lbl_continue".tr,
        margin: EdgeInsets.only(
          left: 20.h,
          right: 20.h,
          bottom: 34.v,
        ),
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
        onPressed: controller.imagesList
                    .firstWhereOrNull((element) => element != '') !=
                null
            ? _onTapContinue
            : null,
      ),
    );
  }

  /// Common widget
  Widget _buildEditTwo() {
    return Obx(
      () => Wrap(
          runSpacing: 10.h,
          spacing: 10.h,
          children: List.generate(
            controller.imagesList.length,
            (index) => controller.imagesList[index].isNotEmpty
                ? _buildEditImageView(
                    false,
                    controller.imagesList,
                    index,
                    () async {
                      String filePath =
                          await MediaServices.pickImageFromGallery();
                      if (filePath.isNotEmpty) {
                        controller.imagesList[index] = filePath;
                        controller.imageProgressList[index] = true;
                        controller.checkButtonDisable();
                        String uploadFileUrl =
                            await FirebaseServices.uploadFile(
                                filePath: filePath, contentType: ".jpg");
                        controller.imageProgressList[index] = false;
                        controller.imagesList[index] = uploadFileUrl;
                        controller.checkButtonDisable();
                      }
                    },
                  )
                : _buildAddImageView(
                    controller.imagesList,
                    index,
                    () async {
                      String filePath =
                          await MediaServices.pickImageFromGallery();
                      if (filePath.isNotEmpty) {
                        controller.imagesList[index] = filePath;
                        controller.imageProgressList[index] = true;
                        controller.checkButtonDisable();
                        String uploadFileUrl =
                            await FirebaseServices.uploadFile(
                                filePath: filePath, contentType: ".jpg");
                        controller.imageProgressList[index] = false;
                        controller.imagesList[index] = uploadFileUrl;
                        controller.checkButtonDisable();
                      }
                    },
                  ),
          )),
    );
  }

  Widget _buildLifeAlbum() {
    return Obx(
      () => Wrap(
          runSpacing: 10.h,
          spacing: 10.h,
          children: List.generate(
            controller.lifeAlbumImagesList.length,
            (index) => controller.lifeAlbumImagesList[index].isNotEmpty
                ? _buildEditImageView(
                    true,
                    controller.lifeAlbumImagesList,
                    index,
                    () async {
                      String filePath =
                          await MediaServices.pickImageFromGallery();
                      if (filePath.isNotEmpty) {
                        controller.lifeAlbumImagesList[index] = filePath;
                        controller.lifeAlbumImagesProcessList[index] = true;
                        controller.checkButtonDisable();
                        String uploadFileUrl =
                            await FirebaseServices.uploadFile(
                                filePath: filePath, contentType: ".jpg");
                        controller.lifeAlbumImagesProcessList[index] = false;
                        controller.lifeAlbumImagesList[index] = uploadFileUrl;
                        controller.checkButtonDisable();
                      }
                    },
                  )
                : _buildAddImageView(
                    controller.lifeAlbumImagesList,
                    index,
                    () async {
                      String filePath =
                          await MediaServices.pickImageFromGallery();
                      if (filePath.isNotEmpty) {
                        controller.lifeAlbumImagesList[index] = filePath;
                        controller.lifeAlbumImagesProcessList[index] = true;
                        controller.checkButtonDisable();
                        String uploadFileUrl =
                            await FirebaseServices.uploadFile(
                                filePath: filePath, contentType: ".jpg");
                        controller.lifeAlbumImagesProcessList[index] = false;
                        controller.lifeAlbumImagesList[index] = uploadFileUrl;
                        controller.checkButtonDisable();
                      }
                    },
                  ),
          )),
    );
  }

  Container _buildAddImageView(List imagesList, int index, VoidCallback onTap) {
    return Container(
      height: 100.v,
      width: 95.h,
      padding: EdgeInsets.symmetric(
        horizontal: 31.h,
        vertical: 34.v,
      ),
      decoration: AppDecoration.outlinePink.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: CustomImageView(
        onTap: onTap,
        imagePath: ImageConstant.imgAddCircleRedA200,
        height: 30.adaptSize,
        width: 30.adaptSize,
        alignment: Alignment.center,
      ),
    );
  }

  SizedBox _buildEditImageView(
      bool isLifeAlbum, List imagesList, int index, VoidCallback onTap) {
    return SizedBox(
      height: 100.v,
      width: 95.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: imagesList[index],
            //ImageConstant.imgRectangle17838,
            height: 100.v,
            width: 95.h,
            radius: BorderRadius.circular(
              10.h,
            ),
            alignment: Alignment.center,
          ),
          Container(
            height: 100.v,
            width: 95.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          CustomImageView(
            onTap: onTap,
            imagePath: ImageConstant.imgEdit02,
            height: 20.adaptSize,
            width: 20.adaptSize,
            alignment: Alignment.center,
          ),
          Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              onTap: () {
                if (isLifeAlbum) {
                  controller.lifeAlbumImagesList[index] = '';
                } else {
                  imagesList[index] = '';
                }
                controller.checkButtonDisable();
              },
              child: Visibility(
                visible: isLifeAlbum
                    ? !controller.lifeAlbumImagesProcessList[index]
                    : !controller.imageProgressList[index],
                child: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _onTapContinue() {
    controller.onTapContinue();
  }
}
