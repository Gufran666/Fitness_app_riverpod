import 'package:fitness_app_riverpod/screens/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fitness_app_riverpod/screens/login_screen.dart';
import 'package:fitness_app_riverpod/providers/auth_provider.dart';
import 'package:fitness_app_riverpod/utils/theme.dart';
import 'package:fitness_app_riverpod/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final notificationService = NotificationService();
  notificationService.initialize();

  runApp(
    ProviderScope(
      child: MyApp(notificationService: notificationService),
    ),
  );
}

class MyApp extends ConsumerWidget {
  final NotificationService notificationService;

  const MyApp({super.key, required this.notificationService});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.read(authProvider.notifier).checkAuthStatus();

    return MaterialApp(
      title: 'Fitness App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routes: {
        '/': (context) =>  LoginScreen(),
        '/notifications': (context) => const NotificationsScreen(),

      },
    );
  }
}