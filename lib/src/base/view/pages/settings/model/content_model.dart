import 'package:cloud_firestore/cloud_firestore.dart';

class ContentModel {
  ContentModel(
      {this.termsOfUse,
      this.verificationPolicy,
      this.privacyPolicy,
      this.appName,
      this.mobileNumber,
      this.telephoneNumber,
      this.availbleTime,
      
      this.paymentMethod});

  ContentModel.fromJson(dynamic json) {
    termsOfUse = json['termsOfUse'];
    verificationPolicy = json['verificationPolicy'];
    privacyPolicy = json['privacyPolicy'];
    appName = json['appName'];
    mobileNumber = json['mobileNumber'];
    telephoneNumber = json['telephoneNumber'];
    availbleTime = json['availableTime'];

    if (json['paymentMethods'] != null) {
      paymentMethod = [];
      json['paymentMethods'].forEach((v) {
        paymentMethod?.add(PaymentMethod.fromJson(v));
      });
    }
  }
  String? termsOfUse;
  String? verificationPolicy;
  String? privacyPolicy;
  String? appName;
  String? mobileNumber;
  String? telephoneNumber;
  String? availbleTime;
  List<PaymentMethod>? paymentMethod;
  ContentModel copyWith({
    String? termsOfUse,
    String? verificationPolicy,
    String? privacyPolicy,
    String? appName,
    String? mobileNumber,
    String? telephoneNumber,
    String? availbleTime,
    List<PaymentMethod>? paymentMethod,
  }) =>
      ContentModel(
          termsOfUse: termsOfUse ?? this.termsOfUse,
          verificationPolicy: verificationPolicy ?? this.verificationPolicy,
          privacyPolicy: privacyPolicy ?? this.privacyPolicy,
          appName: appName ?? this.appName,
          mobileNumber: mobileNumber ?? this.mobileNumber,
          paymentMethod: paymentMethod ?? this.paymentMethod);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['termsOfUse'] = termsOfUse;
    map['verificationPolicy'] = verificationPolicy;
    map['privacyPolicy'] = privacyPolicy;
    map['appName'] = appName;
    map['mobileNumber'] = mobileNumber;
    map['telephoneNumber'] = telephoneNumber;
    map['availableTime'] = availbleTime;
    map['paymentMethods'] = paymentMethod;
    return map;
  }
}

class PaymentMethod {
  Timestamp? createdAt;
  String? image;
  String? iban;
  
  String? branchName;
  String? id;
  String? userName;
  String? accountNumber;
  String? providerName;
  int? status;
  Timestamp? updatedAt;

  PaymentMethod({
    this.createdAt,
    this.image,
    this.iban,
    
    this.branchName,
    this.id,
    this.userName,
    this.accountNumber,
    this.providerName,
    this.status,
    this.updatedAt,
  });

  PaymentMethod.fromJson(dynamic map) {
    createdAt = map['createdAt'];
    image = map['image'];
    iban = map['iban'];
    
    branchName = map['branchName'];
    id = map['id'];
    userName = map['userName'];
    accountNumber = map['accountNumber'];
    providerName = map['providerName'];
    status = map['status'];
    updatedAt = map['updatedAt'];
  }
  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'image': image,
      'iban': iban,
      
      'branchName': branchName,
      'id': id,
      'userName': userName,
      'accountNumber': accountNumber,
      'status': status,
      'updatedAt': updatedAt,
    };
  }
}
