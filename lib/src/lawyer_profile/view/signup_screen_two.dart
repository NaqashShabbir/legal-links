import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<SignupLawyer>(builder: (context, vm, _) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 12.sp),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              h3,
              Text('Step 1/5 About you'),
              h1,
              speciallistLawyerDropdown(vm: vm),
              h1,
              CustomTextFormField(
                controller: lawyerController,
                hintText: 'Any other Speciality',
                focusNode: lawyerFocus,
                inputAction: TextInputAction.next,
                inputType: TextInputType.name,
                validator: FieldValidator.validateEmpty,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              h1,
            ]),
          ),
        );
      }),
    );
  }

  LawyerModel? laywersSpe;

  Widget speciallistLawyerDropdown({required SignupLawyer vm}) {
    return DropdownButtonFormField<LawyerModel?>(
      borderRadius: BorderRadius.circular(8),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: vm.castList
          .map((item) => DropdownMenuItem<LawyerModel?>(
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
    return DropdownButtonFormField<LawyerModel?>(
      borderRadius: BorderRadius.circular(8),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: vm.castList
          .map((item) => DropdownMenuItem<LawyerModel?>(
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
}
