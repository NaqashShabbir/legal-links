import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../resources/resources.dart';

class CustomData extends StatelessWidget {
  final String title;
  String? subTitle;
  CustomData({super.key, required this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            title,
            style: R.textStyles.poppinsMedium(
              fontSize: 12.sp,
              color: R.colors.black,
              letterSpacing: 0.45,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            subTitle!,
            style: R.textStyles.poppinsRegular(
              color: R.colors.darkGrey,
              letterSpacing: 0.45,
            ),
          ),
        ),
      ],
    );
  }
}
