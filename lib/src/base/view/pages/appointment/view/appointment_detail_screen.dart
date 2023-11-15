import 'package:flutter/material.dart';
import 'package:legal_links_app/src/base/view/pages/appointment/model/appointment_details_model.dart';

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
    return Scaffold(
        body: Column(children: [
      Text(
        'Your Appointment ID',
        style: R.textStyles.poppinsSemiBold(),
      ),
      Text(
        "${model?.id.toString()}",
        style: R.textStyles.poppinsMedium(color: R.colors.primary),
      ),
    ]));
  }
}
