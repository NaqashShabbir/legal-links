import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  BookingModel({
    this.id,
    this.lawyerId,
    this.customerId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.lawyerScheduleId,
    this.selectedDate,
    this.timeSlot,
  });

  BookingModel.fromJson(dynamic json) {
    id = json['id'];
    lawyerId = json['lawyerId'];
    customerId = json['customerId'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    lawyerScheduleId = json['lawyerScheduleId'];
    selectedDate = json['selectedDate'];
    timeSlot = json['timeSlot'];
  }
  String? id;
  String? lawyerId;
  String? customerId;
  num? status;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  String? lawyerScheduleId;
  Timestamp? selectedDate;
  Timestamp? timeSlot;
  BookingModel copyWith({
    String? id,
    String? lawyerId,
    String? customerId,
    num? status,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    String? lawyerScheduleId,
    Timestamp? selectedDate,
    Timestamp? timeSlot,
  }) =>
      BookingModel(
        id: id ?? this.id,
        lawyerId: lawyerId ?? this.lawyerId,
        customerId: customerId ?? this.customerId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        lawyerScheduleId: lawyerScheduleId ?? this.lawyerScheduleId,
        selectedDate: selectedDate ?? this.selectedDate,
        timeSlot: timeSlot ?? this.timeSlot,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['lawyerId'] = lawyerId;
    map['customerId'] = customerId;
    map['status'] = status;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['lawyerScheduleId'] = lawyerScheduleId;
    map['selectedDate'] = selectedDate;
    map['timeSlot'] = timeSlot;

    return map;
  }
}
