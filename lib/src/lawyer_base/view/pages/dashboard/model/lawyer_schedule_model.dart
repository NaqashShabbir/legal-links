import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LawyerScheduleModel {
  LawyerScheduleModel({
    this.availableDates,
    this.officeEndTime,
    this.officeStartTime,
    this.intervalMinutes,
    this.lawyerId,
  });

  LawyerScheduleModel.fromJson(dynamic json) {
    availableDates = json['availableDates'] != null ? json['availableDates'].cast<String>() : [];
    officeEndTime = json['officeEndTime'];
    officeStartTime = json['officeStartTime'];
    intervalMinutes = json['intervalMinutes'];
    lawyerId = json['lawyerId'];
  }
  List<Timestamp>? availableDates;
  Timestamp? officeEndTime;
  Timestamp? officeStartTime;
  int? intervalMinutes;
  String? lawyerId;
  LawyerScheduleModel copyWith({
    List<Timestamp>? availableDates,
    Timestamp? officeEndTime,
    Timestamp? officeStartTime,
    int? intervalMinutes,
    String? lawyerId,
  }) =>
      LawyerScheduleModel(
        availableDates: availableDates ?? this.availableDates,
        officeEndTime: officeEndTime ?? this.officeEndTime,
        officeStartTime: officeStartTime ?? this.officeStartTime,
        intervalMinutes: intervalMinutes ?? this.intervalMinutes,
        lawyerId: lawyerId ?? this.lawyerId,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['availableDates'] = availableDates;
    map['officeEndTime'] = officeEndTime;
    map['officeStartTime'] = officeStartTime;
    map['intervalMinutes'] = intervalMinutes;
    map['lawyerId'] = lawyerId;
    return map;
  }
}
