import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:legal_links_app/constants/enums.dart';
import 'package:legal_links_app/resources/resources.dart';
import 'package:legal_links_app/src/auth/model/user_model.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/validator.dart';
import '../../../utils/common-widgets/custom_button.dart';
import '../../../utils/common-widgets/custom_textformfield.dart';
import '../../../utils/common-widgets/global_widget.dart';
import '../../../utils/hights_widths.dart';
import '../../../utils/zbot_toast.dart';
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

  PhoneNumber number = PhoneNumber(isoCode: 'PK');
  TextEditingController phoneNumberController = TextEditingController();
  FocusNode numberFN = FocusNode();

  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      // ZBotToast.showToastError(message: "Click exit again!");
      Get.offAllNamed(LoginScreen.route);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    // return Consumer2<AuthVM, RootProvider>(builder: (context, authVm, vm, _) {
    return WillPopScope(
      onWillPop: () async => await onWillPop(),
      child: SafeArea(
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
                  phoneNumberField(),
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
                          isObscure1 ? Icons.visibility_off_rounded : Icons.remove_red_eye_rounded,
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
                          isObscure2 ? Icons.visibility_off_rounded : Icons.remove_red_eye_rounded,
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
                          checkColor: R.colors.white,
                          activeColor: R.colors.primary,
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
                    buttonTitle: "Sign up",
                    tap: () async {
                      await buttonFn();
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
      ),
    );
  }

  Widget phoneNumberField() {
    return InternationalPhoneNumberInput(
      focusNode: numberFN,
      inputDecoration: InputDecoration(
        isDense: true,
        suffixIcon: Icon(
          Icons.phone_outlined,
          color: numberFN.hasFocus ? R.colors.primary : R.colors.grey,
        ),
        hintText: 'Number',
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 17,
        ),
        filled: true,
        focusColor: R.colors.primary,
        hintStyle: R.textStyles.poppinsRegular(fontSize: 11.sp, color: Colors.grey),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 0.5,
              color: R.colors.red,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 0.5,
              color: R.colors.primary,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: R.colors.grey,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 0.5,
              color: R.colors.red,
            )),
      ),
      onInputChanged: (PhoneNumber phonenumber) {
        number = phonenumber;
      },
      onInputValidated: (val) {
        debugPrint(val.toString());
      },
      selectorConfig: const SelectorConfig(
          leadingPadding: 10,
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          showFlags: false,
          setSelectorButtonAsPrefixIcon: true,
          trailingSpace: true),
      spaceBetweenSelectorAndTextField: 0,
      selectorTextStyle: TextStyle(color: R.colors.primary),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      initialValue: number,
      textFieldController: phoneNumberController,
      // validator: (value) => FieldValidator.validatePhoneNumber(
      //     phoneNumberController.text.trim(), context),
      formatInput: false,
      keyboardAction: TextInputAction.done,
      keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
      inputBorder: const UnderlineInputBorder(),
      onSaved: (PhoneNumber number) {
        debugPrint('On Saved: $number');
      },

      onFieldSubmitted: (value) {
        setState(() {});
        FocusScope.of(context).requestFocus(passwordFocus);
      },
    );
  }

  // UserModel createClient() {
  //   Timestamp now = Timestamp.now();
  //   return UserModel(
  //     role: UserRole.CLIENT,
  //     fullName: nameController.text.trim(),
  //     createdAt: now,
  //     updatedAt: now,
  //     phoneNumber: PhoneNumberModel(
  //       number: phoneNumberController.text.trim(),
  //       isoCode: number.isoCode,
  //       countryCode: number.dialCode,
  //     ),
  //     //  id: ,
  //     email: emailController.text.trim(),
  //     status: UserStatus.ACTIVE,
  //   );
  // }

  Future<void> buttonFn() async {
    if (_formKey.currentState!.validate()) {
      if (!isChecked) {
        ZBotToast.showToastError(message: "Please agree to the Privacy Policy and T&C.");
      } else {
        Timestamp now = Timestamp.now();
        UserModel createClient = UserModel(
          role: UserRole.CLIENT,
          fullName: nameController.text.trim(),
          createdAt: now,
          updatedAt: now,
          phoneNumber: PhoneNumberModel(
            number: phoneNumberController.text.trim(),
            isoCode: number.isoCode,
            countryCode: number.dialCode,
          ),
          //  id: ,
          email: emailController.text.trim(),
          status: UserStatus.ACTIVE,
        );
        debugPrint(" body : ${createClient}");
        debugPrint('role: ${UserRole.CLIENT}');
        debugPrint('fullName: ${nameController.text.trim()}');
        debugPrint('createdAt: $now');
        debugPrint('updatedAt: $now');
        debugPrint('phoneNumber: ${PhoneNumberModel(
          number: phoneNumberController.text.trim(),
          isoCode: number.isoCode,
          countryCode: number.dialCode,
        )}');
// Uncomment the line below if `id` is a property
// debugPrint('id: $id');
        debugPrint('phoneNumberController: ${phoneNumberController.text.trim()}');
        debugPrint('number.isoCode: ${number.isoCode}');
        debugPrint('number.dialCode: ${number.dialCode}');
        debugPrint('email: ${emailController.text.trim()}');
        debugPrint('status: ${UserStatus.ACTIVE}');
      }
    }
  }
}
