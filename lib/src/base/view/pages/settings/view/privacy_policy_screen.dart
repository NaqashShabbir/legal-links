import 'package:flutter/material.dart';
import 'package:legal_links_app/src/base/view/pages/settings/vm/settings_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../resources/resources.dart';
import '../../../../../../utils/common-widgets/global_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static String route = "/PrivacyPolicyScreen";
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.appBar('Privacy Policy'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.read<SettingsVM>().contentModel.privacyPolicy ?? "",
              style: R.textStyles.poppinsRegular(
                color: R.colors.grey,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    
    );
  }
}
