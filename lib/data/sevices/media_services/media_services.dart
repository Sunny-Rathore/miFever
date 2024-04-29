import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mifever/core/app_export.dart';
import 'package:path/path.dart' as p;

class MediaServices {
  static Future<String> pickImageFromGallery() async {
    //PermissionStatus status = await Permission.storage.status;
    //if (status == PermissionStatus.granted) {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return pickedImage.path;
    }
    // } else {
    //   await Permission.storage.request();
    // }
    return '';
  }

  static Future<Media?> pickFilePathAndExtension() async {
    try {
      // PermissionStatus status = await Permission.storage.status;
      // if (status == PermissionStatus.granted) {
      const int maxSizeBytes = 5 * 1024 * 1024; // 5 MB
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(allowCompression: true, compressionQuality: maxSizeBytes);
      if (result != null) {
        String? filePath = result.files.single.path;
        String? fileName = result.files.single.name;
        String? fileExtension = p.extension(filePath!);
        if (result.files.single.size > maxSizeBytes) {
          Fluttertoast.showToast(msg: 'error_msg_size_more_5MB'.tr);
        } else {
          return Media.fromJson(
              {'path': filePath, 'extension': fileExtension, 'name': fileName});
        }
        return null;
      } else {
        return null;
      }
      // } else {
      //   await Permission.storage.request();
      //   return null;
      // }
    } catch (e) {
      print("Error picking file: $e");
      return null;
    }
  }

  static Future<String> recordVideo() async {
    final _pickVideo = await ImagePicker().pickVideo(
        source: ImageSource.camera, maxDuration: Duration(seconds: 30));
    if (_pickVideo != null) {
      return _pickVideo.path;
    }
    return '';
  }
}

class Media {
  final String path;
  final String name;

  final String fileExtension;
  Media({required this.path, required this.name, required this.fileExtension});

  factory Media.fromJson(Map<String, dynamic> json) => Media(
      path: json['path'], name: json['name'], fileExtension: json['extension']);
}
