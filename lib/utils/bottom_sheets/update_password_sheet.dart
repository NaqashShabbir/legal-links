// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../hights_widths.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_text_styles.dart';
import '../common-widgets/custom_button.dart';
import '../common-widgets/custom_textformfield.dart';
import '../../resources/validator.dart';
import 'congragulations_sheet.dart';

class UpdatePasswordSheet extends StatefulWidget {
  const UpdatePasswordSheet({super.key});

  @override
  State<UpdatePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<UpdatePasswordSheet> {
  FocusNode passwordFocus = FocusNode();

  FocusNode confirmPasswordFocus = FocusNode();
  FocusNode oldPasswordFocus = FocusNode();

  bool ispObscure = false;

  bool isObscure2 = false;
  bool oldPassObs = false;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
      width: 100.w,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              h1,
              Text(
                'Change Password',
                style: AppTextStyles.poppinsBold(
                    color: AppColors.black, fontSize: 15.sp),
              ),
              h2,
              Text(
                'Must include letter number and symbols.',
                style: AppTextStyles.poppinsRegular(color: AppColors.black),
              ),
              h2,
              CustomTextFormField(
                controller: oldPasswordController,
                focusNode: oldPasswordFocus,
                inputAction: TextInputAction.next,
                inputType: TextInputType.visiblePassword,
                validator: FieldValidator.validateOldPassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                hintText: 'Old password',
                fieldTitle: "Old Password",
                obscureText: oldPassObs,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      oldPassObs = !oldPassObs;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.sp),
                    child: Icon(
                      oldPassObs
                          ? Icons.visibility_off_rounded
                          : Icons.remove_red_eye_rounded,
                      color: Colors.grey,
                      size: 16.sp,
                    ),
                  ),
                ),
              ),
              CustomTextFormField(
                controller: newPasswordController,
                focusNode: passwordFocus,
                inputAction: TextInputAction.next,
                inputType: TextInputType.visiblePassword,
                validator: FieldValidator.validatePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                hintText: 'Enter new password',
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
              CustomTextFormField(
                controller: confirmPasswordController,
                focusNode: confirmPasswordFocus,
                inputAction: TextInputAction.done,
                inputType: TextInputType.visiblePassword,
                validator: (val) => FieldValidator.validatePasswordMatch(
                    newPasswordController.text, confirmPasswordController.text),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                hintText: 'Re-enter new password',
                fieldTitle: "Confirm Password",
                obscureText: isObscure2,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscure2 = !isObscure2;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.sp),
                    child: Icon(
                      isObscure2
                          ? Icons.visibility_off_rounded
                          : Icons.remove_red_eye_rounded,
                      color: Colors.grey,
                      size: 16.sp,
                    ),
                  ),
                ),
              ),
              h3,
              CustomButton(
                text: "Proceed",
                tap: () {
                  if (_formKey.currentState!.validate()) {
                    Get.back();
                    Get.bottomSheet(
                      CongratulationsSheet(
                        onApprove: () {
                          Get.back();
                        },
                        subTitle:
                            'Your password has been updated successfully.',
                      ),
                      isScrollControlled: true,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
