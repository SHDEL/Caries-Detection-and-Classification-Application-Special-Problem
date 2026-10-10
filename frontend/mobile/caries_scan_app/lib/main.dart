import 'package:caries_scan_app/presentation/pages/sign_in.dart';
import 'package:caries_scan_app/presentation/pages/sign_up.dart';
import 'package:caries_scan_app/presentation/pages/splash.dart';
import 'package:caries_scan_app/presentation/pages/welcome.dart';
import 'package:caries_scan_app/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caries Scan',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomePage(),
        '/signup': (context) => const SignUpPage(),
        '/signin': (context) => const SignInPage(),
      },
    );
  }
}
