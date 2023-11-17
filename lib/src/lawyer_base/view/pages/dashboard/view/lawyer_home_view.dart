import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/resources/resources.dart';
import 'package:legal_links_app/src/base/view/pages/appointment/view/appointment_view.dart';
import 'package:legal_links_app/src/lawyer_base/view/pages/dashboard/view/schedule_appointment.dart';
import 'package:legal_links_app/src/lawyer_base/view/pages/dashboard/view/user_ratting_screen.dart';
import 'package:legal_links_app/utils/hights_widths.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

class LawyerHomeView extends StatefulWidget {
  static String route = '/lawyerHomeView';
  const LawyerHomeView({super.key});

  @override
  State<LawyerHomeView> createState() => _LawyerHomeViewState();
}

class _LawyerHomeViewState extends State<LawyerHomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            h2,
            Text(
              'Dev',
              style: R.textStyles.poppinsBold(fontSize: 15.sp),
            ),
            Text(
              'Elevate Your practice with Legal Links',
              style: R.textStyles.poppinsMedium(),
            ),
            h2,
            Container(
              margin: EdgeInsets.all(5.sp),
              padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: R.colors.white,
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      lawyerWidget(
                          Icons.book_online_rounded, 'In office appointment',
                          () {
                        Get.toNamed(AppointmentView.route);
                      }),
                      lawyerWidget(
                          Icons.schedule_send_sharp, 'schedule  appointment',
                          () {
                        Get.toNamed(ScheduleAppointmentView.route);
                      }),
                    ],
                  ),
                  h2,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      lawyerWidget(
                          Icons.restore_from_trash_outlined, 'Refer a lawyer',
                          () async {
                        debugPrint('click');
                        await Share.share(
                          'Check out this amazing lawyer on Legal Links!',
                          subject: 'Legal Links Lawyer Referral',
                        );
                      }),
                      lawyerWidget(Icons.reviews, 'My rating & reviews', () {
                        Get.toNamed(UserRattingView.route);
                      }),
                    ],
                  ),
                ],
              ),
            ),
            h1,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Whats New in the Lawyer industory?',
                  style: R.textStyles.poppinsMedium(),
                ),
              ],
            ),
            h1,
            Container(
              margin: EdgeInsets.all(5.sp),
              padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
              decoration: BoxDecoration(
                  color: R.colors.lightPrimeryTwo,
                  borderRadius: BorderRadius.circular(5.sp)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stay curious, stay Informed',
                    style: R.textStyles.poppinsSemiBold(),
                  ),
                  h1,
                  Text(
                    'Tap the banner to access the latest healthcare industory updates',
                    style: R.textStyles.poppinsRegular(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget lawyerWidget(var iconName, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60.sp,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
                backgroundColor: R.colors.grey,
                child: Icon(
                  iconName,
                  color: R.colors.primary,
                )),
            h1,
            Text(text)
          ],
        ),
      ),
    );
  }
}
