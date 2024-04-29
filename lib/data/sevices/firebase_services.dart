// ignore_for_file: sdk_version_since

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/progress_dialog_utils.dart';
import 'package:mifever/data/models/thermometer_model/thermometer_model.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/data/sevices/firebase_messageing_service.dart';
import 'package:mifever/data/sevices/media_services/media_services.dart';
import 'package:mifever/presentation/chat_screen/models/chat_model.dart';
import 'package:mifever/presentation/help_and_support_screen/models/help_and_support_screen_model.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../presentation/chat_screen/controller/chat_controller.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../models/block/block_model.dart';
import '../models/like/like_model.dart';
import '../models/notification/notification.dart';
import '../models/report/report_model.dart';
import '../models/subscriptions/subscription_model.dart';
import '../models/text_tries_model/text_tries_model.dart';
import '../models/travel_plan/travel_plan_model.dart';
import 'firebase_analytics_service/firebase_analytics_service.dart';

class FirebaseServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

/*-----------Create User With Email and Password-----------*/
  static Future<bool> signUpWithEmail(
      {required String email, required String password}) async {
    return _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((userCredential) {
      if (userCredential.user != null) {
        Fluttertoast.showToast(msg: 'Success');
        return true;
      }
      return false;
    }).onError((error, stackTrace) {
      if (error is FirebaseAuthException) {
        Fluttertoast.showToast(
            msg: AuthExceptionHandler.handleException(error));
      } else {
        log('Error During SignUp with Email And Password', error: error);
      }
      return false;
    });
  }

/*-----------Sign In User With Email and Password-----------*/
  static Future<bool> signInWithEmail(
      {required String email, required String password}) async {
    ProgressDialogUtils.showProgressDialog();
    return _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((userCredential) async {
      if (userCredential.user != null) {
        // Fluttertoast.showToast(msg: 'Success');
        PrefUtils.setId(userCredential.user!.uid);
        FirebaseServices.getCurrentUser().then((value) {
          PrefUtils.setGender(value?.gender ?? '');
          PrefUtils.setUserEmail(value?.email ?? '');
          PrefUtils.setAvailableLocation(value?.availableLocation?[0] ?? '');
          AnalyticsService.initMixpanel();
        });
        ProgressDialogUtils.hideProgressDialog();
        UserModel userModel = UserModel(
          isNotificationOn: true,
          token: await FirebaseMessagingService.generateToken(),
        );

        await FirebaseServices.updateUser(userModel);
        return true;
      }
      return false;
    }).onError((error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      if (error is FirebaseAuthException) {
        Fluttertoast.showToast(
            msg: AuthExceptionHandler.handleException(error));
      } else {
        log('Error During SignUp with Email And Password', error: error);
      }
      return false;
    });
  }

  static Future<User?> signInWithGoogle() async {
    try {
      ProgressDialogUtils.showProgressDialog();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;
      PrefUtils.setId(authResult.user!.uid);
      if (authResult.additionalUserInfo!.isNewUser) {
        UserModel userModel = UserModel(
          planName: '',
          timestamp: DateTime.now().toUtc().toString(),
          token: await FirebaseMessagingService.generateToken(),
          email: authResult.user?.email ?? "",
          isProfileComplete: false,
        );
        await FirebaseServices.addUser(userModel);
        Get.offAllNamed(AppRoutes.questionOneScreen);
      } else {
        FirebaseServices.getCurrentUser().then((user) async {
          if (user != null) {
            if (user.isProfileComplete ?? false) {
              PrefUtils.setId(authResult.user!.uid);
              FirebaseServices.getCurrentUser().then((value) {
                PrefUtils.setGender(value?.gender ?? '');
                PrefUtils.setUserEmail(value?.email ?? '');
                PrefUtils.setAvailableLocation(
                    value?.availableLocation?[0] ?? '');
                AnalyticsService.initMixpanel();
              });
              PrefUtils.setUserName(user.name ?? '').then((value) {});
              UserModel userModel = UserModel(
                isNotificationOn: true,
                token: await FirebaseMessagingService.generateToken(),
              );
              await FirebaseServices.updateUser(userModel);
              Get.offAll(() => CustomBottomBar());
              //Get.offAllNamed(AppRoutes.homeScreen);
            } else {
              Get.offAllNamed(AppRoutes.questionOneScreen);
            }
          }
        });
      }
      return user;
    } catch (e) {
      log("Error during Google sign in:", error: e);
      return null;
    }
  }

// Function to send a password reset email
  static Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print('Password reset email sent to $email');
      Fluttertoast.showToast(msg: 'Password reset email sent to $email');
      // You can show a confirmation message to the user
    } catch (e) {
      if (e is FirebaseAuthException) {
        Fluttertoast.showToast(msg: AuthExceptionHandler.handleException(e));
      }
      print('Error sending password reset email: $e');
      // Handle the error, such as displaying an error message to the user
    }
  }

  static Future<bool> checkEmailExists(String email) async {
    try {
      // Fetch sign-in methods for the email address
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      print(list);
      // In case list is not empty
      if (list.isNotEmpty) {
        // Return true because there is an existing
        // user using the email address
        return true;
      } else {
        // Return false because email  is not in use
        return false;
      }
    } catch (error) {
      // Handle error
      return true;
    }
  }

/*-------Ad User--------*/
  static Future<bool> addUser(UserModel userModel) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .set(userModel.toJson());
      ProgressDialogUtils.hideProgressDialog();
      return true;
    } catch (e) {
      log('Error during add user', error: e);
      return false;
    }
  }

/*-------Update User--------*/
  static Future<bool> updateUser(UserModel userModel) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .update(userModel.toJson());
      ProgressDialogUtils.hideProgressDialog();
      return true;
    } catch (e) {
      log('Error during update user', error: e);
      return false;
    }
  }

/*-------Get User--------*/
  static Future<UserModel?> getCurrentUser() async {
    try {
      return await _firestore
          .collection('users')
          .doc(PrefUtils.getId())
          .get()
          .then((value) =>
              UserModel.fromJson(value.data() as Map<String, dynamic>));
    } catch (e) {
      log('Error during get user', error: e);
      return null;
    }
  }

  static Future<String> uploadFile(
      {required String filePath, required String contentType}) async {
    try {
      String base64Data = base64Encode(File(filePath).readAsBytesSync());
      String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
          '_' +
          filePath.split('/').last;
      print('fileName:==>$fileName');
      // Create a reference to the location you want to upload to in Firebase Storage
      Reference ref = _storage.ref().child('uploads/$fileName');

      // Set metadata (content type)
      SettableMetadata metadata = SettableMetadata(contentType: contentType);
      // Upload file to Firebase Storage
      UploadTask uploadTask = ref.putData(base64.decode(base64Data), metadata);

      // Await the upload to get the task snapshot
      TaskSnapshot taskSnapshot = await uploadTask;

      // Get the download URL
      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      log('Error uploading file:', error: e);
      return '';
    }
  }

/*-------add Way Album------*/
  static void addWayAlbum(String url) async {
    try {
      await _firestore.collection('users').doc(PrefUtils.getId()).update({
        'wayAlbum': FieldValue.arrayUnion([url])
      });
    } catch (e) {
      log('Error during add way album:', error: e);
    }
  }

/*-------add life Album------*/
  static void addLifeAlbum(String url) async {
    try {
      await _firestore.collection('users').doc(PrefUtils.getId()).update({
        'lifeAlbum': FieldValue.arrayUnion([url])
      });
    } catch (e) {
      log('Error during add life album:', error: e);
    }
  }

  /*-------edit Life Album------*/
  static void editLifeAlbum(List list) async {
    try {
      await _firestore
          .collection('users')
          .doc(PrefUtils.getId())
          .update({'lifeAlbum': list});
    } catch (e) {
      log('Error during edit life album:', error: e);
    }
  }

/*-------add Way Album------*/
  static void editWayAlbum(List list) async {
    try {
      await _firestore
          .collection('users')
          .doc(PrefUtils.getId())
          .update({'wayAlbum': list});
    } catch (e) {
      log('Error during edit life album:', error: e);
    }
  }

/*-----Get User---------*/
  static getUser() {
    return _firestore.collection('users').doc(PrefUtils.getId()).snapshots();
  }

/*-----Get All Users---------*/
  static getAllUsers() {
    return _firestore
        .collection('users')
        .where('id', isNotEqualTo: PrefUtils.getId())
        .where('isProfileComplete', isEqualTo: true)
        .snapshots();
  }

/*-----Get User By Id---------*/
  static getUserById(String id) {
    return _firestore.collection('users').doc(id).snapshots();
  }
/*-------Send Chat Message--------*/

  static Future<bool> sendMessage({
    required ChatModel chat,
  }) async {
    try {
      var chatRef = _firestore.collection('chats').doc(chat.roomId);
      chatRef.set({'timestamp': FieldValue.serverTimestamp()});
      chatRef.collection('messages').add(chat.toJson());
      return true;
    } catch (e) {
      log('Error during send message', error: e);
      return false;
    }
  }

/*---------Get Chats--------------*/
  static getChats(String receiverId) {
    try {
      return _firestore
          .collection('chats')
          .doc(createChatRoomId(receiverId))
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .snapshots();
    } catch (e) {
      log('Error during get chats', error: e);
    }
  }

/*---------Delete Chats--------------*/
  static deleteChats(String receiverId) async {
    try {
      // Get a reference to the collection
      CollectionReference collectionReference = _firestore
          .collection('chats')
          .doc(createChatRoomId(receiverId))
          .collection('messages');
      // Get all documents from the collection
      QuerySnapshot querySnapshot = await collectionReference.get();
      // Delete each document in the collection
      querySnapshot.docs.forEach((document) async {
        await document.reference.delete();
      });
    } catch (e) {
      log('Error during delete chats', error: e);
    }
  }

/*---------Get Last Chats--------------*/
  static getLastChats(String receiverId) {
    try {
      return _firestore
          .collection('chats')
          .doc(createChatRoomId(receiverId))
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots();
    } catch (e) {
      log('Error during get chats', error: e);
    }
  }

/*---------ad like ------*/
  static addLike({required String receiverId}) async {
    try {
      DocumentReference docRef = FirebaseFirestore.instance
          .collection('likes')
          .doc(createChatRoomId(receiverId));
      // Fetch the document snapshot
      DocumentSnapshot docSnapshot = await docRef.get();
      // Check if the document exists
      if (docSnapshot.exists) {
        // Send push notification
        sendChatNotification(
            type: NotificationType.Chat.name,
            id: receiverId,
            message: 'You are matched with ${PrefUtils.getUserName()}');
        ThermometerModel thermometerModel = ThermometerModel(
            timestamp: DateTime.now().toString(),
            roomId: FirebaseServices.createChatRoomId(receiverId),
            percentageValue: 100,
            userIds: [receiverId, PrefUtils.getId()]);
        await FirebaseServices.addThermometerValue(thermometerModel);
        LikeModel likeModel =
            LikeModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
        Duration difference =
            DateTime.now().difference(DateTime.parse(likeModel.timestamp!));

        await _firestore
            .collection('likes')
            .doc(createChatRoomId(receiverId))
            .update({
          'updateTimestamp': DateTime.now().toString(),
          'userIds': FieldValue.arrayUnion([PrefUtils.getId()]),
          'isMatched': true,
          'isSuperLiked': difference.inSeconds < 30
        });
      } else {
        ThermometerModel thermometerModel = ThermometerModel(
            timestamp: DateTime.now().toString(),
            roomId: FirebaseServices.createChatRoomId(receiverId),
            percentageValue: 80,
            userIds: [receiverId, PrefUtils.getId()]);
        await FirebaseServices.addThermometerValue(thermometerModel);
        LikeModel like = LikeModel(
            isDeleted: false,
            roomId: FirebaseServices.createChatRoomId(receiverId),
            userIds: [PrefUtils.getId()],
            notSeenUserIds: [PrefUtils.getId(), receiverId],
            timestamp: DateTime.now().toString(),
            updateTimestamp: DateTime.now().toString(),
            isMatched: false,
            isSuperLiked: false,
            directMatch: false);
        await _firestore
            .collection('likes')
            .doc(createChatRoomId(receiverId))
            .set(like.toJson());
      }
    } catch (e) {
      log('Error During add like', error: e);
    }
  }

  /* update like for chat order */
  static Future<void> updateLike(
      {required LikeModel likeModel, required String receiverId}) async {
    await _firestore
        .collection('likes')
        .doc(createChatRoomId(receiverId))
        .update(likeModel.toJson());
  }

/* add math user from chat------*/

  static makeMatchFromChat(String receiverId) async {
    try {
      await _firestore
          .collection('likes')
          .doc(createChatRoomId(receiverId))
          .set({
        'roomId': createChatRoomId(receiverId),
        'isDeleted': false,
        'updateTimestamp': DateTime.now().toString(),
        'userIds': [PrefUtils.getId(), receiverId],
        'isMatched': true,
        'isSuperLiked': false,
        'directMatch': true,
        'requestedTo': receiverId,
        'timestamp': DateTime.now().toString(),
      });
    } catch (e) {
      log('Error during make match from chat', error: e);
    }
  }

  static updateMakeMatchFromChat(String receiverId) async {
    try {
      await _firestore
          .collection('likes')
          .doc(createChatRoomId(receiverId))
          .update({
        'directMatch': false,
      });
    } catch (e) {
      log('Error during make match from chat', error: e);
    }
  }

  static doUnMatch(String receiverId) async {
    try {
      await _firestore
          .collection('likes')
          .doc(createChatRoomId(receiverId))
          .update({
        'isDeleted': true,
      });
    } catch (e) {
      log('Error during unMatch', error: e);
    }
  }

  /* get AllMatch Use */
  static getAllMatchUser() {
    return _firestore
        .collection('likes')
        .where('isMatched', isEqualTo: true)
        .where('userIds', arrayContains: PrefUtils.getId())
        .snapshots();
  }

/* get AllMatch Use */
  static getNotDeletedUser() {
    return _firestore
        .collection('likes')
        .where('isMatched', isEqualTo: true)
        .where('isDeleted', isEqualTo: false)
        .where('userIds', arrayContains: PrefUtils.getId())
        .snapshots();
  }

  static Future<LikeModel?> getAllMatchedDataByUserId(String receiverId) async {
    try {
      return await _firestore
          .collection('likes')
          .doc(createChatRoomId(receiverId))
          .get()
          .then((value) {
        print('likeData1=>' + value.data().toString());
        LikeModel likeModel =
            LikeModel.fromJson(value.data() as Map<String, dynamic>);
        print(likeModel);
        return likeModel;
      });
    } catch (e) {
      log('Error during get like data', error: e);
      return null;
    }
  }

/*---------fetchLikedUser------*/
  static getAllMatchRealUser({directMatch = false}) {
    return _firestore
        .collection('likes')
        .where('isMatched', isEqualTo: true)
        .where('directMatch', isEqualTo: directMatch)
        .where('userIds', arrayContains: PrefUtils.getId())
        .snapshots();
  }

/*---------------*/
  static Future<List> getAllMatchUserIds() async {
    var _matchedData = await _firestore
        .collection('likes')
        .where('isMatched', isEqualTo: true)
        .where('userIds', arrayContains: PrefUtils.getId())
        .get();
    List<LikeModel> _matchedUser = <LikeModel>[];
    _matchedUser.clear();
    _matchedUser =
        _matchedData.docs.map((e) => LikeModel.fromJson(e.data())).toList();
    Set<dynamic> combinedSet = {};
    for (var x in _matchedUser) {
      combinedSet.addAll(x.userIds!);
    }
    List<dynamic> combinedList = combinedSet.toList();
    combinedList.remove(PrefUtils.getId());
    print('combinedList=>$combinedList');
    return combinedList;
  }

  static Future<bool> approveChatRequest(String receiverId) async {
    try {
      _firestore.collection('likes').doc(createChatRoomId(receiverId)).update({
        'notSeenUserIds': FieldValue.arrayRemove([PrefUtils.getId()]),
      });
      return true;
    } catch (e) {
      log('Error During isMatched User', error: e);
      return false;
    }
  }

  static Future<bool> isRequested(String receiverId) async {
    try {
      return await _firestore
          .collection('likes')
          .doc(createChatRoomId(receiverId))
          .get()
          .then((doc) {
        var data = doc.data();
        if (data != null && data.isNotEmpty) {
          if (data['directMatch'] && data['requestedTo'] == PrefUtils.getId()) {
            return true;
          }
          return false;
        } else {
          return false;
        }
      });
    } catch (e) {
      log('Error During isMatched User', error: e);
      return false;
    }
  }

  /* here i am checking this is exact or real match */
  static Future<bool> isRealMatched(String receiverId) async {
    print("directMatch1");
    try {
      return await _firestore
          .collection('likes')
          .doc(createChatRoomId(receiverId))
          .get()
          .then((doc) {
        var data = doc.data();
        print("directMatch2" + data.toString());

        if (data != null) {
          LikeModel model = LikeModel.fromJson(data);
          print(model.isMatched);
          print(model.updateTimestamp);
          print(model.directMatch);
          print("directMatch3");
          if (model.isMatched ?? false) {
            if (model.directMatch ?? false) {
              print("directMatch4");
              return false;
            } else {
              print("directMatch5");
              return true;
            }
          } else {
            print("directMatch6");
            return false;
          }
        } else {
          print("directMatch7");
          return false;
        }
        // return value.data()?.isNotEmpty ?? false;
      });
    } catch (e) {
      log('Error During isMatched User', error: e);
      return false;
    }
  }

/*-------- generate unique chat id for one to one user -----*/
  static String createChatRoomId(String receiverId) {
    List<String> userIds = [PrefUtils.getId(), receiverId];
    userIds.sort(); // Sort the user IDs to ensure consistency
    return userIds.join('_');
  }

/*------------Ad notification----------*/
  static Future<void> addNotification(NotificationModel notification) async {
    try {
      if (notification.type == NotificationType.View.name) {
        await _firestore
            .collection('notifications')
            .where('notificationBy', isEqualTo: notification.notificationBy)
            .where('notificationTo', isEqualTo: notification.notificationTo)
            .where('type', isEqualTo: notification.type)
            .get()
            .then((value) async {
          int length = value.docs.length;
          if (length == 0) {
            await _firestore
                .collection('notifications')
                .add(notification.toJson());
          }
        });
      } else {
        await _firestore.collection('notifications').add(notification.toJson());
      }
    } catch (e) {
      log('Error During Add Notification');
    }
  }

/*------------get my likes notification----------*/
  static getMyLikes() {
    return _firestore
        .collection('notifications')
        .where('notificationBy', isEqualTo: PrefUtils.getId())
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

/*------------get LikedMe notification----------*/
  static getLikedMe() {
    return _firestore
        .collection('notifications')
        .where('notificationTo', isEqualTo: PrefUtils.getId())
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

/*------Block user-------*/
  static addBlockUser(BlockModel model) async {
    await _firestore.collection('blockedUsers').add(model.toJson());
  }

/*------Report user-------*/
  static reportUser(ReportModel model) async {
    await _firestore.collection('reportUsers').add(model.toJson());
  }

/*------ get Block user-------*/
  static getBlockUser(String receiverId) {
    return _firestore
        .collection('blockedUsers')
        .where('blockBy', isEqualTo: PrefUtils.getId())
        .where('blockTo', isEqualTo: receiverId)
        .snapshots();
  }

/*------ get Block user-------*/
  static getBlockByUser(String receiverId) {
    return _firestore
        .collection('blockedUsers')
        .where('blockBy', isEqualTo: receiverId)
        .where('blockTo', isEqualTo: PrefUtils.getId())
        .snapshots();
  }

  static Future<bool> isInBlockTable(String receiverId) async {
    try {
      return await _firestore
          .collection('blockedUsers')
          .where('roomId', isEqualTo: createChatRoomId(receiverId))
          .get()
          .then((value) {
        print('block length ${value.docs.length}');
        if (value.docs.length > 0) {
          print('yes');
          return true;
        } else {
          print('no');
          return false;
        }
      });
    } catch (e) {
      log('error during in block table', error: e);
      return false;
    }
  }

  static getAllBlockedUser() {
    return _firestore.collection('blockedUsers').snapshots();
  }

/*------ unBlock Block user-------*/
  static unBlockUser(String docId) async {
    await _firestore.collection('blockedUsers').doc(docId).delete();
  }

/*-----Media Chat------*/
  static Future<bool> sendMediaChat(String receiverId) async {
    try {
      Media? media = await MediaServices.pickFilePathAndExtension();
      if (media != null) {
        String roomId = FirebaseServices.createChatRoomId(receiverId);
        String docId = const Uuid().v4();
        final _chat = ChatModel(
          roomId: roomId,
          isSeen: false,
          receiverId: receiverId,
          senderId: PrefUtils.getId(),
          message: '',
          timestamp: DateTime.now().toString(),
          type: MessageType.Media.name,
          url: '',
          fileName: media.name,
          fileExtension: media.fileExtension,
          linkCount: 0,
          userIdsOfUsersForStarredMessage: [],
          userIdsOfUsersForDeletedMessage: [],
        );
        var chatRef = _firestore.collection('chats').doc(roomId);
        chatRef.set({'timestamp': FieldValue.serverTimestamp()});
        chatRef.collection('messages').doc(docId).set(_chat.toJson());

        //send Push Notification
        FirebaseServices.sendChatNotification(
            type: NotificationType.Chat.name,
            id: receiverId,
            message: '📂 Media');
        String url = await uploadFile(
            filePath: media.path, contentType: media.fileExtension);
        chatRef.collection('messages').doc(docId).update({'url': url});
        return true;
      }
      return false;
    } catch (e) {
      log('Error during sendMedia:', error: e);
      return false;
    }
  }

/*-----Voice Message------*/
  static Future<bool> sendVoiceChat(
      {required ChatModel chat, required String path}) async {
    try {
      // Media? media = await MediaServices.pickFilePathAndExtension();
      //if (media != null) {
      String roomId = FirebaseServices.createChatRoomId(chat.receiverId ?? "");
      String docId = const Uuid().v4();

      var chatRef = _firestore.collection('chats').doc(roomId);
      chatRef.set({'timestamp': FieldValue.serverTimestamp()});
      chatRef.collection('messages').doc(docId).set(chat.toJson());
      //send Push Notification
      FirebaseServices.sendChatNotification(
          type: NotificationType.Chat.name,
          id: chat.receiverId ?? '',
          message: '🎤 Voice Message');
      String url = await uploadFile(filePath: path, contentType: '.mp3');
      chatRef.collection('messages').doc(docId).update({'url': url});
      return true;
    } catch (e) {
      log('Error during voice chat:', error: e);
      return false;
    }
  }

  static Future<bool> sendVideoChat(String receiverId) async {
    try {
      String filePath = await MediaServices.recordVideo();
      if (filePath.isNotEmpty) {
        String roomId = FirebaseServices.createChatRoomId(receiverId);
        String docId = const Uuid().v4();
        final _chat = ChatModel(
          roomId: roomId,
          isSeen: false,
          receiverId: receiverId,
          senderId: PrefUtils.getId(),
          timestamp: DateTime.now().toString(),
          type: MessageType.Video.name,
          url: '',
          fileExtension: '.mp4',
        );
        var chatRef = _firestore.collection('chats').doc(roomId);
        chatRef.set({'timestamp': FieldValue.serverTimestamp()});
        chatRef.collection('messages').doc(docId).set(_chat.toJson());

        //Send Push Notification
        FirebaseServices.sendChatNotification(
            type: NotificationType.Chat.name,
            id: receiverId,
            message: "🎥 Video");
        String url = await uploadFile(filePath: filePath, contentType: '.mp4');
        chatRef.collection('messages').doc(docId).update({'url': url});
        String? thumbnailUrl = await generateAndUploadThumbnail(url);
        chatRef
            .collection('messages')
            .doc(docId)
            .update({'thumbnailUrl': thumbnailUrl});
        return true;
      }
      return false;
    } catch (e) {
      log('Error during send video:', error: e);
      return false;
    }
  }

/*------Add Themometer Value---------*/
  static addThermometerValue(ThermometerModel thermometerModel) async {
    try {
      await _firestore
          .collection('thermometer')
          .doc(thermometerModel.roomId)
          .set({
        'timestamp': thermometerModel.timestamp,
        'userIds': FieldValue.arrayUnion(thermometerModel.userIds!),
        'roomId': thermometerModel.roomId,
        'percentageValue': thermometerModel.percentageValue,
      });
    } catch (e) {
      log('Error during add Thermometer', error: e);
    }
  }

/*------Get Themometer Value---------*/
  static Future<ThermometerModel?> getThermometerValue(
      String receiverId) async {
    try {
      return await _firestore
          .collection('thermometer')
          .doc(createChatRoomId(receiverId))
          .get()
          .then((value) {
        print('value');
        print(value.data());
        ThermometerModel thermometerModel =
            ThermometerModel.fromJson(value.data() as Map<String, dynamic>);
        return thermometerModel;
      });
    } catch (e) {
      log('Error during get Thermometer', error: e);
      return null;
    }
  }

  /*------Get Themometer Value---------*/
  static getThermometerValueAsStream(String receiverId) {
    return _firestore
        .collection('thermometer')
        .doc(createChatRoomId(receiverId))
        .snapshots();
  }
/*------Add Subscription---------*/

  static addSubscription(SubscriptionModel subscriptionModel) async {
    try {
      await _firestore
          .collection('subscriptions')
          .add(subscriptionModel.toJson());
    } catch (e) {
      log('Error during add Subscription', error: e);
    }
  }
/*------Add TextTries---------*/

  static addTextTriesSubscription(TextTriesModel textTriesModel) async {
    try {
      await _firestore.collection('textTries').add(textTriesModel.toJson());
    } catch (e) {
      log('Error during add textTries Subscription', error: e);
    }
  }

  static getSubscription() {
    return _firestore
        .collection('subscriptions')
        .where('userId', isEqualTo: PrefUtils.getId())
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  static Future<String> getCurrentSubscription() async {
    var plans = await _firestore
        .collection('subscriptions')
        .where('userId', isEqualTo: PrefUtils.getId())
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    List<SubscriptionModel> _subscriptionsList = <SubscriptionModel>[];
    _subscriptionsList =
        plans.docs.map((e) => SubscriptionModel.fromJson(e.data())).toList();
    if (_subscriptionsList.length > 0) {
      print(_subscriptionsList[0].plan.id!.value);
      return _subscriptionsList[0].plan.id!.value;
    } else {
      print('plan==> no plan');
      return '';
    }
  }

  // get textTries
  static Future<String> getCurrentTexTriesSubscription() async {
    var plans = await _firestore
        .collection('textTries')
        .where('userId', isEqualTo: PrefUtils.getId())
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    List<TextTriesModel> _textTriesList = <TextTriesModel>[];
    _textTriesList =
        plans.docs.map((e) => TextTriesModel.fromJson(e.data())).toList();
    if (_textTriesList.length > 0) {
      print(_textTriesList[0].chances);
      return _textTriesList[0].chances;
    } else {
      print(PrefUtils.getId());
      print('no Changes==> no plan');
      return '0 Chances';
    }
  }

  static updateTextTries(String chances) async {
    print(chances);
    try {
      var plans = await _firestore
          .collection('textTries')
          .where('userId', isEqualTo: PrefUtils.getId())
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();
      print(plans.docs.length);
      if (plans.docs.length > 0) {
        String docId = plans.docs[0].id;
        print(docId);
        await _firestore
            .collection('textTries')
            .doc(docId)
            .update({'chances': chances});
      }
      plans.docs.map((e) {});
    } catch (e) {
      log('Error During update textTries', error: e);
    }
  }

  static addTravelPlan(TravelPlanModel travelPlanModel) async {
    try {
      await _firestore.collection('travel_plans').add(travelPlanModel.toJson());
    } catch (e) {
      log('Error during add travel PLans', error: e);
    }
  }

  static updateTravelPlan(
      {required TravelPlanModel travelPlanModel, required String docId}) async {
    try {
      await _firestore
          .collection('travel_plans')
          .doc(docId)
          .update(travelPlanModel.toJson());
    } catch (e) {
      log('Error during update travel PLans', error: e);
    }
  }

  static deleteTravelPlan({required String docId}) async {
    try {
      await _firestore.collection('travel_plans').doc(docId).delete();
    } catch (e) {
      log('Error during delete travel PLans', error: e);
    }
  }

  static getTravelPlan() {
    return _firestore
        .collection('travel_plans')
        .where('userId', isEqualTo: PrefUtils.getId())
        .snapshots();
  }

  static void likedFieldChanges() {
    try {
      print("errorrr1");
      Query query = _firestore
          .collection('likes')
          .where('isMatched', isEqualTo: false)
          .where('userIds', arrayContains: PrefUtils.getId())
          .where('directMatch', isEqualTo: false);
      // Create a stream from the query
      Stream<QuerySnapshot> stream = query.snapshots();
      // Listen to changes in the stream
      stream.listen((QuerySnapshot snapshot) {
        // Handle changes here
        if (snapshot.docs.isNotEmpty) {
          for (var index = 0; index < snapshot.docs.length; index++) {
            String timestampString = snapshot.docs[index]['timestamp'];

            // Create a DateFormatter to parse the timestamp string
            DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
            // Parse the timestamp string into a DateTime object
            DateTime timestampDateTime = formatter.parse(timestampString);
            // Calculate the time that was 24 hours ago from the current time
            DateTime twentyFourHoursAgo =
                DateTime.now().subtract(Duration(hours: 24));
            // Compare the parsed DateTime with the calculated 24 hours earlier time
            if (timestampDateTime.isBefore(twentyFourHoursAgo)) {
              print('The timestamp is 24 hours earlier than the current time.');
              String roomId = snapshot.docs[index].id;
              addThermometerValue(ThermometerModel(
                  roomId: roomId,
                  percentageValue: 0,
                  userIds: roomId.split("-"),
                  timestamp: Timestamp.now().toString()));
            } else {
              print(
                  'The timestamp is not 24 hours earlier than the current time.');
            }
          }
        }
      });
    } catch (e) {
      print("errorrr" + e.toString());
    }
  }

// Find Match Users
  static void listenToFieldChanges() {
    // Set up the query
    Query query = _firestore
        .collection('likes')
        .where('isMatched', isEqualTo: true)
        .where('notSeenUserIds', arrayContains: PrefUtils.getId())
        .limit(1);
    // Create a stream from the query
    Stream<QuerySnapshot> stream = query.snapshots();
    // Listen to changes in the stream
    stream.listen((QuerySnapshot snapshot) {
      // Handle changes here
      if (snapshot.docs.isNotEmpty) {
        String id = snapshot.docs[0].id
            .replaceAll(PrefUtils.getId(), '')
            .replaceAll("_", "");
        bool isSuperlike = snapshot.docs[0]['isSuperLiked'];
        if (isSuperlike) {
          print('object ::$isSuperlike');
          Get.toNamed(AppRoutes.matchScreenOneScreen, arguments: [id]);
        } else {
          Get.toNamed(AppRoutes.matchScreenTwoScreen, arguments: [id]);
        }
        _firestore.collection('likes').doc(createChatRoomId(id)).update({
          'notSeenUserIds': FieldValue.arrayRemove([PrefUtils.getId()]),
        });
        print("id==" + id.toString());
      } else {
        print('No matching documents found.');
      }
    });
  }

// Find Match Users
  static void listenToFieldIsApproved() {
    // Set up the query
    Query query = _firestore
        .collection('users')
        .where('id', isEqualTo: PrefUtils.getId())
        .limit(1);
    // Create a stream from the query
    Stream<QuerySnapshot> stream = query.snapshots();
    // Listen to changes in the stream
    stream.listen((QuerySnapshot snapshot) {
      // Handle changes here
      if (snapshot.docs.isNotEmpty) {
        UserModel user =
            UserModel.fromJson(snapshot.docs[0].data() as Map<String, dynamic>);
        bool isApproved = user.isApproved ?? true;
        if (isApproved) {
          print('object ::$isApproved');
        } else {
          Get.rawSnackbar(message: 'lbl_due_to_policy_violation'.tr);
          // Fluttertoast.showToast(
          //   msg: 'lbl_due_to_policy_violation'.tr,
          // );
          PrefUtils.clearPreferencesData();
          Get.offAllNamed(AppRoutes.onboardingScreen);
        }
      } else {
        print('No documents found.');
      }
    });
  }

  static void sendChatNotification(
      {required String id,
      required String message,
      required String type}) async {
    print('$message');
    try {
      await _firestore.collection('users').doc(id).get().then((value) async {
        UserModel userModel =
            UserModel.fromJson(value.data() as Map<String, dynamic>);

        if (NotificationType.Chat.name == type) {
          LikeModel likeModel =
              LikeModel(chatTimeStamp: DateTime.now().toString());
          updateLike(likeModel: likeModel, receiverId: userModel.id ?? '');
        }
        if (userModel.isNotificationOn ?? true) {
          await FirebaseMessagingService.sendNotification(
            type: type,
            token: userModel.token!,
            title: '${PrefUtils.getUserName()}',
            // + "Send You a message".tr,
            body: message,
            id: "${userModel.id}",
          );
        }
      });
    } catch (e) {
      log('Error during send chat message', error: e);
    }
  }

/*------get disliked user-----------*/
  static Future<List<NotificationModel>> allDisLikedUserByMe() async {
    try {
      print('try1212121');
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('notifications')
          .where('type', isEqualTo: NotificationType.DisLike.name)
          .where('notificationBy', isEqualTo: PrefUtils.getId())
          .get();
      var data = snapshot.docs;
      List<NotificationModel> _dislikeNotification = <NotificationModel>[];
      _dislikeNotification.clear();
      _dislikeNotification =
          data.map((e) => NotificationModel.fromJson(e.data())).toList();
      return _dislikeNotification;
    } catch (e) {
      log('Error During  Get Dislike User', error: e);
      return <NotificationModel>[];
    }
  }

/*------get disliked user-----------*/
  static Future<List<NotificationModel>> allLikedUserByMe() async {
    try {
      print('try1212121');
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('notifications')
          .where('type', isEqualTo: NotificationType.Like.name)
          .where('notificationBy', isEqualTo: PrefUtils.getId())
          .get();
      var data = snapshot.docs;
      List<NotificationModel> _dislikeNotification = <NotificationModel>[];
      _dislikeNotification.clear();
      _dislikeNotification =
          data.map((e) => NotificationModel.fromJson(e.data())).toList();
      return _dislikeNotification;
    } catch (e) {
      log('Error During  Get like User', error: e);
      return <NotificationModel>[];
    }
  }

/*-----Update Chat------*/
  static updateChat({required String senderId, required docId}) {
    _firestore
        .collection('chats')
        .doc(createChatRoomId(senderId))
        .collection('messages')
        .doc(docId)
        .update({"isSeen": true});
  }

/*-----help and Support ------*/
  static addHelAndSupport(HelpAndSupportModel model) async {
    try {
      _firestore.collection('help_and_support').add(model.toJson());
    } catch (e) {
      log('Error during add help and support', error: e);
    }
  }

/*-----get Setting  ------*/
  static getSettings() {
    return _firestore
        .collection('Settings')
        .doc('Mway4o5ez3rm9n99tSbh')
        .snapshots();
  }

  static Future<void> handleLogOut() async {
    googleSignIn.signOut();
    _auth.signOut();
  }

  static Future<String?> generateAndUploadThumbnail(String videoUrl) async {
    Uint8List? thumbnailData;
    try {
      thumbnailData = await VideoThumbnail.thumbnailData(
        video: videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 200, // Adjust the thumbnail width as needed
        quality: 25, // Adjust the thumbnail quality as needed
      );
    } catch (e) {
      print('Error generating thumbnail: $e');
      return null; // Return null in case of an error
    }

    if (thumbnailData != null) {
      // Initialize Firebase Storage
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageRef =
          storage.ref().child('thumbnails').child('thumbnail.jpg');

      try {
        // Upload thumbnail to Firebase Storage
        TaskSnapshot uploadTask = await storageRef.putData(thumbnailData);

        // Get download URL for the uploaded thumbnail
        String downloadUrl = await uploadTask.ref.getDownloadURL();
        return downloadUrl;
      } catch (e) {
        print('Error uploading thumbnail to Firebase Storage: $e');
        return null; // Return null in case of an error
      }
    } else {
      return null; // Return null if thumbnail data is null
    }
  }

  static getLaws(String country) {
    return _firestore
        .collection('laws')
        .where('country', isEqualTo: country)
        .snapshots();
  }
}
