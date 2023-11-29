import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentMethod {
  final Timestamp createdAt;
  final String image;
  final String iban;
  final String name;
  final String branchName;
  final String id;
  final String userName;
  final String accountNumber;
  final int status;
  final Timestamp updatedAt;

  PaymentMethod({
    required this.createdAt,
    required this.image,
    required this.iban,
    required this.name,
    required this.branchName,
    required this.id,
    required this.userName,
    required this.accountNumber,
    required this.status,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'image': image,
      'iban': iban,
      'name': name,
      'branchName': branchName,
      'id': id,
      'userName': userName,
      'accountNumber': accountNumber,
      'status': status,
      'updatedAt': updatedAt,
    };
  }
}
