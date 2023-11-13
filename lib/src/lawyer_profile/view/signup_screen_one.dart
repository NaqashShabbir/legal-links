import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../resources/validator.dart';
import '../../../utils/common-widgets/custom_button.dart';
import '../../../utils/common-widgets/custom_textformfield.dart';
import '../../../utils/common-widgets/global_widget.dart';
import '../../../utils/hights_widths.dart';
import '../../../utils/zbot_toast.dart';
import '../../auth/view/login_screen.dart';
import 'signup_screen_two.dart';

class SignupScreenOneOfLawyer extends StatefulWidget {
  static String route = '/signupaslawyer';
  const SignupScreenOneOfLawyer({super.key});

  @override
  State<SignupScreenOneOfLawyer> createState() =>
      _SignupScreenOneOfLawyerState();
}

class _SignupScreenOneOfLawyerState extends State<SignupScreenOneOfLawyer> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController dateCon = TextEditingController();

  DateTime? selectedDate;

  FocusNode emailFocus = FocusNode();
  FocusNode numberFocus = FocusNode();
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

  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
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
                const Text('Step 1/5 About you'),
                h1,
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
                  controller: numberController,
                  focusNode: numberFocus,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  hintText: '0344-4343434',
                  fieldTitle: "Mobile Number",
                  obscureText: isObscure1,
                ),
                CustomTextFormField(
                  controller: confirmpasswordController,
                  focusNode: confirmpasswordFocus,
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.name,
                  hintText: '1',
                  fieldTitle: "Years of Experience",
                  obscureText: isObscure2,
                ),
                h3,
                h1,
                CustomButton(
                  buttonTitle: "Continue to next step",
                  tap: () async {
                    if (_formKey.currentState!.validate()) {
                      ZBotToast.showToastError(
                          message: "Please there will be no empty field.");
                    } else {
                      Get.toNamed(SignupScreenTwoOfLawyer.route);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
