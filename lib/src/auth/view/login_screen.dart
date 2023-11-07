// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/resources/app_images.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_text_styles.dart';
import '../../../utils/bottom_sheets/forget_password_sheet.dart';
import '../../../utils/common-widgets/custom_button.dart';
import '../../../utils/common-widgets/custom_textformfield.dart';
import '../../../utils/common-widgets/global_widget.dart';
import '../../../resources/validator.dart';
import '../../../utils/hights_widths.dart';
import '../vm/auth_vm.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static String route = "/loginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController(
      //text: 'ds@sss.ff'
      );
  TextEditingController passwordController = TextEditingController(
      // text: 'a222222@'
      );

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  bool ispObscure = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AuthVM>(builder: (context, vm, _) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 12.sp),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.logo, height: 25.h),
                  h2,
                  Text(
                    "Login",
                    style: AppTextStyles.poppinsBold(
                      color: AppColors.primary,
                      fontSize: 18.sp,
                    ),
                  ),
                  h2,
                  CustomTextFormField(
                    fieldTitle: "Email",
                    controller: emailController,
                    hintText: 'Enter email',
                    focusNode: emailFocus,
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.emailAddress,
                    validator: FieldValidator.validateEmail,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    focusNode: passwordFocus,
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.visiblePassword,
                    validator: FieldValidator.validatePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    hintText: 'Enter password',
                    fieldTitle: "Password",
                    obscureText: ispObscure,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          ispObscure = !ispObscure;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.sp),
                        child: Icon(
                          ispObscure
                              ? Icons.visibility_off_rounded
                              : Icons.remove_red_eye_rounded,
                          color: Colors.grey,
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  h2,
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        {
                          // Get.bottomSheet(ChangePasswordSheet());
                          Get.bottomSheet(
                            const ForgotPasswordSheet(
                              title: 'Forgot Password?',
                              subTitle:
                                  'Enter your reqistered Email ID We will send you a link to reset your password',
                              labelText: 'Email',
                              placeHolder: 'Enter email',
                              text: 'Proceed',
                            ),
                            isScrollControlled: true,
                          );
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Forgot Password?",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.poppinsMedium(
                              fontSize: 12.sp,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  h2,
                  CustomButton(
                    text: "Login",
                    tap: () async {
                      if (_formKey.currentState!.validate()) {
                        // await login(vm);
                      }
                    },
                  ),
                  h2,
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 8.sp),
            child: GlobalWidgets.authBottomWidget(
              "Don't have an account?",
              '  Sign up',
              () => Get.offAllNamed(SignupScreen.route),
            ),
          ),
        );
      }),
    );
  }

  // Future<void> login(AuthVM vm) async {
  //   ZBotToast.loadingShow();
  //   if (true) {
  //     context.read<RootProvider>().selectedScreenValue = 2;
  //     context.read<RootProvider>().update();
  //     Get.offAllNamed(UpdateProfileScreen.route,
  //         arguments: {"isFromLogin": true});
  //     ZBotToast.loadingClose();
  //   }
  // }
}
