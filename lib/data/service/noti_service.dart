import 'package:agora_vai/domain/model/notificacao.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  // INITIALIZE
  Future<bool> initNotification() async {
    if (_isInitialized) return true;

    try {
      // prepare ANDROID init settings
      const initSettingsAndroid = AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );

      // prepare iOS init settings
      const initSettingsIOS = DarwinInitializationSettings();

      // init settings
      const initSettings = InitializationSettings(
        android: initSettingsAndroid,
        iOS: initSettingsIOS,
      );

      // finally initialize the plugin
      await notificationsPlugin.initialize(initSettings);
      _isInitialized = true;
      return true;
    } catch (e) {
      _isInitialized = false;
      return false;
    }
  }

  // REQUEST PERMISSIONS
  Future<bool> requestPermissions() async {
    if (!_isInitialized) {
      final initialized = await initNotification();
      if (!initialized) return false;
    }

    try {
      final android = await notificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();

      final ios = await notificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);

      return (android ?? false) || (ios ?? false);
    } catch (e) {
      return false;
    }
  }

  // NOTIFICATIONS DETAIL SETUP
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notification',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  //SHOW NOTIFICATION
  Future<void> showNotification(Notificacao notificacao) async {
    if (!_isInitialized) {
      final initialized = await initNotification();
      if (!initialized) {
        throw Exception('Falha ao inicializar o serviço de notificações');
      }
    }

    final hasPermission = await requestPermissions();
    if (!hasPermission) {
      throw Exception('Permissão para notificações não concedida');
    }

    return notificationsPlugin.show(
      notificacao.id,
      notificacao.title,
      notificacao.body,
      notificationDetails(),
    );
  }

  // ON NOTI TAP
}
