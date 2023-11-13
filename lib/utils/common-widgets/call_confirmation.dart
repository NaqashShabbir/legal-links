import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/utils/hights_widths.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../resources/resources.dart';

class CallConfirmationDialog extends StatefulWidget {
  const CallConfirmationDialog({super.key});

  @override
  State<CallConfirmationDialog> createState() => _CallConfirmationDialogState();
}

class _CallConfirmationDialogState extends State<CallConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.transparent,
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 7.w),
          decoration: BoxDecoration(
            color: R.colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.20),
                offset: const Offset(-5, -2),
                blurRadius: 12,
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.20),
                offset: const Offset(3, 3),
                blurRadius: 12,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: R.colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.clear,
                      size: 18,
                      color: R.colors.black,
                    ),
                  ),
                ),
              ),
              h2,
              Icon(
                Icons.headphones,
                size: 30.sp,
                color: Colors.green,
              ),
              h2,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.sp),
                width: double.infinity,
                child: NumberField(() {}, '0345-5533872'),
              ),
              h1,
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.sp),
                  width: double.infinity,
                  child: NumberField(() {}, '0345-5533872')),
              h2,
              Text(
                'Available 12/7 for your service',
                style: R.textStyles.poppinsRegular(),
              ),
              h2,
            ],
          ),
        ),
      ),
    );
  }

  Widget NumberField(VoidCallback onTap, String text) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: R.colors.primary),
        backgroundColor: R.colors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.sp, horizontal: 2.sp),
        child: Row(
          children: [
            Container(
              child: Icon(
                Icons.phone,
                color: R.colors.white,
              ),
            ),
            w2,
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: R.textStyles
                    .poppinsMedium()
                    .copyWith(color: R.colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
