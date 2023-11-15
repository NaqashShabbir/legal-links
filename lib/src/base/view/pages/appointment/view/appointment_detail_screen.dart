import 'package:flutter/material.dart';
import 'package:legal_links_app/src/base/view/pages/appointment/model/appointment_details_model.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../resources/resources.dart';

class AppointmentDetails extends StatefulWidget {
  static String route = '/appointmentdetails';
  const AppointmentDetails({super.key});

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  dynamic args;
  AppointmentModel? model;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        if (args[model != null]) {
          model = args['model'];
        }
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        padding: EdgeInsets.all(10.sp),
        margin: EdgeInsets.all(10.sp),
        height: 40.h,
        decoration: BoxDecoration(
          //  border: Border.all(color: R.colors.grey),
          borderRadius: BorderRadius.circular(10.sp),
          boxShadow: [
            BoxShadow(
              color: R.colors.grey.withOpacity(.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            'Your Appointment ID',
            style: R.textStyles.poppinsSemiBold(),
          ),
          Text(
            "${model?.id.toString()}",
            style: R.textStyles.poppinsMedium(color: R.colors.primary),
          ),
        ]),
      )),
    );
  }
}
