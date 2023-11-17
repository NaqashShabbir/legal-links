import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../resources/resources.dart';

class CustomButtonSignup extends StatelessWidget {
  final VoidCallback tap;
  final String text;
  CustomButtonSignup({super.key, required this.tap, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3.sp),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10.sp,
            ),
            border: Border.all(color: R.colors.primary, width: 2.sp)),
        child: Center(
          child: Text(
            text,
            style: R.textStyles.poppinsSemiBold(color: R.colors.primary),
          ),
        ),
      ),
    );
  }
}
