import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/src/auth/view/signup_screen.dart';
import 'package:legal_links_app/utils/hights_widths.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../resources/resources.dart';
import '../../../../../../../utils/common-widgets/custom_app_button.dart';
import '../../../../../../lawyer_profile/view/signup_screen_one.dart';

class ConfirmationDialog extends StatefulWidget {
  const ConfirmationDialog({super.key});

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.transparent,
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 7.w),
          decoration: BoxDecoration(
            color: R.colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.20),
                offset: const Offset(-5, -2),
                blurRadius: 12,
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.20),
                offset: const Offset(3, 3),
                blurRadius: 12,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: R.colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.clear,
                      size: 16,
                      color: R.colors.black,
                    ),
                  ),
                ),
              ),
              h1,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.sp),
                width: double.infinity,
                child: AppButton(
                  borderRadius: 10,
                  buttonTitle: 'Signup as a customer',
                  onTap: () {
                    Get.toNamed(SignupScreen.route);
                  },
                ),
              ),
              h1,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.sp),
                width: double.infinity,
                child: AppButton(
                  borderRadius: 10,
                  buttonTitle: 'Signup as a Lawyer',
                  onTap: () {
                    Get.toNamed(SignupScreenOneOfLawyer.route);
                  },
                ),
              ),
              h4,
            ],
          ),
        ),
      ),
    );
  }
}
