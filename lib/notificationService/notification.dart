import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // Initialize the notification service
  static Future<void> initialize() async {
    // Initialize timezone
    tz.initializeTimeZones();

    // Android initialization settings
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization settings
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Combine initialization settings
    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // Initialize the plugin
    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: onNotificationTapped,
    );

    // Request permissions for Android 13+
    if (Platform.isAndroid) {
      await requestAndroidPermissions();
    }
  }

  // Handle notification tap
  static void onNotificationTapped(NotificationResponse response) {
    debugPrint('Notification tapped: ${response.payload}');
    // Handle navigation or other actions here
    // You can use a navigation service or callback to navigate to specific screens
  }

  // Request permissions for Android 13+
  static Future<void> requestAndroidPermissions() async {
    if (Platform.isAndroid) {
      final androidInfo = await Permission.notification.request();
      debugPrint('Notification permission: $androidInfo');
    }
  }

  // Show instant notification
  static Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const NotificationDetails platformDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'wallpaper_channel',
        'Wallpaper Notifications',
        channelDescription: 'Notifications for wallpaper app',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _notifications.show(
      id,
      title,
      body,
      platformDetails,
      payload: payload,
    );
  }

  // Schedule notification
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? payload,
  }) async {
    const NotificationDetails platformDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'wallpaper_scheduled_channel',
        'Scheduled Wallpaper Notifications',
        channelDescription: 'Scheduled notifications for wallpaper changes',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      platformDetails,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  // Schedule repeating notification
  static Future<void> scheduleRepeatingNotification({
    required int id,
    required String title,
    required String body,
    required RepeatInterval interval,
    String? payload,
  }) async {
    const NotificationDetails platformDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'wallpaper_repeat_channel',
        'Repeating Wallpaper Notifications',
        channelDescription: 'Repeating notifications for wallpaper app',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _notifications.periodicallyShow(
      id,
      title,
      body,
      interval,
      platformDetails,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  // Schedule custom interval notification (for wallpaper changes)
  static Future<void> scheduleWallpaperChangeNotification({
    required Duration interval,
    required String category,
    required String setAs
  }) async {
    // Cancel any existing wallpaper notifications
    await cancelNotification(999);

    final now = DateTime.now();
    final scheduledTime = now.add(interval);

    await scheduleNotification(
      id: 999,
      title: 'Time for a new wallpaper! 🎨',
      body: 'Your $category wallpaper is ready to be changed to your $setAs screen.',
      scheduledTime: scheduledTime,
      payload: 'wallpaper_change',
    );

    debugPrint('Wallpaper notification scheduled for: $scheduledTime');
  }

  // Cancel specific notification
  static Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  // Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  // Get pending notifications
  static Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }

  // Check if notifications are enabled
  static Future<bool> areNotificationsEnabled() async {
    if (Platform.isAndroid) {
      final status = await Permission.notification.status;
      return status == PermissionStatus.granted;
    } else if (Platform.isIOS) {
      final result = await _notifications
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      return result ?? false;
    }
    return false;
  }
}