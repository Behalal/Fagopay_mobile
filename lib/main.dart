import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:fagopay/screens/authentication/session_signout_pincode_page.dart';
import 'package:fagopay/screens/authentication/sign_in.dart';
import 'package:fagopay/screens/constants/theme_config.dart';
import 'package:fagopay/service/local/local_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'appbinding/appbinding.dart';
import 'local_notification_services.dart';
import 'screens/core/splash_speen.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  final FlutterLocalNotificationsPlugin localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel androidChannel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  if (message.notification != null && Platform.isIOS) {
    await localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.initialize();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Get.put<LocalCachedData>(await LocalCachedData.create());
  final loggedIn = await LocalCachedData.instance.getLoginStatus();
  runApp(FagoPay(loggedIn: loggedIn,));
}

class FagoPay extends StatefulWidget {
  final bool? loggedIn;
  const FagoPay({
    Key? key, this.loggedIn,
  }) : super(key: key);

  @override
  State<FagoPay> createState() => _FagoPayState();
}

class _FagoPayState extends State<FagoPay> {

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: ((context, orientation, deviceType) {
        return GestureDetector(
            onTap: (){
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus!.unfocus();}
              },
          child: GetMaterialApp(
            initialBinding: AppBinding(),
            debugShowCheckedModeBanner: false,
            theme: AppTheme.applicationTheme(),
            home: const SplashScreen(),
          ),
        );
      }),
    );
  }
}
