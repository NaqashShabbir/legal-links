import 'package:flutter/material.dart';
import 'package:legal_links_app/utils/common-widgets/global_widget.dart';

class AllLawyersScreen extends StatefulWidget {
  static String route = '/alllawyers';
  const AllLawyersScreen({super.key});

  @override
  State<AllLawyersScreen> createState() => _AllLawyersScreenState();
}

class _AllLawyersScreenState extends State<AllLawyersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.ScreenAppBar('All Lawyers'),
    );
  }
}
