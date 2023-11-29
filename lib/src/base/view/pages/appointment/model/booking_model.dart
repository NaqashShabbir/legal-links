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
    this.lawyerName,
    this.lawyerImage,
    this.customerImage,
    this.customerName,
    this.officeLocation,
    this.feePerMeeting,
  });

  BookingModel.fromJson(dynamic json) {
    id = json['id'];
    lawyerId = json['lawyerId'];
    lawyerImage = json['lawyerImage'];
    customerImage = json['customerImage'];
    customerId = json['customerId'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    lawyerScheduleId = json['lawyerScheduleId'];
    selectedDate = json['selectedDate'];
    timeSlot = json['timeSlot'];
    lawyerName = json['lawyerName'];
    customerName = json['customerName'];
    officeLocation = json['officeLocation'];
    feePerMeeting = json['feePerMeeting'];
  }
  String? id;
  String? lawyerId;
  String? customerId;
  String? lawyerImage;
  String? customerImage;
  int? status;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  String? lawyerScheduleId;
  String? lawyerName;
  String? customerName;
  double? feePerMeeting;
  String? officeLocation;
  Timestamp? selectedDate;
  Timestamp? timeSlot;
  BookingModel copyWith({
    String? id,
    String? lawyerId,
    String? customerId,
    int? status,
    Timestamp? createdAt,
    String? lawyerImage,
    String? customerImage,
    Timestamp? updatedAt,
    String? lawyerScheduleId,
    String? lawyerName,
    String? customerName,
    double? feePerMeeting,
    String? officeLocation,
    Timestamp? selectedDate,
    Timestamp? timeSlot,
  }) =>
      BookingModel(
        id: id ?? this.id,
        lawyerId: lawyerId ?? this.lawyerId,
        lawyerImage: lawyerImage ?? this.lawyerImage,
        customerImage: customerImage ?? this.customerImage,
        customerId: customerId ?? this.customerId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        lawyerName: lawyerName ?? this.lawyerName,
        updatedAt: updatedAt ?? this.updatedAt,
        lawyerScheduleId: lawyerScheduleId ?? this.lawyerScheduleId,
        selectedDate: selectedDate ?? this.selectedDate,
        timeSlot: timeSlot ?? this.timeSlot,
        customerName: customerName ?? this.customerName,
        officeLocation: officeLocation ?? this.officeLocation,
        feePerMeeting: feePerMeeting ?? this.feePerMeeting,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['lawyerId'] = lawyerId;
    map['lawyerImage'] = lawyerImage;
    map['customerImage'] = customerImage;
    map['customerId'] = customerId;
    map['status'] = status;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['lawyerScheduleId'] = lawyerScheduleId;
    map['selectedDate'] = selectedDate;
    map['lawyerName'] = lawyerName;
    map['timeSlot'] = timeSlot;
    map['customerName'] = customerName;
    map['officeLocation'] = officeLocation;
    map['feePerMeeting'] = feePerMeeting;

    return map;
  }
}
