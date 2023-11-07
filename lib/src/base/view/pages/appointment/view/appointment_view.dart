import 'package:flutter/material.dart';
import 'package:legal_links_app/resources/resources.dart';

class AppointmentView extends StatefulWidget {
  const AppointmentView({super.key});

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.secondary,
    );
  }
}
