import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../base/utils/utilities.dart';
import '../../features/device_management/app_state.dart';
import '../../features/device_management/bloc/device_management_bloc.dart';
import '../../injector/injector.dart';
import '../api_log_service.dart';
import '../crashlytics_service/crashlytics_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //await Firebase.initializeApp();
  Utilities.printObj("Handling a background message: ${message.messageId}");
}

class PushNotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  androidNotificationChannel() => const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.max,
      );

  PushNotificationService({required CrashlyticsService crashlyticsService})
      : _crashlyticsService = crashlyticsService {
    init();
  }

  final CrashlyticsService _crashlyticsService;

  init() async {
    FlutterError.onError = (errorDetails) {
      _crashlyticsService.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      _crashlyticsService.recordError(error, stack, fatal: true);
      return true;
    };
    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      Injector.instance<DeviceManagementBloc>().add(SetFCMTokenEvent());
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await _setupInteractedMessage();
    await _registerNotificationListeners();
  }

  Future<void> _setupInteractedMessage() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Utilities.printObj("App open in Firebase");
      _onPushNotificationFetched(message, NotificationAppState.onClick);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data.containsKey("custom")) {
        return;
      }
      _onPushNotificationFetched(
          message, NotificationAppState.onForegroundListen);
    });

    await _enableIOSNotifications();
    await _registerNotificationListeners();
  }

  _enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  _registerNotificationListeners() async {
    await _setUpAndroidNotificationSettings();
    var androidSettings = const AndroidInitializationSettings('drawable/logo');
    var iOSSettings = const DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    var initSetttings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);
    _flutterLocalNotificationsPlugin.initialize(
      initSetttings,
      onDidReceiveNotificationResponse: (details) {
        if ((details.payload ?? '') == '') {
          Injector.instance<ApiLogService>().showLog();
        }
      },
    );
  }

  _onPushNotificationFetched(
      RemoteMessage message, NotificationAppState state) {
    _flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.notification!.title,
        message.notification!.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            androidNotificationChannel().id,
            androidNotificationChannel().name,
            channelDescription: androidNotificationChannel().description,
          ),
        ));
  }

  _setUpAndroidNotificationSettings() async {
    AndroidNotificationChannel channel = androidNotificationChannel();
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  resetFCMToken() {
    FirebaseMessaging.instance
        .deleteToken()
        .then((value) => FirebaseMessaging.instance.getToken());
  }

  addInitialMessageListener() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _onPushNotificationFetched(
          initialMessage, NotificationAppState.appLaunched);
    }
  }

  Future<String?> getPushToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings _ = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    return FirebaseMessaging.instance.getToken();
  }
}
