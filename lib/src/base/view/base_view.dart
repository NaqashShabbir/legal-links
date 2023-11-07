import 'package:flutter/material.dart';

class BaseView extends StatefulWidget {
  static String route = '/BaseView';
  const BaseView({super.key});

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Welcome"),
      ),
    );
  }
}
