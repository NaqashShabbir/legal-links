import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/common-widgets/custom_button.dart';
import '../../../resources/common-widgets/custom_textformfield.dart';
import '../../../resources/common-widgets/global_widget.dart';
import '../../../resources/validator.dart';
import '../../../utils/hights_widths.dart';
import '../../../utils/zbot_toast.dart';
import '../vm/auth_vm.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  static String route = "/signupScreen";
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  showSnackBar(context, text) {
    var snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar((snackBar));
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController dateCon = TextEditingController();

  DateTime? selectedDate;

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmpasswordFocus = FocusNode();
  FocusNode nameFocus = FocusNode();
  FocusNode dateFocus = FocusNode();
  FocusNode genderFn = FocusNode();

  bool isObscure1 = false;
  bool isObscure2 = false;

  bool isChecked = false;
  //PhoneNumber number = PhoneNumber(isoCode: 'PK');
  TextEditingController phoneNumberController = TextEditingController();

  FocusNode numberFN = FocusNode();
  @override
  Widget build(BuildContext context) {
    // return Consumer2<AuthVM, RootProvider>(builder: (context, authVm, vm, _) {
    return SafeArea(
      child: Scaffold(
        appBar: GlobalWidgets.appBar(
          "Sign Up",
          onTap: () {
            Get.offAllNamed(LoginScreen.route);
          },
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 12.sp),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                h3,
                CustomTextFormField(
                  fieldTitle: "Full Name",
                  controller: nameController,
                  hintText: 'Enter name',
                  focusNode: nameFocus,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.name,
                  validator: FieldValidator.validateEmpty,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
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
                h1,
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
                ),
                CustomTextFormField(
                  controller: confirmpasswordController,
                  focusNode: confirmpasswordFocus,
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.visiblePassword,
                  validator: (val) => FieldValidator.validatePasswordMatch(
                      confirmpasswordController.text, passwordController.text),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  hintText: 'Enter confirm password',
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
                InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () {
                    setState(() {
                      isChecked = !isChecked;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                        checkColor: AppColors.white,
                        activeColor: AppColors.primary,
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                      ),
                      const Text(
                        'I agree to the Privacy Policy and T&C.',
                      ),
                    ],
                  ),
                ),
                h1,
                CustomButton(
                  text: "Sign up",
                  tap: () async {
                    if (_formKey.currentState!.validate()) {
                      if (!isChecked) {
                        ZBotToast.showToastError(
                            message:
                                "Please agree to the Privacy Policy and T&C.");
                      } else {
                        //await singup(authVm);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 8.sp),
          child: GlobalWidgets.authBottomWidget(
            "Already have an account?",
            '  LogIn',
            () => Get.offAllNamed(LoginScreen.route),
          ),
        ),
      ),
    );
  }

  // Future<void> singup(AuthVM vm) async {
  //   ZBotToast.loadingShow();
  //   Map body = {
  //     "fullname": nameController.text.trim(),
  //     "email": emailController.text.trim(),
  //     "password": passwordController.text.trim(),
  //     "confirmpassword": confirmpasswordController.text.trim(),
  //   };
  //   debugPrint("body:");
  //   debugPrint("$body");

  //   bool check = await vm.singup(body: body);

  //   if (check) {
  //     bool isOtpReceived =
  //         await vm.otp(body: {"email": emailController.text.trim()});
  //     if (isOtpReceived) {
  //       debugPrint("");
  //       Get.bottomSheet(
  //         OTPSheet(
  //           email: emailController.text,
  //           onTap: () {
  //             Get.back();
  //           },
  //           isEmail: true,
  //         ),
  //         isScrollControlled: true,
  //       );

  //       ZBotToast.loadingClose();
  //     }
  //   }
  // }
}
