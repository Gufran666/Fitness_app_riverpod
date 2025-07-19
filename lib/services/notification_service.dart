import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:fitness_app_riverpod/models/notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static const AndroidInitializationSettings _androidInitSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  static const DarwinInitializationSettings _iosInitSettings =
  DarwinInitializationSettings();

  late final InitializationSettings _initSettings = InitializationSettings(
    android: _androidInitSettings,
    iOS: _iosInitSettings,
  );

  void initialize() {
    tz.initializeTimeZones();

    _flutterLocalNotificationsPlugin.initialize(
      _initSettings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload != null) {
          print('Notification tapped with payload: $payload');
        }
      },
    );
  }

  Future<void> showNotification(AppNotification notification) async {
    final int id = int.tryParse(notification.id) ?? notification.id.hashCode;

    const androidDetails = AndroidNotificationDetails(
      'your_channel_id',
      'Your Channel Name',
      channelDescription: 'Used for general alerts',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    final details = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _flutterLocalNotificationsPlugin.show(
      id,
      notification.title,
      notification.message,
      details,
      payload: notification.id,
    );
  }

  Future<void> scheduleWorkoutReminder(
      String title,
      String message,
      DateTime scheduledTime,
      ) async {
    final int id = scheduledTime.millisecondsSinceEpoch.remainder(100000);

    const androidDetails = AndroidNotificationDetails(
      'reminder_channel_id',
      'Reminder Channel',
      channelDescription: 'Used for workout reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    final details = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      message,
      tz.TZDateTime.from(scheduledTime, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: 'reminder_$id',
    );

  }
}
