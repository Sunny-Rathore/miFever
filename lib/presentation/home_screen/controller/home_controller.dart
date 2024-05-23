// ignore_for_file: sdk_version_since

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/models/notification/notification.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/presentation/home_screen/models/home_model.dart';

import '../../../data/models/filter/filter_model.dart';
import '../../../data/models/thermometer_model/thermometer_model.dart';
import '../../../data/models/user/user_model.dart';
import '../../../data/sevices/firebase_messageing_service.dart';
import '../../../data/sevices/google_places_services.dart';
import '../../../data/sevices/location_service.dart';

class HomeController extends GetxController {
  Rx<HomeModel> homeModelObj = HomeModel().obs;

  var userList = <UserModel>[].obs;

  RxInt thermoValue = 0.obs;

  RxInt userLength = 0.obs;

  RxInt profileIndex = 0.obs;

  RxBool isWantToDislike = false.obs;

  Rx<GeoPoint> filteredLocation = GeoPoint(0.0, 0.0).obs;

  var receiverId = ''.obs;

  void onSwipe(
      {required String type,
      required String notificationTo,
      required String token}) async {
    NotificationModel notificationModel = NotificationModel(
      type: type,
      notificationTo: notificationTo,
      notificationBy: PrefUtils.getId(),
      createdAt: DateTime.now().toString(),
    );
    await FirebaseServices.addNotification(notificationModel);
  }

  void sendNotification({required UserModel user, required String type}) async {
    await FirebaseMessagingService.sendNotification(
      type: NotificationType.Like.name,
      token: user.token!,
      title: type == NotificationType.Like.name
          ? '${PrefUtils.getUserName()} ' + "lbl_liked_your_profile".tr
          : '${PrefUtils.getUserName()} ' + "lbl_viewed_your_profile".tr,
      body: '',
      id: "${user.id}",
    );
  }

  Future<List<UserModel>> getUser() async {
    PreferenceFilter? filter = await PrefUtils.getFilter();
    try {
      return getUsersFiltered(
              minAge: filter?.ageRangeStart.round() ?? 0,
              maxAge: filter?.ageRangeEnd.round() ?? 0,
              maxDistance: filter?.distance ?? 960,
              gender: filter?.interestedIn ?? 'Female',
              searchLocation: GeoPoint(
                  filter?.lat ?? 20.4481338, filter?.lng ?? 82.7462439),
              filter: filter!)
          .then((value) {
        return userList;
      });
    } catch (e) {
      print('error===>$e');
      return <UserModel>[];
    }
  }

  Future<List<UserModel>> getUsersFiltered(
      {required int minAge,
      required int maxAge,
      required double maxDistance,
      required String gender,
      required GeoPoint searchLocation,
      required PreferenceFilter filter}) async {
    userLength.value = 0;
    thermoValue.value = 0;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('id', isNotEqualTo: PrefUtils.getId())
        .where('isProfileComplete', isEqualTo: true)
        .where('isAccountDeleted', isEqualTo: false)
        .get();

    List<UserModel> users = [];
    List<String> _disLikeUsersId = [];
    List<String> _blockedUser = [];
    var matchedUser = [];
    List<String> _likeUsersId = [];

    _blockedUser = await FirebaseServices.getBlockedByMe();
    _blockedUser = await FirebaseServices.getBlockedMe();

    List<NotificationModel> _dislikeNotifications =
        await FirebaseServices.allDisLikedUserByMe();
    for (var user in _dislikeNotifications) {
      _disLikeUsersId.add(user.notificationTo);
    }
    List<NotificationModel> _likeNotifications =
        await FirebaseServices.allLikedUserByMe();
    for (var user in _likeNotifications) {
      _likeUsersId.add(user.notificationTo);
    }
    matchedUser = await FirebaseServices.getAllMatchUserIds();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
      UserModel user = UserModel.fromJson(userData);
      users.sort((a, b) => b.planName!.length.compareTo(a.planName!.length));
      if (!_blockedUser.contains(user.id) &&
          !matchedUser.contains(user.id) &&
          !_likeUsersId.contains(user.id) &&
          !_disLikeUsersId.contains(user.id) &&
          (calculateAgeFromString(user.dob!) >= minAge) &&
          (calculateAgeFromString(user.dob!) <= maxAge) &&
          (user.gender == gender) &&
          (!filter.isHeightFilterApplied ||
              (filter.heightStart == 0.0 && filter.heightEnd == 0.0) ||
              (user.additionalPersonalInfo?.height != null &&
                  (filter.heightStart <=
                          double.parse(
                              user.additionalPersonalInfo!.height ?? '0.0') &&
                      double.parse(
                              user.additionalPersonalInfo!.height ?? '0.0') <=
                          filter.heightEnd))) &&
          (filter.horoscope == "" ||
              filter.horoscope == user.additionalPersonalInfo!.horoscope) &&
          (filter.smokingStatus == "" ||
              filter.smokingStatus ==
                  user.additionalPersonalInfo!.smokingStatus) &&
          (filter.drinkingStatus == "" ||
              filter.drinkingStatus ==
                  user.additionalPersonalInfo!.drinkingStatus) &&
          (filter.religion == "" ||
              user.additionalPersonalInfo!.religion
                  .toString()
                  .trim()
                  .toLowerCase()
                  .contains(filter.religion.trim().toLowerCase())) &&
          (filter.maritalStatus == "" ||
              filter.maritalStatus ==
                  user.additionalPersonalInfo!.maritalStatus) &&
          (filter.hairColor == "" ||
              filter.hairColor ==
                  user.additionalPersonalInfo!.naturalHairColor) &&
          (filter.childrenStatus == "" ||
              filter.childrenStatus == user.additionalPersonalInfo!.children) &&
          (filter.musicPreference == "" ||
              filter.musicPreference ==
                  user.additionalPersonalInfo!.musicPreference)) {
        var currentLocationDistance = calculateDistance(
            user.isCurrentLocation!
                ? user.location!
                : user.currentLocationLatLng!,
            searchLocation);
        var distances = [];
        distances.add(currentLocationDistance);

        for (var location in user.availableLocation!) {
          var locationDistance =
              calculateDistance(location.latLng, searchLocation);
          distances.add(locationDistance);
        }
        print("distances$distances");
        if (distances.any((number) => number <= maxDistance)) {
          users.add(UserModel.fromJson(userData));
        }
      }
    }
    print('object2');

    userList.clear();
    userList.addAll(users);
    userLength.value = userList.length;

    if (userList.length > 0) {
      receiverId.value = userList[0].id ?? '';
      // final bottomBarController = Get.find<CustomBottomBarController>();
      // if (bottomBarController.selectedIndex.value == 0) {
      addThermometer(userList[0].id ?? '');
      // } else {
      //   stopTimer();
      // }
    }

    return users;
  }

  double calculateDistance(GeoPoint point1, GeoPoint point2) {
    print(
        'point1: latitude=> ${point1.latitude} longitude=> ${point1.longitude}');
    print(
        'point1: latitude=> ${point2.latitude} longitude=> ${point2.longitude}');

    final lat1 = point1.latitude;
    final lon1 = point1.longitude;
    final lat2 = point2.latitude;
    final lon2 = point2.longitude;

    final p = 0.017453292519943295;
    final c = cos;

    final a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    final distance = 12742 * asin(sqrt(a));

    return distance;
  }

  late Timer _timer;
  RxInt _elapsedSeconds = 0.obs;
  void addThermometer(String userId) {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _elapsedSeconds.value++;
      // print(_elapsedSeconds.value);
      if (_elapsedSeconds.value == 15) {
        addThemometerValue(value: 20, id: userId);
      } else if (_elapsedSeconds.value == 30) {
        addThemometerValue(value: 30, id: userId);
      } else if (_elapsedSeconds.value == 60) {
        addThemometerValue(value: 50, id: userId);
      } else if (_elapsedSeconds.value > 60) {
        stopTimer();
      }
    });
  }

  void stopTimer() {
    _timer.cancel();
    _elapsedSeconds.value = 0;
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

  getUserFilter() {
    PrefUtils.getFilter().then((filter) {
      if (filter != null) {
        filteredLocation.value = GeoPoint(filter.lat, filter.lng);
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    LocationService.getLocationAndSave();
    GooglePlacesApiServices.getCurrentLocation().then((value) {
      PrefUtils.setCountry(value);
      print("Location==>$value");
    });
    FirebaseServices.listenToFieldChanges();
    FirebaseServices.likedFieldChanges();
    FirebaseServices.listenToFieldIsApproved();
    // AnalyticsService.initMixpanel();
    getUser();
    getUserFilter();
    FirebaseServices.getTodaysLike();
  }

  List<String> addresses = [
    '1600 Amphitheatre Parkway, Mountain View, CA',
    '1 Infinite Loop, Cupertino, CA',
    '1 Microsoft Way, Redmond, WA',
  ];

  @override
  void onClose() {
    stopTimer();
    super.onClose();
  }
}
