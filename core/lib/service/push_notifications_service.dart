import 'package:core/di/app_di.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../core.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await pushNotificationsService.setupFlutterNotifications();
  await pushNotificationsService.showNotification(message);
}

final PushNotificationsService pushNotificationsService =
    PushNotificationsService(
  firebaseMessaging: FirebaseMessaging.instance,
  flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
);

class PushNotificationsService {
  final FirebaseMessaging firebaseMessaging;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  PushNotificationsService({
    required this.firebaseMessaging,
    required this.flutterLocalNotificationsPlugin,
  });

  bool isFlutterLocalNotificationsInitialized = false;

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await _requestPermissions();
    await _setupMessagingHandlers();

    final String? token = await firebaseMessaging.getToken();
    print('userFCMToken: $token');
  }

  Future<void> _requestPermissions() async {
    final NotificationSettings settings =
        await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  Future<void> setupFlutterNotifications() async {
    if (!isFlutterLocalNotificationsInitialized) {
      return;
    }

    //android setup
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      // description
      importance: Importance.high,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    //iOS setup
    const DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: darwinInitializationSettings,
    );

    //flutter notifications setup
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (
        NotificationResponse notificationResponse,
      ) {},
    );

    isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  Future<void> _setupMessagingHandlers() async {
    // foreground message
    FirebaseMessaging.onMessage.listen(showNotification);

    // background message
    FirebaseMessaging.onMessageOpenedApp.listen(_handlerBackgroundMessage);

    //opened app
    final RemoteMessage? initialMessage =
        await firebaseMessaging.getInitialMessage();

    if (initialMessage != null) {
      _handlerBackgroundMessage(initialMessage);
    }
  }

  void _handlerBackgroundMessage(RemoteMessage event) {
    // todo: add logic
  }
}
