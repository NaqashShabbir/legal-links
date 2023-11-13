import 'package:flutter/material.dart';
import 'package:legal_links_app/resources/resources.dart';
import 'package:sizer/sizer.dart';

class AppButton extends StatefulWidget {
  final String buttonTitle;
  final GestureTapCallback onTap;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? textSize;
  final double? borderRadius;
  final double? verticlePadding;
  final double? horiPadding;
  final double? letterSpacing;
  final FontWeight? fontWeight;
  final AlignmentGeometry? alignmentGeometryBegin;
  final AlignmentGeometry? alignmentGeometryEnd;

  const AppButton({
    Key? key,
    required this.buttonTitle,
    required this.onTap,
    this.borderRadius,
    this.color,
    this.borderColor,
    this.textColor,
    this.textSize,
    this.verticlePadding,
    this.horiPadding,
    this.letterSpacing,
    this.fontWeight,
    this.alignmentGeometryBegin,
    this.alignmentGeometryEnd,
  }) : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onTap,
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: widget.borderColor ?? R.colors.primary),
        backgroundColor: widget.color ?? R.colors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 28),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: widget.verticlePadding ?? 2.sp,
            horizontal: widget.horiPadding ?? 2.sp),
        child: Text(
          widget.buttonTitle,
          textAlign: TextAlign.center,
          style: R.textStyles.poppinsMedium().copyWith(
                color: widget.textColor ?? R.colors.white,
              ),
        ),
      ),
    );
  }
}
