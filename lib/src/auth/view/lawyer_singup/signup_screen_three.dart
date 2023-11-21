// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:legal_links_app/resources/validator.dart';
import 'package:legal_links_app/services/google_map/address_model.dart';
import 'package:legal_links_app/services/google_map/google_map_screen.dart';
import 'package:legal_links_app/src/auth/model/user_model.dart';
import 'package:legal_links_app/src/auth/view/lawyer_singup/complete_profile.dart';
import 'package:legal_links_app/src/auth/view/lawyer_singup/steper_widget.dart';
import 'package:legal_links_app/src/auth/view/login_screen.dart';
import 'package:legal_links_app/src/auth/vm/auth_vm.dart';
import 'package:legal_links_app/utils/common-widgets/custom_button.dart';
import 'package:legal_links_app/utils/zbot_toast.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../resources/resources.dart';
import '../../../../utils/common-widgets/custom_textformfield.dart';
import '../../../../utils/hights_widths.dart';

class SignupScreenThreeOfLawyer extends StatefulWidget {
  const SignupScreenThreeOfLawyer({super.key});

  @override
  State<SignupScreenThreeOfLawyer> createState() => _SignupScreenThreeOfLawyerState();
}

class _SignupScreenThreeOfLawyerState extends State<SignupScreenThreeOfLawyer> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController feeController = TextEditingController();
  TextEditingController assistantController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController caseCountController = TextEditingController();

  FocusNode feeFocus = FocusNode();
  FocusNode assistantFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  LatLng? latLng;
  PickLocationData? pickLocationData;

  var duration;



  
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();


  FocusNode passwordFocus = FocusNode();
  FocusNode confirmpasswordFocus = FocusNode();

  bool isObscure1 = false;
  bool isObscure2 = false;

  FocusNode aboutFocus = FocusNode();
  @override
  void initState() {
    super.initState();
    duration = const Duration(minutes: 30); // Initialize with a default value
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVM>(builder: (context, vm, _) {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 12.sp),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    controller: feeController,
                    focusNode: feeFocus,
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.number,
                    hintText: 'fee',
                    fieldTitle: "Your Fee ",
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    validator: FieldValidator.validateEmpty,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  CustomTextFormField(
                    controller: assistantController,
                    focusNode: assistantFocus,
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.text,
                    hintText: 'Assistant Name',
                    fieldTitle: "Assistant Name",
                  ),
                  CustomTextFormField(
                    controller: caseCountController,
                    //  focusNode: feeFocus,
                    inputAction: TextInputAction.next,
                    validator: FieldValidator.validateEmpty,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    hintText: '10',
                    fieldTitle: "Case Count",
                    inputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                  ),
                  CustomTextFormField(
                    controller: addressController,
                    focusNode: addressFocus,
                    inputAction: TextInputAction.next,
                    validator: FieldValidator.validateEmpty,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputType: TextInputType.streetAddress,
                    hintText: 'Address',
                    fieldTitle: "Your address",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        Get.to(
                          () => GoogleMapScreen(
                            selectedLocation: latLng,
                            address: (value) {
                              pickLocationData = value;
                              latLng = LatLng(value.lat ?? 0, value.lng ?? 0);
                              addressController.text = pickLocationData?.streetAddress ?? '';
                            },
                          ),
                        );
                        setState(() {});
                        debugPrint("pickLocationData $pickLocationData");
                      },
                      child: const Icon(Icons.location_pin),
                    ),
                  ),
                  h1,
                  CustomTextFormField(
                    controller: aboutController,
                    focusNode: aboutFocus,
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.text,
                    hintText: 'About Yourself',
                    fieldTitle: "About Yourself",
                    maxLines: 3,
                    // validator: FieldValidator.validateEmpty,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          confirmpasswordController.text,
                          passwordController.text),
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
                    h1,
                  h3,
                  CustomButton(
                    buttonTitle: "Complete",
                    tap: () async {
                      await butonFn(vm);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<void> butonFn(AuthVM vm) async {
    if (_formKey.currentState!.validate()) {
      ZBotToast.loadingShow();
      Timestamp now = Timestamp.now();
      vm.tempLawyerModel = UserModel(
        // page 1 data

        fullName: vm.tempLawyerModel.fullName,
        phoneNumber: vm.tempLawyerModel.phoneNumber,
        email: vm.tempLawyerModel.email,
        yearOfExperience: vm.tempLawyerModel.yearOfExperience,
        gender: vm.tempLawyerModel.gender,
        profileImages: vm.tempLawyerModel.profileImages ?? [],
        // page 2 data
        specialist: vm.tempLawyerModel.specialist,
        qualifications: vm.tempLawyerModel.qualifications,
        experience: vm.tempLawyerModel.experience,
        practiceAreas: vm.tempLawyerModel.practiceAreas,
        // current page
        about: aboutController.text.trim(),
        assistantName: aboutController.text.trim(),
        casesCount: int.parse(caseCountController.text.trim()),

        feePerMeeting: double.parse(feeController.text.trim()),
        isLawyerVerified: false,
        isVerified: false,

        officeAdress: OfficeAdress(
          city: pickLocationData?.city,
          country: pickLocationData?.country,
          latLng: GeoPoint(pickLocationData?.lat ?? 0, pickLocationData?.lng ?? 0),
          state: pickLocationData?.city,
          streetAdress: pickLocationData?.city,
          zipCode: pickLocationData?.city,
        ),
        role: context.read<AuthVM>().userRole,
        status: vm.tempLawyerModel.status,

        createdAt: now,
        updatedAt: now,
      );

      bool check = await context.read<AuthVM>().signUp(vm.tempLawyerModel, pass: confirmpasswordController.text.trim());
      if (check) {
        vm.tempLawyerModel = UserModel();
        // vm.password = '';

        context.read<AuthVM>().singupPage = 0;
        context.read<AuthVM>().singupPageController.jumpToPage(0);
        context.read<AuthVM>().update();
        ZBotToast.loadingClose();
        Get.toNamed(LoginScreen.route);
      }
    }
  }
}
