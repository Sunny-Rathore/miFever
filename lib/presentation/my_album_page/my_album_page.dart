// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/progress_dialog_utils.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/data/sevices/media_services/media_services.dart';

import 'controller/my_album_controller.dart';
import 'widgets/album_widget.dart';

class MyAlbumPage extends StatelessWidget {
  MyAlbumPage({Key? key}) : super(key: key);
  MyAlbumController controller = Get.put(MyAlbumController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 27.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "lbl_my_way_album".tr,
                        style: CustomTextStyles.titleMediumGray900ExtraBold,
                      ),
                      SizedBox(height: 14.v),
                      _buildWayAlbumView(),
                      SizedBox(height: 39.v),
                      Text(
                        "lbl_my_life_album".tr,
                        style: CustomTextStyles.titleMediumGray900ExtraBold,
                      ),
                      SizedBox(height: 14.v),
                      _buildMyLifeAlbum(),
                      SizedBox(height: 24.v),
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

  /// Section Widget
  Widget _buildWayAlbumView() {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseServices.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox.shrink();
          }
          var data = snapshot.data;
          UserModel _user = UserModel();
          _user = UserModel.fromJson(data?.data() as Map<String, dynamic>);
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 101.v,
              crossAxisCount: 3,
              mainAxisSpacing: 24.h,
              crossAxisSpacing: 24.h,
            ),
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            // _user.wayAlbum?.length ?? 0,
            itemBuilder: (context, index) {
              if (index < _user.wayAlbum!.length) {
                return AlbumWidget(
                  index: index,
                  url: _user.wayAlbum![index],
                  onDelete: () async {
                    var list = _user.lifeAlbum;
                    list!.removeAt(index);
                    FirebaseServices.editWayAlbum(list);
                    ProgressDialogUtils.hideProgressDialog();
                  },
                  onEdit: () async {
                    var list = _user.lifeAlbum;
                    String imagePath =
                        await MediaServices.pickImageFromGallery();
                    if (imagePath.isNotEmpty) {
                      ProgressDialogUtils.showProgressDialog();
                      String url = await FirebaseServices.uploadFile(
                          filePath: imagePath, contentType: '.jpg');
                      list![index] = url;
                      FirebaseServices.editWayAlbum(list);
                      ProgressDialogUtils.hideProgressDialog();
                    }
                  },
                );
              }
              return _buildAddImageView(() async {
                String imagePath = await MediaServices.pickImageFromGallery();
                if (imagePath.isNotEmpty) {
                  ProgressDialogUtils.showProgressDialog();
                  String url = await FirebaseServices.uploadFile(
                      filePath: imagePath, contentType: '.jpg');
                  FirebaseServices.addWayAlbum(url);
                  ProgressDialogUtils.hideProgressDialog();
                }
              });
            },
          );
        });
  }

  /// Section Widget
  Widget _buildMyLifeAlbum() {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseServices.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox.shrink();
          }
          var data = snapshot.data;
          UserModel _user = UserModel();
          _user = UserModel.fromJson(data?.data() as Map<String, dynamic>);
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 101.v,
              crossAxisCount: 3,
              mainAxisSpacing: 24.h,
              crossAxisSpacing: 24.h,
            ),
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              if (index < _user.lifeAlbum!.length) {
                return AlbumWidget(
                  index: index,
                  url: _user.lifeAlbum![index],
                  onDelete: () async {
                    var list = _user.lifeAlbum;
                    list!.removeAt(index);
                    FirebaseServices.editWayAlbum(list);
                    ProgressDialogUtils.hideProgressDialog();
                  },
                  onEdit: () async {
                    var list = _user.lifeAlbum;
                    String imagePath =
                        await MediaServices.pickImageFromGallery();
                    if (imagePath.isNotEmpty) {
                      ProgressDialogUtils.showProgressDialog();
                      String url = await FirebaseServices.uploadFile(
                          filePath: imagePath, contentType: '.jpg');
                      list![index] = url;
                      FirebaseServices.editLifeAlbum(list);
                      ProgressDialogUtils.hideProgressDialog();
                    }
                  },
                );
              }
              return _buildAddImageView(() async {
                String imagePath = await MediaServices.pickImageFromGallery();
                if (imagePath.isNotEmpty) {
                  ProgressDialogUtils.showProgressDialog();
                  String url = await FirebaseServices.uploadFile(
                      filePath: imagePath, contentType: '.jpg');
                  FirebaseServices.addLifeAlbum(url);
                  ProgressDialogUtils.hideProgressDialog();
                }
              });
            },
          );
        });
  }

  Container _buildAddImageView(VoidCallback onTap) {
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
}
