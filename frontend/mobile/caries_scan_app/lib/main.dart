import 'package:caries_scan_app/firebase_options.dart';
import 'package:caries_scan_app/presentation/pages/home.dart';
import 'package:caries_scan_app/presentation/pages/sign_in.dart';
import 'package:caries_scan_app/presentation/pages/sign_up.dart';
import 'package:caries_scan_app/presentation/pages/splash.dart';
import 'package:caries_scan_app/presentation/pages/welcome.dart';
import 'package:caries_scan_app/presentation/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: const AuthGate(),
      routes: {
        '/auth': (context) => const AuthGate(),
        '/welcome': (context) => const WelcomePage(),
        '/signup': (context) => const SignUpPage(),
        '/signin': (context) => const SignInPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}

/// [AuthGate] ตรวจสอบสถานะการล็อกอินของผู้ใช้ผ่าน Firebase Authentication
/// - หากกำลังโหลด: แสดง SplashScreen
/// - หากล็อกอินแล้ว: นำทางไปยัง HomePage
/// - หากยังไม่ล็อกอิน: นำทางไปยัง WelcomePage
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen(autoNavigate: false);
        }

        if (snapshot.hasData && snapshot.data != null) {
          return const HomePage();
        }

        return const WelcomePage();
      },
    );
  }
}
