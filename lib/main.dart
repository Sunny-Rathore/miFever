import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mifever/data/models/notification/notification.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/firebase_options.dart';
import 'package:mifever/presentation/chat_screen/chat_screen.dart';
import 'package:mifever/presentation/like_screen/like_screen.dart';

import 'core/app_export.dart';
import 'data/sevices/firebase_messageing_service.dart';
import 'data/sevices/notification_service.dart';
import 'data/sevices/stripe_service.dart';

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  print('-----main-----');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.initialize();
  await FirebaseMessagingService.initialize();
  await FirebaseMessagingService.generateToken();
  await FirebaseMessagingService.onBackgroundMessage();
  // await AnalyticsService.initMixpanel();
  await PrefUtils().init();
  Stripe.publishableKey = StripePaymentHandle.PUBLISHABLE_KEY;
  Stripe.merchantIdentifier = 'any string works';
  await Stripe.instance.applySettings();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    runApp(MyApp(navigatorKey: navigationKey));
  });

  // update use status on every minutes
  Timer.periodic(const Duration(minutes: 1), (Timer timer) {
    if (PrefUtils.getId().isNotEmpty) {
      UserModel userModel = UserModel(lasOnline: Timestamp.now());
      FirebaseServices.updateUser(userModel);
    }
  });
}

class MyApp extends StatefulWidget {
  @override
  const MyApp({Key? key, required this.navigatorKey}) : super(key: key);
  final GlobalKey navigatorKey;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Handle notification taps when the app is in the background but still running
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print(message.data['id']);
      if (PrefUtils.getId().isNotEmpty) {
        if (message.data['type'] == NotificationType.Chat.name) {
          Get.to(() => ChatScreen('${message.data['id']}'));
        } else {
          Get.to(() => LikeScreen());
        }
      }
    });
  }

  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        navigatorKey: navigationKey,
        debugShowCheckedModeBanner: false,
        theme: theme,
        translations: LocalizationService(),
        locale: Locale(PrefUtils.getLang()), //for setting localization strings
        fallbackLocale: Locale('en', 'US'),
        title: 'MiFever',
        initialBinding: InitialBindings(),
        initialRoute: AppRoutes.initialRoute,
        getPages: AppRoutes.pages,
      );
    });
  }
}

// void updateLastOnline() {
//   FIREBASE_FIRESTORE
//       .collection(USER_COLLECTION)
//       .doc(PrefUtils.getCurrentUserID())
//       .update({
//     'last_online': FieldValue.serverTimestamp(),
//   });
// }
// on App's user login initialize user in zegoCloud

// void onUserLogin() {
//   ZegoUIKitPrebuiltCallInvitationService().init(
//     notifyWhenAppRunningInBackgroundOrQuit: true,
//     appID: 205087729 /*input your AppID*/,
//     appSign:
//         'bc006c998c5b5fafcc21d32f67529d5dbb4e5b394c0598a6a9cf594dc249d1a2' /*input your AppSign*/,
//     userID: PrefUtils.getId(),
//     userName: PrefUtils.getUserName(),
//     plugins: [ZegoUIKitSignalingPlugin()],
//   );
// }

/// on App's user logout
// void onUserLogout() {
//   ZegoUIKitPrebuiltCallInvitationService().uninit();
// }
