import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:legal_links_app/services/google_map/address_model.dart';
import 'package:legal_links_app/services/google_map/google_map_screen.dart';
import 'package:legal_links_app/src/auth/model/user_model.dart';
import 'package:legal_links_app/src/auth/view/lawyer_singup/complete_profile.dart';
import 'package:legal_links_app/src/auth/view/lawyer_singup/steper_widget.dart';
import 'package:legal_links_app/src/auth/vm/auth_vm.dart';
import 'package:legal_links_app/utils/common-widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../resources/resources.dart';
import '../../../../utils/common-widgets/custom_textformfield.dart';
import '../../../../utils/hights_widths.dart';

class SignupScreenThreeOfLawyer extends StatefulWidget {
  static String route = '/signupscreenThree';
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
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.arrow_back)),
                      Text(
                        'Create your profile',
                        style: R.textStyles.poppinsSemiBold(),
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Get.toNamed(CompleteProfile.route);
                          },
                          child: Text(
                            'Skip',
                            style:
                                R.textStyles.poppinsBold(fontSize: 10.sp, color: R.colors.primary),
                          )),
                    ],
                  ),
                  h3,
                  SteperWidget(currentStep: 3),
                  h2,
                  CustomTextFormField(
                    controller: feeController,
                    focusNode: feeFocus,
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    hintText: 'fee',
                    fieldTitle: "Your Fee ",
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
                    inputType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    hintText: '10',
                    fieldTitle: "Case Count",
                  ),
                  CustomTextFormField(
                    controller: addressController,
                    focusNode: addressFocus,
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.text,
                    hintText: 'Review Address',
                    fieldTitle: "Your address",
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
                  ),
                  h1,
                  CustomTextFormField(
                    controller: aboutController,
                    focusNode: addressFocus,
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.text,
                    hintText: 'About Yourself',
                    fieldTitle: "About Yourself",
                    maxLines: 3,
                  ),
                  h3,
                  CustomButton(
                    buttonTitle: "Continue to next step",
                    tap: () async {
                      await butonFn(vm);
                      Get.toNamed(CompleteProfile.route);
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
      context.read<AuthVM>().update();
      bool check = await context.read<AuthVM>().signUp(vm.tempLawyerModel, pass: vm.password);
      if (check) {
        vm.tempLawyerModel = UserModel();
        vm.password = '';
        Get.toNamed(SignupScreenThreeOfLawyer.route);
      }
    }
  }
}

  // Future<void> buttonFn() async {
  //   UserModel createClient = UserModel(
  //     feePerMeeting: int.tryParse(feeController.text),
  //     assistantName: assistantController.text.toString(),
  //     casesCount: int.tryParse(caseCountController.text),
  //     officeAdress: OfficeAdress(),
  //     about: aboutController.text.toString(),
  //   );

  //   await context.read<AuthVM>().signUp(createClient, pass: '');

    // debugPrint(" body: ");
    // debugPrint('role: ${context.read<AuthVM>().userRole}');
    // debugPrint('fullName: ${nameController.text.trim()}');
    // debugPrint('createdAt: $now');
    // debugPrint('updatedAt: $now');
    // Uncomment the line below if `id` is a property
    // debugPrint('id: $id');
    // debugPrint('phoneNumberController: ${phoneNumberController.text.trim()}');
    // debugPrint('number.isoCode: ${number.isoCode}');
    // debugPrint('number.dialCode: ${number.dialCode}');
    // debugPrint('email: ${emailController.text.trim()}');
    // debugPrint('status: ${UserStatus.ACTIVE}');
  // }
// }
