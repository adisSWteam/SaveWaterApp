import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/services.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:save_water/authentication/auth_gate.dart';
import 'package:save_water/home/start_page.dart';
import 'package:save_water/events/event_menu.dart';
import 'package:save_water/events/international_events.dart';
import 'package:save_water/events/local_events.dart';
import 'package:save_water/gallery/galleryV2.dart';
import 'package:save_water/tracker/watertracker_menu.dart';
import 'package:save_water/tracker/manualTrackerWithDB.dart';
import 'package:save_water/scannable_tracker/scannable_tracker.dart';
import 'package:save_water/acknolage/acknolage.dart';
import 'package:save_water/history/history.dart';

import 'package:save_water/theme/theme.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FirebaseMessaging.onBackgroundMessage(_firebasePushHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // ignore: avoid_print
    print("Message from Push Notification is ${message.data}");
    AwesomeNotifications().createNotificationFromJsonData(message.data);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // ignore: avoid_print
    print("Message from Push Notification is ${message.data}");
    AwesomeNotifications().createNotificationFromJsonData(message.data);
  });
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelName: 'ADIS Save Water',
          channelKey: 'adis_swa',
          channelDescription: 'Notification channel for Save Water App',
          playSound: true,
          enableVibration: true,
          enableLights: true),
    ],
    debug: true,
  );
  FlutterNativeSplash.remove();

  return runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Start(),
        '/auth': (context) => const AuthGate(),
        '/home/water/manual': (context) => const manualRework(),
        '/home/water/scan': (context) => const ScannableTracker(),
        '/home/water': (context) => const WaterMenu(),
        '/home/event': (context) => const eventMenu(),
        '/home/event/international': (context) => const InterEvents(),
        '/home/event/local': (context) => const LocalEvents(),
        '/home/gallery': (context) => const Gallery(),
        '/home/thanks': (context) => const thanks(),
        '/home/water/history': (context) => const History(),
      },
      color: primaryColor,
    ),
  );
}

// ignore: no_leading_underscores_for_local_identifiers
Future<void> _firebasePushHandler(RemoteMessage message) async {
  // ignore: avoid_print
  print("Message from Push Notification is ${message.data}");
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}
