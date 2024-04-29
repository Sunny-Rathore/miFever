import 'dart:io';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:dio/dio.dart' as dio; // Use 'Dio' as a unique identifier
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mifever/data/sevices/firebase_services.dart';

import '../../core/app_export.dart';
import '../../core/utils/progress_dialog_utils.dart';
import '../../widgets/custom_elevated_button.dart';
import '../models/user/user_model.dart';
import 'media_services/media_services.dart';

class CropImageService {
  static void onProfileEdit(CropController cropController) async {
    String filePath = await MediaServices.pickImageFromGallery();
    File file = File(filePath);
    // Read the file as bytes
    List<int> bytes = await file.readAsBytes();
    // Convert bytes to Uint8List
    Uint8List _imageData = Uint8List.fromList(bytes);
    if (filePath.isNotEmpty) {
      Get.dialog(Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: Center(
            child: Crop(
                image: _imageData,
                interactive: true,
                controller: cropController,
                progressIndicator: CircularProgressIndicator(
                  backgroundColor: appTheme.redA200,
                ),
                aspectRatio: 1,
                onCropped: (image) {
                  finished(image);
                  // do something with cropped image data
                })),
        bottomSheet: buildButtons(cropController),
      ));
    }
  }

  static void cropAlbumImage(
      {required CropController cropController, required String url}) async {
    Uint8List? _imageData = await getImageBytes(url);
    if (_imageData != null) {
      Get.dialog(Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: Center(
            child: Crop(
                image: _imageData,
                interactive: true,
                controller: cropController,
                progressIndicator: CircularProgressIndicator(
                  backgroundColor: appTheme.redA200,
                ),
                aspectRatio: 0.9,
                //initialSize: 400,
                onCropped: (image) {
                  finished(image);
                  // do something with cropped image data
                })),
        bottomSheet: buildButtons(cropController),
      ));
    }
    //ProgressDialogUtils.hideProgressDialog();
  }

  static Future<void> finished(Uint8List imageBytes) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String imageName = 'image_${DateTime.now().millisecondsSinceEpoch}.png';
    Reference ref = storage.ref().child('images').child(imageName);
    SettableMetadata metadata = SettableMetadata(contentType: '.png');
    UploadTask uploadTask = ref.putData(imageBytes, metadata);
    await uploadTask.whenComplete(() {
      print('Image uploaded successfully!');
      // Get the download URL of the uploaded image
      ref.getDownloadURL().then((imageUrl) async {
        print('Download URL: $imageUrl');
        UserModel user = UserModel(profileImage: imageUrl);
        await FirebaseServices.updateUser(user);
        ProgressDialogUtils.hideProgressDialog();
        // Here you can do something with the download URL, such as save it to a database
        Get.back();
        Get.back();
      });
    });
  }

  static Widget buildButtons(CropController cropController) => Container(
        padding: EdgeInsets.symmetric(vertical: 20.v, horizontal: 10.h),
        //color: Colors.white,
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
            onPressed: () {
              ProgressDialogUtils.showProgressDialog();
              cropController.crop();
            }
            //_finished,
            ),
      );

  static Future<Uint8List?> getImageBytes(String imageUrl) async {
    try {
      ProgressDialogUtils.showProgressDialog();

      // Create a Dio client
      dio.Dio _dio = dio.Dio();

      // Fetch the image bytes from the network using Dio
      dio.Response<List<int>> response = await _dio.get<List<int>>(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        // Convert the response body (image bytes) to Uint8List
        ProgressDialogUtils.hideProgressDialog();

        return Uint8List.fromList(response.data!);
      } else {
        ProgressDialogUtils.hideProgressDialog();

        throw Exception('Failed to load image');
      }
    } catch (e) {
      ProgressDialogUtils.hideProgressDialog();

      print('Error: $e');
      return null;
    }
  }
}
