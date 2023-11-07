// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../src/auth/view/login_screen.dart';
import '../../src/auth/vm/auth_vm.dart';
import '../../utils/hights_widths.dart';
import '../../utils/zbot_toast.dart';
import '../app_colors.dart';
import '../app_text_styles.dart';
import '../common-widgets/custom_button.dart';
import '../common-widgets/custom_textformfield.dart';
import '../validator.dart';
import 'otp_sheet.dart';

class ForgotPasswordSheet extends StatefulWidget {
  final String title;
  final String subTitle;
  final String text;
  final String labelText;
  final String placeHolder;
  final bool? isFromDelete;

  const ForgotPasswordSheet({
    super.key,
    required this.title,
    required this.subTitle,
    required this.text,
    required this.labelText,
    required this.placeHolder,
    this.isFromDelete = false,
  });

  @override
  State<ForgotPasswordSheet> createState() => _ForgotPasswordSheetState();
}

class _ForgotPasswordSheetState extends State<ForgotPasswordSheet> {
  FocusNode emailFocus = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocus = FocusNode();
  bool isObscure1 = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVM>(builder: (context, vm, _) {
      return Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
        width: 100.w,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              h2,
              Text(
                widget.title,
                style: AppTextStyles.poppinsBold(
                    color: AppColors.black, fontSize: 15.sp),
              ),
              h2,
              Text(
                widget.subTitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.poppinsRegular(color: AppColors.black),
              ),
              h2,
              if (widget.isFromDelete ?? false)
                CustomTextFormField(
                  controller: passwordController,
                  focusNode: passwordFocus,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.visiblePassword,
                  validator: FieldValidator.validatePassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  hintText: 'Enter password',
                  fieldTitle: "Password",
                  obscureText: isObscure1,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscure1 = !isObscure1;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.sp),
                      child: Icon(
                        isObscure1
                            ? Icons.visibility_off_rounded
                            : Icons.remove_red_eye_rounded,
                        color: Colors.grey,
                        size: 16.sp,
                      ),
                    ),
                  ),
                )
              else
                CustomTextFormField(
                  fieldTitle: widget.labelText,
                  controller: emailController,
                  hintText: widget.placeHolder,
                  focusNode: emailFocus,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.emailAddress,
                  validator: FieldValidator.validateEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              h3,
              CustomButton(
                text: widget.text,
                tap: () {
                  if (_formKey.currentState!.validate()) {
                    // otp(vm, emailController.text);
                    if (widget.isFromDelete ?? false) {
                      Get.back();
                      Get.offAllNamed(LoginScreen.route);
                    } else {
                      Get.back();

                      Get.bottomSheet(
                        OTPSheet(
                          email: emailController.text,
                          onTap: () {},
                          isEmail: true,
                        ),
                        isScrollControlled: true,
                      );
                    }
                  }
                },
              ),
              h3,
            ],
          ),
        ),
      );
    });
  }

  // Future<void> otp(
  //   AuthVM vm,
  //   String email,
  // ) async {
  //   ZBotToast.loadingShow();
  //   var body = {
  //     'email': email,
  //   };
  //   bool chack = await vm.otp(body: body);
  //   if (chack) {
  //     ZBotToast.loadingClose();
  //   }
  // }
}
