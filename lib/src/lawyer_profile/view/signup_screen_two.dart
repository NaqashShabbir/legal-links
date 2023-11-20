import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/src/lawyer_profile/view/signup_screen_three.dart';
import 'package:legal_links_app/src/lawyer_profile/view/widget/custom_button.dart';
import 'package:legal_links_app/src/lawyer_profile/view/widget/steper_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../resources/resources.dart';
import '../../../resources/validator.dart';
import '../../../utils/common-widgets/custom_textformfield.dart';
import '../../../utils/hights_widths.dart';
import '../model/lawyer_model.dart';
import '../vm/signup_lawyer.dart';

class SignupScreenTwoOfLawyer extends StatefulWidget {
  static String route = '/signupTwoaslawyer';

  const SignupScreenTwoOfLawyer({super.key});

  @override
  State<SignupScreenTwoOfLawyer> createState() =>
      _SignupScreenTwoOfLawyerState();
}

class _SignupScreenTwoOfLawyerState extends State<SignupScreenTwoOfLawyer> {
  FocusNode lawyerFocus = FocusNode();
  TextEditingController lawyerController = TextEditingController();

  List<RowItem> rowsList = [
    RowItem(
      degree: 'Degree',
      uni: 'Institute/University',
      showDeleteIcon: false,
    ),
    RowItem(
      degree: 'Degree',
      uni: 'Institute/University',
      showDeleteIcon: true,
    ),
  ];

  List<ExperienceItem> experienceList = [
    ExperienceItem(
      designation: 'Designation',
      court: 'Court/Chamber',
      showDeleteIcon: false,
    ),
    ExperienceItem(
      designation: 'Designation',
      court: 'Court/Chamber',
      showDeleteIcon: true,
    ),
  ];

  List<PracticeAreaItems> practiceList = [
    PracticeAreaItems(
      practiceArea: 'Designation',
      showDeleteIcon: false,
    ),
    PracticeAreaItems(
      practiceArea: 'Designation',
      showDeleteIcon: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<SignupLawyer>(builder: (context, vm, _) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 12.sp),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                ],
              ),
              h3,
              SteperWidget(
                currentStep: 2,
              ),
              h2,
              speciallistLawyerDropdown(vm: vm),
              h1,
              CustomTextFormField(
                controller: lawyerController,
                hintText: 'Any other Speciality',
                //focusNode: lawyerFocus,
                inputAction: TextInputAction.next,
                inputType: TextInputType.name,
                validator: FieldValidator.validateEmpty,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              h1,
              heading('Your Qualification', () {
                setState(() {
                  rowsList.add(RowItem(
                      degree: 'Degree',
                      uni: 'Institute/University',
                      showDeleteIcon: true));
                });
              }),
              h1,
              for (int index = 0; index < rowsList.length; index++) ...[
                customTextFieldRow(rowsList[index], index),
                h0P8,
              ],
              h1,
              heading('Your Experience', () {
                setState(() {
                  experienceList.add(
                    ExperienceItem(
                      designation: 'Designation',
                      court: 'Court/Chamber',
                      showDeleteIcon: true,
                    ),
                  );
                });
              }),
              h1,
              h1,
              for (int index = 0; index < experienceList.length; index++) ...[
                customTextFieldExperience(experienceList[index], index),
                h0P8,
              ],
              h1,
              heading('Practice Area', () {
                setState(() {
                  practiceList.add(
                    PracticeAreaItems(
                      practiceArea: 'Designation',
                      showDeleteIcon: true,
                    ),
                  );
                });
              }),
              h1,
              for (int index = 0; index < practiceList.length; index++) ...[
                practiceField(practiceList[index], index),
                h0P8,
              ],
              h1,
              h3,
              CustomButtonSignup(
                text: 'Continue to next step',
                tap: () {
                  Get.toNamed(SignupScreenThreeOfLawyer.route);
                },
              )
            ]),
          ),
        );
      }),
    );
  }

  LawyerModelSignup? laywersSpe;

  Widget speciallistLawyerDropdown({required SignupLawyer vm}) {
    return DropdownButtonFormField<LawyerModelSignup?>(
      borderRadius: BorderRadius.circular(8),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: vm.castList
          .map((item) => DropdownMenuItem<LawyerModelSignup?>(
                value: item,
                child: Text(
                  item.specialist ?? "",
                  style: R.textStyles
                      .poppinsRegular(color: R.colors.black, fontSize: 8.sp),
                ),
              ))
          .toList(),
      decoration: R.decoration.fieldDecoration(hintText: "Select Specialist"),
      value: laywersSpe,
      validator: (value) {
        if (value == null) {
          return "required";
        }
        return null;
      },
      onChanged: (value) {
        laywersSpe = value;
      },
    );
  }

  Widget categoryLawyerDropdown({required SignupLawyer vm}) {
    return DropdownButtonFormField<LawyerModelSignup?>(
      borderRadius: BorderRadius.circular(8),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: vm.castList
          .map((item) => DropdownMenuItem<LawyerModelSignup?>(
                value: item,
                child: Text(
                  item.specialist ?? "",
                  style: R.textStyles
                      .poppinsRegular(color: R.colors.black, fontSize: 8.sp),
                ),
              ))
          .toList(),
      decoration: R.decoration.fieldDecoration(hintText: "Select Specialist"),
      value: laywersSpe,
      validator: (value) {
        if (value == null) {
          return "required";
        }
        return null;
      },
      onChanged: (value) {
        laywersSpe = value;
      },
    );
  }

  Widget heading(String text, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: R.textStyles.poppinsSemiBold(),
        ),
        TextButton(
            onPressed: onTap,
            child: Text(
              'ADD MORE',
              style: R.textStyles
                  .poppinsSemiBold(color: R.colors.primary, fontSize: 10.sp),
            )),
      ],
    );
  }

  Widget customTextFieldRow(RowItem item, int index) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: CustomTextFormField(
            hintText: item.degree,
            //focusNode: lawyerFocus,
            inputAction: TextInputAction.next,
            inputType: TextInputType.name,
            validator: FieldValidator.validateEmpty,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
        w2,
        Expanded(
          flex: 3,
          child: CustomTextFormField(
            hintText: item.uni,
            inputAction: TextInputAction.next,
            inputType: TextInputType.name,
            validator: FieldValidator.validateEmpty,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
        if (item.showDeleteIcon)
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {
                setState(() {
                  rowsList.removeAt(index);
                });
              },
              icon: Icon(
                Icons.delete,
                color: R.colors.primary,
                size: 25.sp,
              ),
            ),
          ),
        if (!item.showDeleteIcon)
          Expanded(
            flex: 1,
            child: Container(),
          ),
      ],
    );
  }

  Widget customTextFieldExperience(ExperienceItem item, int index) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: CustomTextFormField(
            hintText: item.designation,
            //focusNode: lawyerFocus,
            inputAction: TextInputAction.next,
            inputType: TextInputType.name,
            validator: FieldValidator.validateEmpty,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
        w2,
        Expanded(
          flex: 3,
          child: CustomTextFormField(
            hintText: item.court,
            // focusNode: lawyerFocus,
            inputAction: TextInputAction.next,
            inputType: TextInputType.name,
            validator: FieldValidator.validateEmpty,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
        if (item.showDeleteIcon)
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {
                setState(() {
                  experienceList.removeAt(index);
                });
              },
              icon: Icon(
                Icons.delete,
                color: R.colors.primary,
                size: 25.sp,
              ),
            ),
          ),
        if (!item.showDeleteIcon)
          Expanded(
            flex: 1,
            child: Container(),
          ),
      ],
    );
  }
}

Widget practiceField(PracticeAreaItems item, int index) {
  return Row(
    children: [
      Expanded(
        flex: 3,
        child: CustomTextFormField(
          hintText: item.practiceArea,
          //focusNode: lawyerFocus,
          inputAction: TextInputAction.next,
          inputType: TextInputType.name,
          validator: FieldValidator.validateEmpty,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
      if (item.showDeleteIcon)
        Expanded(
          flex: 1,
          child: IconButton(
            onPressed: () {
              // setState(() {
              //   practiceList.removeAt(index);
              // });
            },
            icon: Icon(
              Icons.delete,
              color: R.colors.primary,
              size: 25.sp,
            ),
          ),
        ),
      if (!item.showDeleteIcon)
        Expanded(
          flex: 1,
          child: Container(),
        ),
    ],
  );
}

class RowItem {
  final String degree;
  final String uni;
  final bool showDeleteIcon;

  RowItem({
    required this.degree,
    required this.uni,
    this.showDeleteIcon = true,
  });
}

class ExperienceItem {
  final String designation;
  final String court;
  final bool showDeleteIcon;

  ExperienceItem({
    required this.designation,
    required this.court,
    this.showDeleteIcon = true,
  });
}

class PracticeAreaItems {
  final String practiceArea;

  final bool showDeleteIcon;

  PracticeAreaItems({
    required this.practiceArea,
    this.showDeleteIcon = true,
  });
}
