import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/progress_dialog_utils.dart';
import 'package:mifever/data/models/user/about_me_model.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/presentation/question_four_screen/controller/question_four_controller.dart';
import 'package:mifever/presentation/question_one_screen/controller/question_one_controller.dart';
import 'package:mifever/presentation/question_seven_screen/models/question_seven_model.dart';
import 'package:mifever/presentation/question_two_screen/controller/question_two_controller.dart';

import '../../../data/sevices/firebase_analytics_service/firebase_analytics_service.dart';
import '../../../widgets/custom_bottom_bar.dart';
import '../../question_five_screen/controller/question_five_controller.dart';
import '../../question_six_screen/controller/question_six_controller.dart';
import '../../question_three_screen/controller/question_three_controller.dart';

class QuestionSevenController extends GetxController {
  Rx<QuestionSevenModel> questionSevenModelObj = QuestionSevenModel().obs;
  final q1 = Get.find<QuestionOneController>();
  final q2 = Get.find<QuestionTwoController>();
  final q3 = Get.find<QuestionThreeController>();
  final q4 = Get.find<QuestionFourController>();
  final q5 = Get.find<QuestionFiveController>();
  final q6 = Get.find<QuestionSixController>();
  var isButtonDisable = true.obs;

  // List getAvailableLocationList() {
  //   List locationList = [];
  //   for (var location in q5.availableLocationTextController) {
  //     locationList.add(location.text);
  //   }
  //   return locationList;
  // }

  Future<List> getWayAlbum() async {
    List wayAlbum = [];
    List wayAlbumUrl = [];

    wayAlbum.addAll(imagesList.where((element) => element.isNotEmpty));
    for (var i in wayAlbum) {
      wayAlbumUrl.add(
          await FirebaseServices.uploadFile(filePath: i, contentType: '.jpg'));
    }
    return wayAlbumUrl;
  }

  Future<List> getLifeAlbum() async {
    List<String> lifeAlbum = <String>[];
    List lifeAlbumUrl = [];

    lifeAlbum
        .addAll(lifeAlbumImagesList.where((element) => element.isNotEmpty));
    for (var i in lifeAlbum) {
      lifeAlbumUrl.add(
          await FirebaseServices.uploadFile(filePath: i, contentType: '.jpg'));
    }
    return lifeAlbumUrl;
  }

  var imageProgressList = [false, false, false, false, false].obs;
  var lifeAlbumImagesProcessList = [false, false, false, false, false].obs;

  var imagesList = [
    '',
    '',
    '',
    '',
    '',
  ].obs;
  var lifeAlbumImagesList = [
    '',
    '',
    '',
    '',
    '',
  ].obs;

  checkButtonDisable() {
    List<String> lifeAlbum = <String>[];
    List wayAlbum = [];
    lifeAlbum
        .addAll(lifeAlbumImagesList.where((element) => element.isNotEmpty));
    wayAlbum.addAll(imagesList.where((element) => element.isNotEmpty));
    isButtonDisable.value = lifeAlbum.length < 2 ||
        wayAlbum.length < 2 ||
        imageProgressList.contains(true) ||
        lifeAlbumImagesProcessList.contains(true);
  }

  void onTapContinue() async {
    ProgressDialogUtils.showProgressDialog();
    UserModel userModel = UserModel(
      isAccountDeleted: false,
      isApproved: true,
      planName: '',
      id: PrefUtils.getId(),
      name: q1.nameController.text,
      nameAudio: await FirebaseServices.uploadFile(
          filePath: q1.recordedFilePath.value, contentType: '.mp3'),
      audioDuration: q1.timerCount.value,
      gender: q2.selectedGender.value,
      dob: q3.selectedDate.value,
      interestList: q4.selectedInterestList,
      locationText: q5.locationTextController.text,
      location: q5.locationLatLong.value,
      availableLocation: q5.locationList,
      whatDoYouWant: q6.whatDoYouWantToFindOut.value,
      wayAlbum: imagesList.where((element) => element.isNotEmpty).toList(),
      lifeAlbum:
          lifeAlbumImagesList.where((element) => element.isNotEmpty).toList(),
      aboutMe: AboutMe(
        aboutMyCulture: '',
        thingsYouLike: '',
        whatKindPerson: '',
        hobbiesAndActivity: '',
        favLocation: '',
      ),
      isProfileComplete: true,
    );
    bool isSuccess = await FirebaseServices.updateUser(userModel);
    if (isSuccess) {
      ProgressDialogUtils.hideProgressDialog();
      PrefUtils.setUserName(q1.nameController.text.trim());
      PrefUtils.setGender(q2.selectedGender.value);
      PrefUtils.setAvailableLocation(q5.locationList[0].locationName);
      AnalyticsService.signUp();
      Get.offAll(() => CustomBottomBar());
    }
  }
}
