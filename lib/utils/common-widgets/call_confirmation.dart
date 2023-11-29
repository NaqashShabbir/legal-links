// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/src/base/view/pages/settings/vm/settings_vm.dart';
import 'package:legal_links_app/utils/hights_widths.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../resources/resources.dart';

class CallConfirmationDialog extends StatefulWidget {
  final String? PhoneNumberOne, PhoneNumberTwo;
  const CallConfirmationDialog(
      {super.key, this.PhoneNumberOne, this.PhoneNumberTwo});

  @override
  State<CallConfirmationDialog> createState() => _CallConfirmationDialogState();
}

class _CallConfirmationDialogState extends State<CallConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsVM>(builder: (context, vm, _) {
      return Scaffold(
        backgroundColor: R.colors.transparent,
        body: Center(
          child: Container(
            padding: EdgeInsets.all(8.sp),
            margin: EdgeInsets.symmetric(horizontal: 5.w),
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
                        color: R.colors.red.withOpacity(.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.clear,
                        size: 18,
                        color: R.colors.red,
                      ),
                    ),
                  ),
                ),
                h2,
                Icon(
                  Icons.headphones,
                  size: 30.sp,
                  color: R.colors.primary,
                ),
                h2P5,
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.sp),
                    width: double.infinity,
                    child: NumberField(() async {
                      final Uri url = Uri(
                        scheme: 'tel',
                        path: '${vm.contentModel.mobileNumber}',
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                      debugPrint("${vm.contentModel.mobileNumber}");
                    }, vm.contentModel.mobileNumber ?? '')),
                h1,
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.sp),
                    width: double.infinity,
                    child: NumberField(
                      () {},
                      vm.contentModel.telephoneNumber ?? "",
                    )),
                h3,
                Text(
                  'Available ${vm.contentModel.availbleTime} for your service',
                  style: R.textStyles.poppinsRegular(),
                ),
                h3,
              ],
            ),
          ),
        ),
      );
    });
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
            Icon(
              Icons.phone,
              color: R.colors.white,
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
