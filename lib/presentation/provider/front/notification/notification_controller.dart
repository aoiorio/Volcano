import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_controller.g.dart';


@riverpod
class NotificationController extends _$NotificationController {
  final flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

  @override
  bool build() {
    return false;
  }

  Future<void> requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      // final androidImplementation =
      //     flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      //         AndroidFlutterLocalNotificationsPlugin>();
      // await androidImplementation?.requestPermission();
    }
  }
}
