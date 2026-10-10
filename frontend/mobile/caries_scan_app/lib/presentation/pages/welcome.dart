import 'package:caries_scan_app/presentation/pages/sign_in.dart';
import 'package:caries_scan_app/presentation/pages/sign_up.dart';
import 'package:caries_scan_app/presentation/widgets/outline_app_button.dart';
import 'package:caries_scan_app/presentation/widgets/primary_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                'assets/appicon/app_icon.svg',
                width: 145,
                height: 145,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: PrimaryAppButton(
                  text: 'Sign Up',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlineAppButton(
                  text: 'I already have an account',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInPage(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}

// Alias สำหรับเรียกใช้ด้วยชื่อ WelcomePage หรือ WelcomeScreen
typedef WelcomeScreen = WelcomePage;
