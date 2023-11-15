import 'package:day_picker/day_picker.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/src/lawyer_profile/view/signup_screen_four.dart';
import 'package:legal_links_app/src/lawyer_profile/view/widget/custom_button.dart';
import 'package:sizer/sizer.dart';
import '../../../resources/resources.dart';
import '../../../utils/common-widgets/custom_textformfield.dart';
import '../../../utils/hights_widths.dart';

class SignupScreenThreeOfLawyer extends StatefulWidget {
  static String route = '/signupscreenThree';
  const SignupScreenThreeOfLawyer({super.key});

  @override
  State<SignupScreenThreeOfLawyer> createState() =>
      _SignupScreenThreeOfLawyerState();
}

class _SignupScreenThreeOfLawyerState extends State<SignupScreenThreeOfLawyer> {
  TextEditingController feeController = TextEditingController();
  TextEditingController assistantController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  FocusNode feeFocus = FocusNode();
  FocusNode assistantFocus = FocusNode();
  FocusNode addressFocus = FocusNode();

  final List<DayInWeek> _days = [
    DayInWeek(
      "Sun",
      dayKey: '',
    ),
    DayInWeek(
      "Mon",
      dayKey: '',
    ),
    DayInWeek("Tue", isSelected: true, dayKey: ''),
    DayInWeek(
      "Wed",
      dayKey: '',
    ),
    DayInWeek(
      "Thu",
      dayKey: '',
    ),
    DayInWeek(
      "Fri",
      dayKey: '',
    ),
    DayInWeek(
      "Sat",
      dayKey: '',
    ),
  ];
  var duration;
  @override
  void initState() {
    super.initState();
    duration = const Duration(minutes: 30); // Initialize with a default value
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 12.sp),
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
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(SignupScreenFour.route);
                      },
                      child: Text(
                        'Skip',
                        style: R.textStyles.poppinsBold(
                            fontSize: 10.sp, color: R.colors.primary),
                      )),
                ],
              ),
              h3,
              Text(
                'Step 3/5 About you',
                style: R.textStyles
                    .poppinsSemiBold(color: R.colors.primary, fontSize: 15.sp),
              ),
              h1,
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
                controller: addressController,
                focusNode: addressFocus,
                inputAction: TextInputAction.done,
                inputType: TextInputType.text,
                hintText: 'Review Address',
                fieldTitle: "Your address",
                maxLines: 3,
              ),
              h1,
              Text(
                'Select Days',
                style: R.textStyles.poppinsMedium(
                  fontSize: 11.sp,
                  color: Colors.black,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectWeekDays(
                    backgroundColor: R.colors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    days: _days,
                    border: false,
                    boxDecoration: BoxDecoration(
                      color: R.colors.primary,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onSelect: (values) {
                      // <== Callback to handle the selected days
                    },
                  ),
                ),
              ),
              h1,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          {
                            var resultingDuration = await showDurationPicker(
                              context: context,
                              initialTime: Duration(minutes: 30),
                            );
                            duration = resultingDuration;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Chose duration: $resultingDuration')));
                          }
                        },
                        child: Text(
                          'Select time',
                          style: R.textStyles.poppinsMedium(
                            fontSize: 11.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      h1,
                      Text(duration != null ? '$duration' : 'Select time'),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      {
                        var resultingEndDuration = await showDurationPicker(
                          context: context,
                          initialTime: Duration(minutes: 30),
                        );
                        duration = resultingEndDuration;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Chose duration: $resultingEndDuration')));
                      }
                    },
                    child: Column(
                      children: [
                        Text(
                          'End time',
                          style: R.textStyles.poppinsMedium(
                            fontSize: 11.sp,
                            color: Colors.black,
                          ),
                        ),
                        h1,
                        const Text(''),
                      ],
                    ),
                  ),
                ],
              ),
              h3,
              CustomButtonSignup(
                text: "Continue to next step",
                tap: () async {
                  Get.toNamed(SignupScreenFour.route);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
