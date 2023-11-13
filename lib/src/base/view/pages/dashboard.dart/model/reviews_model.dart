import 'package:flutter/material.dart';

class FeedBackModel {
  Icon? icon;
  String? name;
  String? feedBack;
  String? review;
  String? ratingBar;
  double? initRaating;

  FeedBackModel(
      {this.icon,
      this.name,
      this.feedBack,
      this.review,
      this.ratingBar,
      this.initRaating});
  toList() {}
}
