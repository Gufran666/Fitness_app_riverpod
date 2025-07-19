import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_app_riverpod/screens/login_screen.dart';
import 'package:fitness_app_riverpod/screens/signup_screen.dart';
import 'package:fitness_app_riverpod/providers/auth_provider.dart';
import 'package:fitness_app_riverpod/utils/theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.read(authProvider.notifier).checkAuthStatus();

    return MaterialApp(
      title: 'Fitness App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
      },
    );
  }
}