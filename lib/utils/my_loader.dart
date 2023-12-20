import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:legal_links_app/resources/resources.dart';

class MyLoader extends StatefulWidget {
  final Color color;

  const MyLoader({Key? key, this.color = Colors.red}) : super(key: key);

  @override
  MyLoaderState createState() => MyLoaderState();
}

class MyLoaderState extends State<MyLoader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: R.colors.primary.withOpacity(.05),
      child: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: CircularProgressIndicator(backgroundColor: R.colors.primary),
        ),
      ),
    );
  }
}
