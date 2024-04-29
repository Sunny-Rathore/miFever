import 'dart:async';

import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/models/like/like_model.dart';
import 'package:mifever/data/models/thermometer_model/thermometer_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/presentation/profile_screen/models/profile_model.dart';
import 'package:translator_plus/translator_plus.dart';

import '../../../data/models/notification/notification.dart';
import '../../../data/models/user/user_model.dart';
import '../../chat_screen/models/translation_model.dart';

class ProfileController extends GetxController {
  Rx<ProfileModel> profileModelObj = ProfileModel().obs;
  Rx<LikeModel> likeData = LikeModel().obs;

  RxBool isWayAlbum = true.obs;
  Rx<int> sliderIndex = 0.obs;
  RxDouble progress = 0.0.obs;
  RxBool isPlaying = false.obs;
  RxString planName = ''.obs;
  RxString textTries = '0'.obs;

  List<TranslationModel> translationList = <TranslationModel>[].obs;

  List convertedInterest = [].obs;
  List convertedAvailableLocation = [].obs;
  RxString convertedHereFor = ''.obs;
  RxString convertedInMyFreeTime = ''.obs;
  RxString convertedAboutMyCulture = ''.obs;
  RxString convertedFavLocation = ''.obs;

  var isConverted = false.obs;
  var isMatched = false.obs;
  late Timer _timer;
  RxInt _elapsedSeconds = 0.obs;

  void translate(UserModel user) async {
    var interests = user.interestList;
    var availableLocation = user.availableLocation;

    final translator = GoogleTranslator();
    // convert interest
    translator
        .translate(interests!.join(","), to: PrefUtils.getLang())
        .then((s) {
      print("s===" + s.toString());
      convertedInterest.addAll(s.toString().split(','));
    });
    // convert here for
    translator
        .translate(user.whatDoYouWant ?? '', to: PrefUtils.getLang())
        .then((value) {
      convertedHereFor.value = value.text;
      print("s===" + value.toString());
    });
    // convert available location
    translator
        .translate(availableLocation!.join(","), to: PrefUtils.getLang())
        .then((s) {
      print("s===" + s.toString());
      convertedAvailableLocation.addAll(s.toString().split(','));
    });
    //convert about Me
    translator
        .translate(user.aboutMe?.thingsYouLike ?? '', to: PrefUtils.getLang())
        .then((value) {
      print('s==${value.toString()}');
      convertedInMyFreeTime.value = value.text;
    });
    translator
        .translate(user.aboutMe?.aboutMyCulture ?? '', to: PrefUtils.getLang())
        .then((value) {
      print('s==${value.toString()}');
      convertedAboutMyCulture.value = value.text;
    });
    translator
        .translate(user.aboutMe?.favLocation ?? '', to: PrefUtils.getLang())
        .then((value) => convertedFavLocation.value = value.text);
  }

  void addThermometer(String userId) async {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (isPlaying.value) {
        if (progress.value < 1) {
          print(progress.value);
          progress.value = progress.value + 0.2;
        } else {
          isPlaying.value = false;
        }
      }
      _elapsedSeconds.value++;
      print(_elapsedSeconds.value);

      if (_elapsedSeconds.value == 15) {
        addThemometerValue(value: 20, id: userId);
      } else if (_elapsedSeconds.value == 30) {
        addThemometerValue(value: 30, id: userId);
      } else if (_elapsedSeconds.value == 60) {
        addThemometerValue(value: 50, id: userId);
      }
    });
  }

  void addThemometerValue({required int value, required String id}) async {
    var isInBlocked = await FirebaseServices.isInBlockTable(id);
    if (!isInBlocked) {
      print('add');
      FirebaseServices.getThermometerValue(id).then((thermometerModel) async {
        var userIds = [];
        var currentUserId = PrefUtils.getId();
        var thermometerValue = 0;
        if (thermometerModel != null) {
          thermometerValue = thermometerModel.percentageValue;
          if (!thermometerModel.userIds!.contains(currentUserId)) {
            userIds.add(currentUserId);
          } else {
            userIds.addAll(thermometerModel.userIds ?? []);
          }
        } else {
          userIds.add(currentUserId);
        }
        if (thermometerValue <= value) {
          await FirebaseServices.addThermometerValue(ThermometerModel(
              timestamp: DateTime.now().toString(),
              roomId: FirebaseServices.createChatRoomId(id),
              percentageValue: value,
              userIds: userIds));
        }
      });
    }
  }

  void addNotification(String id) async {
    NotificationModel notificationModel = NotificationModel(
      type: NotificationType.View.name,
      notificationTo: id,
      notificationBy: PrefUtils.getId(),
      createdAt: DateTime.now().toString(),
    );
    await FirebaseServices.addNotification(notificationModel);
  }

  checkIsMatched(String receiverId) async {
    isMatched.value = await FirebaseServices.isRealMatched(receiverId);
    print('isMatched $isMatched');
  }

  getLikeData(String receiverId) {
    FirebaseServices.getAllMatchedDataByUserId(receiverId).then((value) {
      if (value != null) {
        likeData.value = value;
        print("likeData=> ${likeData.value.isDeleted}");
      }
    });
  }

  @override
  void onInit() {
    FirebaseServices.getCurrentSubscription().then((value) {
      planName.value = value;
    });
    FirebaseServices.getCurrentTexTriesSubscription().then((value) {
      textTries.value = value.replaceFirst(" Chances", "");
      print('chances==>' + textTries.value);
    });
    super.onInit();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
