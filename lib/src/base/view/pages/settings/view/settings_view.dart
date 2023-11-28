// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/resources/resources.dart';
import 'package:legal_links_app/services/auth_services.dart';
import 'package:legal_links_app/src/auth/model/user_model.dart';
import 'package:legal_links_app/src/auth/vm/auth_vm.dart';
import 'package:legal_links_app/src/base/vm/base_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../resources/app_images.dart';
import '../../../../../../utils/bottom_sheets/app_sheet.dart';
import '../../../../../../utils/bottom_sheets/forget_password_sheet.dart';
import '../../../../../../utils/bottom_sheets/update_password_sheet.dart';
import '../../../../../../utils/common-widgets/settings_widget.dart';
import '../../../../../../utils/hights_widths.dart';
import '../../../../../auth/view/login_screen.dart';
import 'privacy_policy_screen.dart';
import 'profile_screen.dart';
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
    return Consumer<AuthVM>(
      builder: (context, authVM, _) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                h2,
                Center(
                  child: CircleAvatar(
                    backgroundColor: R.colors.primary.withOpacity(.2),
                    radius: 70,
                    backgroundImage: NetworkImage(authVM.userModel.profileImages?.first ?? ""),
                    onBackgroundImageError: (exception, stackTrace) {
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: R.colors.primary.withOpacity(.8),
                              width: 1),
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
                  authVM.userModel.fullName ?? '',
                  style: R.textStyles.poppinsBold(fontSize: 15.sp),
                ),
                Text(authVM.userModel.email ?? '',
                    style: R.textStyles.poppinsRegular()),
                h4,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ScreenTileWidget(
                          iconVar: Icons.person,
                          title: 'Profile',
                          tap: () {
                            debugPrint('clicked');
                            Get.toNamed(ProfileScreen.route);
                          },
                        ),
                        // ScreenTileWidget(
                        //   iconVar: Icons.privacy_tip_rounded,
                        //   title: 'Rating and Reviews',
                        //   tap: () {
                        //     debugPrint('clicked');
                        //     Get.toNamed(RatingAndReviewsScreen.route);
                        //   },
                        // ),
                        // ScreenTileWidget(
                        //   iconVar: Icons.privacy_tip_rounded,
                        //   title: 'Verification',
                        //   tap: () {
                        //     debugPrint('clicked');
                        //     Get.toNamed(PrivacyPolicyScreen.route);
                        //   },
                        // ),

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
                          color: R.colors.red,
                          textColor: R.colors.red,
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
                                onRightTap: () async {
                                  debugPrint(
                                      "before${context.read<AuthVM>().userModel.email}");
                                  await Auth().signOut();
                                  context.read<AuthVM>().userModel =
                                      UserModel();
                                  context.read<BaseVM>().currentIndex = 0;
                                  context.read<BaseVM>().update();
                                  context.read<AuthVM>().update();
                                  debugPrint(
                                      "after ${context.read<AuthVM>().userModel.email}");
                                  Get.offAllNamed(LoginScreen.route);
                                },
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.sp, vertical: 8.sp),
                            margin: EdgeInsets.symmetric(
                              vertical: 8.sp,
                              horizontal: 8.sp,
                            ),
                            decoration: BoxDecoration(
                              color: R.colors.red.withOpacity(.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: double.infinity,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout_rounded,
                                  size: 18.sp,
                                  color: R.colors.red,
                                ),
                                w3,
                                Text(
                                  "Logout",
                                  style: R.textStyles.poppinsRegular(
                                      color: R.colors.red,
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
          ),
        );
      },
    );
  }
}
