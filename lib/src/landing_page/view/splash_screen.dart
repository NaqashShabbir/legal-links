import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_images.dart';
import '../../../resources/app_text_styles.dart';
import '../../auth/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static String route = "/splashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> startTimer() async {
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        Get.offAllNamed(LoginScreen.route);
      },
    );
  }

  @override
  void initState() {
    startTimer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.logo, scale: 4),
              Text(
                "LEGAL LINKS",
                textAlign: TextAlign.center,
                style: AppTextStyles.poppinsBold().copyWith(
                  color: AppColors.primary,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
