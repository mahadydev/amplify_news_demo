import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class FCMService extends BaseViewModel {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  StreamSubscription? _onMessageSubscription;
  StreamSubscription? _onMessageOpenedAppSubsciption;

  init() async {
    await getFCMPermission();

    _onMessageSubscription =
        FirebaseMessaging.onMessage.listen(onMessageListen);

    setupInteractedMessage();

    String? token = await _messaging.getToken();
    debugPrint('$token');
  }

  Future getFCMPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  Future onMessageListen(RemoteMessage message) async {
    if (message.notification != null) {
      //CAN DO STAFF WHEN TITLE == SOMETHING
      switch (message.notification?.title) {
        case '':
          break;
        default:
          break;
      }
    }
  }

  Future<void> setupInteractedMessage() async {
    final RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    _onMessageOpenedAppSubsciption =
        FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    // final status = GetStorage().read('login_status') ?? false;
    // if (status) {
    //   Timer(const Duration(seconds: 2), () {
    //     Get.toNamed(Routes.HOME);
    //   });
    // }
  }

  @override
  void dispose() {
    _onMessageSubscription?.cancel();
    _onMessageOpenedAppSubsciption?.cancel();
    super.dispose();
  }
}
