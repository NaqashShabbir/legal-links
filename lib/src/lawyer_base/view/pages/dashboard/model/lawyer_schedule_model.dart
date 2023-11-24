import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LawyerScheduleModel {
  LawyerScheduleModel({
    this.availableDates,
    this.officeEndTime,
    this.officeStartTime,
    this.intervalMinutes,
    this.lawyerId,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  LawyerScheduleModel.fromJson(dynamic json) {
    availableDates = json['availableDates'] != null ? json['availableDates'].cast<String>() : [];
    officeEndTime = json['officeEndTime'];
    officeStartTime = json['officeStartTime'];
    intervalMinutes = json['intervalMinutes'];
    lawyerId = json['lawyerId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    status = json['status'];
  }
  List<Timestamp>? availableDates;
  Timestamp? officeEndTime;
  Timestamp? officeStartTime;
  int? intervalMinutes;
  String? lawyerId;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  int? status;
  LawyerScheduleModel copyWith({
    List<Timestamp>? availableDates,
    Timestamp? officeEndTime,
    Timestamp? officeStartTime,
    int? intervalMinutes,
    String? lawyerId,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    int? status,
  }) =>
      LawyerScheduleModel(
        availableDates: availableDates ?? this.availableDates,
        officeEndTime: officeEndTime ?? this.officeEndTime,
        officeStartTime: officeStartTime ?? this.officeStartTime,
        intervalMinutes: intervalMinutes ?? this.intervalMinutes,
        lawyerId: lawyerId ?? this.lawyerId,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        status: status ?? this.status,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['availableDates'] = availableDates;
    map['officeEndTime'] = officeEndTime;
    map['officeStartTime'] = officeStartTime;
    map['intervalMinutes'] = intervalMinutes;
    map['lawyerId'] = lawyerId;
    map['updatedAt'] = updatedAt;
    map['createdAt'] = createdAt;
    map['status'] = status;
    return map;
  }
}
