import 'package:caries_scan_app/presentation/pages/sign_in.dart';
import 'package:caries_scan_app/presentation/theme/app_colors.dart';
import 'package:caries_scan_app/presentation/widgets/primary_app_button.dart';
import 'package:caries_scan_app/presentation/widgets/primary_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    // โค้ดสำหรับจัดการสมัครสมาชิก
  }

  void _handleGoogleSignUp() {
    // โค้ดสำหรับจัดการสมัครสมาชิกด้วย Google
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 36),
              PrimaryInput(
                text: 'Username',
                controller: _usernameController,
              ),
              const SizedBox(height: 20),
              PrimaryInput(
                text: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              PrimaryInput(
                text: 'Password',
                controller: _passwordController,
                isPassword: true,
              ),
              const SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                child: PrimaryAppButton(
                  text: 'Create an Account',
                  onPressed: _handleSignUp,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'or Sign Up with',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: _handleGoogleSignUp,
                borderRadius: BorderRadius.circular(24),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/appicon/google.svg',
                    width: 36,
                    height: 36,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// Alias สำหรับเรียกใช้ด้วยชื่อ SignUpPage หรือ SignUpScreen
typedef SignUpScreen = SignUpPage;
