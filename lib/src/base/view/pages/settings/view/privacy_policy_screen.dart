import 'package:flutter/material.dart';

import '../../../../../../resources/resources.dart';
import '../../../../../../utils/common-widgets/global_widget.dart';
import '../../../../../../utils/hights_widths.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static String route = "/PrivacyPolicyScreen";
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.appBar('Privasy Policy'),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textAlign: TextAlign.start,
              'Lorem Ipsam',
              style: R.textStyles.poppinsRegular(),
            ),
            h2,
            const Text(
                textAlign: TextAlign.start,
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
            h3,
            Text(
              textAlign: TextAlign.start,
              'Lorem Ipsam',
              style: R.textStyles.poppinsRegular(),
            ),
            h2,
            const Text(
                textAlign: TextAlign.start,
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
          ],
        ),
      ),
    );
  }
}
