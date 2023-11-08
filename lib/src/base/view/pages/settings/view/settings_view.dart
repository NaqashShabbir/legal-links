import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/resources/resources.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../resources/app_images.dart';
import '../../../../../../utils/bottom_sheets/app_sheet.dart';
import '../../../../../../utils/bottom_sheets/forget_password_sheet.dart';
import '../../../../../../utils/bottom_sheets/update_password_sheet.dart';
import '../../../../../../utils/common-widgets/settings_widget.dart';
import '../../../../../../utils/hights_widths.dart';
import '../../../../../auth/view/login_screen.dart';
import 'privacy_policy_screen.dart';
import 'rating_and_reviews_screen.dart';
import 'term_and_conditions_screen.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          h2,
          Center(
            child: CircleAvatar(
              backgroundColor: R.colors.primary.withOpacity(.2),
              radius: 70,
              backgroundImage: NetworkImage(AppImages.dummyImage),
              onBackgroundImageError: (exception, stackTrace) {
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                        color: R.colors.primary.withOpacity(.8), width: 1),
                  ),
                  child: Icon(
                    Icons.error,
                    color: R.colors.black,
                  ),
                );
              },
            ),
          ),
          h3,
          Text(
            'jone Done',
            style: R.textStyles.poppinsBold(fontSize: 15.sp),
          ),
          Text('joneDone@gmail.com', style: R.textStyles.poppinsRegular()),
          h4,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScreenTileWidget(
                    iconVar: Icons.privacy_tip_rounded,
                    title: 'Rating and Reviews',
                    tap: () {
                      debugPrint('clicked');
                      Get.toNamed(RatingAndReviewsScreen.route);
                    },
                  ),
                  ScreenTileWidget(
                    iconVar: Icons.privacy_tip_rounded,
                    title: 'Verification',
                    tap: () {
                      debugPrint('clicked');
                      Get.toNamed(PrivacyPolicyScreen.route);
                    },
                  ),
                  ScreenTileWidget(
                    iconVar: Icons.privacy_tip_rounded,
                    title: 'Profile',
                    tap: () {
                      debugPrint('clicked');
                      Get.toNamed(PrivacyPolicyScreen.route);
                    },
                  ),
                  ScreenTileWidget(
                    iconVar: Icons.text_snippet_rounded,
                    title: 'Terms & Conditions',
                    tap: () {
                      Get.toNamed(TermsAndConditions.route);
                    },
                  ),
                  ScreenTileWidget(
                    iconVar: Icons.privacy_tip_rounded,
                    title: 'Privacy Policy ',
                    tap: () {
                      debugPrint('clicked');
                      Get.toNamed(PrivacyPolicyScreen.route);
                    },
                  ),
                  ScreenTileWidget(
                    iconVar: Icons.lock,
                    title: 'Change Password',
                    tap: () {
                      Get.bottomSheet(
                        const UpdatePasswordSheet(),
                        isScrollControlled: true,
                      );
                    },
                  ),
                  ScreenTileWidget(
                    iconVar: Icons.delete_rounded,
                    title: 'Delete Account',
                    tap: () {
                      Get.bottomSheet(
                        const ForgotPasswordSheet(
                          isFromDelete: true,
                          title: 'Delete Account',
                          subTitle:
                              'Deleting your account will remove all your data from our database. It cannot be undone',
                          labelText: 'Password',
                          placeHolder: 'Enter Password',
                          text: 'Delete Account',
                        ),
                      );
                    },
                  ),
                  //h4,
                  InkWell(
                    onTap: () {
                      Get.bottomSheet(
                        AppBottomSheet(
                          title: "Logout",
                          subtitle: "Are you sure you want to logout?",
                          onLeftTap: () => Get.back(),
                          onRightTap: () => Get.offAllNamed(LoginScreen.route),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.sp, vertical: 8.sp),
                      decoration: BoxDecoration(
                        color: R.colors.primary.withOpacity(.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            size: 18.sp,
                            color: R.colors.primary,
                          ),
                          w3,
                          Text(
                            "Logout",
                            style: R.textStyles.poppinsRegular(
                                color: R.colors.primary,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  h2,
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
