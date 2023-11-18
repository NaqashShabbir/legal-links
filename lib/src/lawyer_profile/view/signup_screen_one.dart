import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:legal_links_app/constants/enums.dart';
import 'package:legal_links_app/services/image_picker_service/image_picker_option.dart';
import 'package:legal_links_app/src/lawyer_base/view/pages/dashboard/vm/lawyer_vm.dart';
import 'package:legal_links_app/src/lawyer_profile/view/widget/custom_button.dart';
import 'package:legal_links_app/src/lawyer_profile/view/widget/steper_widget.dart';
import 'package:legal_links_app/src/lawyer_profile/vm/signup_lawyer.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../resources/resources.dart';
import '../../../resources/validator.dart';
import '../../../utils/common-widgets/custom_textformfield.dart';
import '../../../utils/common-widgets/global_widget.dart';
import '../../../utils/common-widgets/phone_number_field.dart';
import '../../../utils/hights_widths.dart';
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
  FocusNode colorF = FocusNode();
  FocusNode numberF = FocusNode();
  FocusNode genderFn = FocusNode();

  bool isObscure1 = false;
  bool isObscure2 = false;

  bool isChecked = false;
  PhoneNumber number = PhoneNumber(isoCode: 'PK');
  TextEditingController phoneNumberController = TextEditingController();

  FocusNode numberFN = FocusNode();

  DateTime? currentBackPressTime;
  File? profileImage;

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupLawyer>(builder: (context, vm, _) {
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
                  SteperWidget(
                    currentStep: 1,
                  ),
                  h2,
                  pickImageWidget(vm),
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
                  PhoneNumberField(
                    fieldTitle: "phone Number",
                    number: number,
                    nextNode: colorF,
                    numberFN: numberF,
                    phoneNumberController: phoneNumberController,
                    // valueChanged: ,
                  ),
                  CustomTextFormField(
                    controller: confirmpasswordController,
                    focusNode: confirmpasswordFocus,
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.text,
                    hintText: '1',
                    fieldTitle: "Years of Experience",
                    obscureText: isObscure2,
                  ),
                  h1,
                  Text(
                    'Gender',
                    style: R.textStyles.poppinsMedium(
                      fontSize: 11.sp,
                      color: Colors.black,
                    ),
                  ),
                  h1,
                  genderDropDown(vm: vm),
                  h3,
                  h1,
                  // CustomButton(
                  //   buttonTitle: "Continue to next step",
                  //   tap: () async {
                  //     if (_formKey.currentState!.validate()) {
                  //       ZBotToast.showToastError(
                  //           message: "Please there will be no empty field.");
                  //     } else {
                  //       Get.toNamed(SignupScreenTwoOfLawyer.route);
                  //     }
                  //   },
                  // ),
                  CustomButtonSignup(
                    text: 'Continue to next step',
                    tap: () {
                      Get.toNamed(SignupScreenTwoOfLawyer.route);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  GenderEnum? selectedGender;

  Widget genderDropDown({required SignupLawyer vm}) {
    return DropdownButtonFormField<GenderEnum>(
      //focusNode: maritalFn,
      borderRadius: BorderRadius.circular(8),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: GenderEnum.values.map((GenderEnum m) {
        return DropdownMenuItem<GenderEnum>(
          value: m,
          child: Text(
            getGenderString(m),
            style: R.textStyles.poppinsRegular(
              fontSize: 8.sp,
              color: Colors.black,
            ),
          ),
        );
      }).toList(),
      decoration: R.decoration.fieldDecoration(hintText: "Select Gender"),
      value: selectedGender,
      onChanged: (GenderEnum? newValue) {
        setState(() {
          selectedGender = newValue;
        });
      },
    );
  }

  Widget pickImageWidget(SignupLawyer vm) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        Get.dialog(
          ImagePickerOption(
            uploadImage: (value) async {
              if (value != null) {
                profileImage = value;
                vm.update();
                setState(() {});
              }
            },
            isPhotoPicked: profileImage == null ? false : true,
            removeImageFn: () {
              profileImage = null;
              setState(() {});
              Navigator.pop(context);
            },
          ),
        );
      },
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 50.sp,
            height: 50.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: R.colors.white,
              border: Border.all(width: 3.0, color: R.colors.primary),
            ),
            child: Container(
              width: 40.sp,
              height: 40.sp,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: R.colors.primary.withOpacity(.08)),
              child: profileImage == null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Icon(
                        Icons.add,
                        size: 25.sp,
                        color: R.colors.primary,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Image.file(
                        File(profileImage?.path ?? ""),
                        width: 40.sp,
                        height: 40.sp,
                      ),
                    ),
            ),
          ),
          w4,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile Picture',
                textAlign: TextAlign.center,
                style: R.textStyles.poppinsMedium(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: R.colors.black,
                  letterSpacing: 0.32,
                ),
              ),
              Text(
                'Click to upload image',
                style: R.textStyles.poppinsRegular(
                  fontSize: 10.sp,
                  color: R.colors.grey,
                  letterSpacing: -0.012,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // UserModel dummyUser = UserModel(
  //   role: UserRole.ADMIN,
  //   assistantName: 'John Doe',
  //   isVerified: true,
  //   experiencedCasesCount: 50,
  //   fullName: 'John Doe',
  //   experience: Experience(
  //     lawFirm: 'Law Firm XYZ',
  //     endDate: '2022-01-01',
  //     position: 'Senior Lawyer',
  //     startDate: '2020-01-01',
  //   ),
  //   isLawyerVerified: 'Verified',
  //   practiceAreas: ['Criminal Law', 'Family Law'],
  //   yearOfExperience: '5 years',
  //   qualifications: Qualifications(
  //     year: '2010',
  //     degree: 'LLB',
  //     institute: 'Law School ABC',
  //   ),
  //   createdAt: DateTime.now(),
  //   phoneNumber: PhoneNumberModel(
  //     number: '1234567890',
  //     isoCode: 'US',
  //     countryCode: '+1',
  //   ),
  //   specialist: ['Litigation', 'Contracts'],
  //   profileImages: ['image1.jpg', 'image2.jpg'],
  //   about:
  //       'I am an experienced lawyer with expertise in criminal and family law.',
  //   officeAdress: OfficeAdress(
  //     zipCode: '12345',
  //     country: 'USA',
  //     streetAdress: '123 Main St',
  //     city: 'Anytown',
  //     state: 'CA',
  //     latLng: '37.7749° N, 122.4194° W',
  //   ),
  //   feePerMeeting: 100.0,
  //   gender: GenderEnum.MALE,
  //   id: '123456789',
  //   email: 'john.doe@example.com',
  //   updatedAt: DateTime.now(),
  //   status: UserStatus.ACTIVE,
  //   casesCount: 10,
  // );
}
