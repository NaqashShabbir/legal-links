import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/resources/resources.dart';
import 'package:legal_links_app/src/lawyer_profile/view/complete_profile.dart';
import 'package:legal_links_app/src/lawyer_profile/view/widget/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/common-widgets/custom_button.dart';
import '../../../utils/hights_widths.dart';

class SignupScreenFour extends StatefulWidget {
  static String route = '/signupScreenFour';
  const SignupScreenFour({super.key});

  @override
  State<SignupScreenFour> createState() => _SignupScreenFourState();
}

class _SignupScreenFourState extends State<SignupScreenFour> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 12.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create profile',
                  style: R.textStyles.poppinsSemiBold(),
                ),
              ],
            ),
            h3,
            Text(
              'Step 3/5 About you',
              style: R.textStyles.poppinsRegular(color: R.colors.primary),
            ),
            h1,
            Text(
              'Would you like to start online consult with customers',
              textAlign: TextAlign.center,
              style: R.textStyles.poppinsSemiBold(
                color: R.colors.black,
              ),
            ),
            h3,
            Text(
              'Would you like to start online consult with customers.',
              textAlign: TextAlign.start,
              style: R.textStyles.poppinsMedium(
                color: R.colors.darkGrey,
              ),
            ),
            Text(
              'Customers will pay the fee in advance to book online consultation.',
              textAlign: TextAlign.start,
              style: R.textStyles.poppinsMedium(
                color: R.colors.darkGrey,
              ),
            ),
            Text(
              'Team legel will manage your consult online.',
              textAlign: TextAlign.start,
              style: R.textStyles.poppinsMedium(
                color: R.colors.darkGrey,
              ),
            ),
            h3,
            CustomButtonSignup(
              text: "Yes, I want to consult online",
              tap: () async {
                Get.toNamed(CompleteProfile.route);
              },
            ),
            h1,
            CustomButtonSignup(
              text: "No, I dont want to consult online",
              tap: () async {
                Get.toNamed(CompleteProfile.route);
              },
            ),
          ],
        ),
      ),
    ));
  }
}
