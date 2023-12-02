import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:legal_links_app/constants/enums.dart';

class UserModel {
  UserModel({
    this.role,
    this.assistantName,
    this.isVerified,
    this.experiencedCasesCount,
    this.fullName,
    this.experience,
    this.isLawyerVerified,
    this.practiceAreas,
    this.yearOfExperience,
    this.qualifications,
    this.createdAt,
    this.phoneNumber,
    this.specialist,
    this.profileImages,
    this.docs,
    this.officeAdress,
    this.feePerMeeting,
    this.id,
    this.email,
    this.about,
    this.updatedAt,
    this.status,
    this.casesCount,
    this.gender,
    this.lcno,
    this.hcno,
  });

  UserModel.fromJson(dynamic json) {
    role = UserRole.values[json['role']];
    gender = json['gender'] != null
        ? GenderEnum.values[json['gender']]
        : GenderEnum.PREFERNOTTOSAY;
    assistantName = json['assistantName'];
    isVerified = json['isVerified'];
    experiencedCasesCount = json['experiencedCasesCount'];
    fullName = json['fullName'];

    // experience = json['experience'] != null ? Experience.fromJson(json['experience']) : null;
    if (json['experience'] != null) {
      experience = [];
      json['experience'].forEach((v) {
        experience?.add(Experience.fromJson(v));
      });
    }

    isLawyerVerified = json['isLawyerVerified'];
    // practiceAreas = json['practiceAreas'] != null ? json['practiceAreas'].cast<String>() : [];
    practiceAreas = json['practiceAreas'] is List
        ? List<String>.from(json['practiceAreas'])
        : [];

    yearOfExperience = json['yearOfExperience'];
    // qualifications =json['qualifications'] != null ? Qualifications.fromJson(json['qualifications']) : null;
    if (json['qualifications'] != null) {
      qualifications = [];
      json['qualifications'].forEach((v) {
        qualifications?.add(Qualifications.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    phoneNumber = json['phoneNumber'] != null
        ? PhoneNumberModel.fromJson(json['phoneNumber'])
        : null;
    // specialist = json['specialist'] != null ? json['specialist'].cast<String>() : [];
    // profileImages = json['profileImages'] != null ? List<String>.from(json['profileImages']) : [];
    specialist =
        json['specialist'] is List ? List<String>.from(json['specialist']) : [];
    profileImages = json['profileImages'] is List
        ? List<String>.from(json['profileImages'])
        : [];
    docs = json['docs'] is List ? List<String>.from(json['docs']) : [];

    officeAdress = json['officeAdress'] != null
        ? OfficeAdress.fromJson(json['officeAdress'])
        : null;
    feePerMeeting = json['feePerMeeting'];
    id = json['id'];
    email = json['email'];
    about = json['about'];
    updatedAt = json['updatedAt'];
    // status = json['status'].va;
    status = UserStatus.values[json['status']];
    casesCount = json['casesCount'];
    lcno = json['lcno'];
    hcno = json['hcno'];
  }
  UserRole? role;
  String? assistantName;
  String? lcno;
  String? hcno;
  bool? isVerified;
  num? experiencedCasesCount;
  String? fullName;
  List<Experience>? experience;
  bool? isLawyerVerified;
  List<String>? practiceAreas;
  String? yearOfExperience;
  List<Qualifications>? qualifications;
  Timestamp? createdAt;
  PhoneNumberModel? phoneNumber;
  List<String>? specialist;
  List<String>? profileImages;
  List<String>? docs;
  String? about;
  OfficeAdress? officeAdress;
  num? feePerMeeting;
  GenderEnum? gender;
  String? id;
  String? email;
  Timestamp? updatedAt;
  UserStatus? status;
  num? casesCount;

  UserModel copyWith({
    UserRole? role,
    String? assistantName,
    bool? isVerified,
    num? experiencedCasesCount,
    String? fullName,
    List<Experience>? experience,
    bool? isLawyerVerified,
    List<String>? practiceAreas,
    String? yearOfExperience,
    String? about,
    List<Qualifications>? qualifications,
    Timestamp? createdAt,
    PhoneNumberModel? phoneNumber,
    List<String>? specialist,
    List<String>? profileImages,
    List<String>? docs,
    OfficeAdress? officeAdress,
    num? feePerMeeting,
    GenderEnum? gender,
    String? id,
    String? email,
    String? lcno,
    String? hcno,
    Timestamp? updatedAt,
    UserStatus? status,
    num? casesCount,
  }) =>
      UserModel(
        role: role ?? this.role,
        gender: gender ?? this.gender,
        assistantName: assistantName ?? this.assistantName,
        isVerified: isVerified ?? this.isVerified,
        experiencedCasesCount:
            experiencedCasesCount ?? this.experiencedCasesCount,
        fullName: fullName ?? this.fullName,
        about: about ?? this.about,
        experience: experience ?? this.experience,
        isLawyerVerified: isLawyerVerified ?? this.isLawyerVerified,
        practiceAreas: practiceAreas ?? this.practiceAreas,
        yearOfExperience: yearOfExperience ?? this.yearOfExperience,
        qualifications: qualifications ?? this.qualifications,
        createdAt: createdAt ?? this.createdAt,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        specialist: specialist ?? this.specialist,
        profileImages: profileImages ?? this.profileImages,
        docs: docs ?? this.docs,
        officeAdress: officeAdress ?? this.officeAdress,
        feePerMeeting: feePerMeeting ?? this.feePerMeeting,
        id: id ?? this.id,
        email: email ?? this.email,
        updatedAt: updatedAt ?? this.updatedAt,
        status: status ?? this.status,
        casesCount: casesCount ?? this.casesCount,
        lcno: lcno ?? this.lcno,
        hcno: hcno ?? this.lcno,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['role'] = role?.index;
    map['gender'] = gender?.index;
    map['assistantName'] = assistantName;
    map['isVerified'] = isVerified;
    map['experiencedCasesCount'] = experiencedCasesCount;
    map['fullName'] = fullName;
    map['about'] = about;
    if (experience != null) {
      map['experience'] = experience?.map((v) => v.toJson()).toList();
    }
    map['isLawyerVerified'] = isLawyerVerified;
    map['practiceAreas'] = practiceAreas;
    map['yearOfExperience'] = yearOfExperience;
    if (qualifications != null) {
      map['qualifications'] = qualifications?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = createdAt;
    if (phoneNumber != null) {
      map['phoneNumber'] = phoneNumber?.toJson();
    }
    map['specialist'] = specialist;
    map['profileImages'] = profileImages;
    map['docs'] = docs;
    if (officeAdress != null) {
      map['officeAdress'] = officeAdress?.toJson();
    }
    map['feePerMeeting'] = feePerMeeting;
    map['id'] = id;
    map['email'] = email;
    map['updatedAt'] = updatedAt;
    map['status'] = status?.index;
    map['casesCount'] = casesCount;
    map['lcno'] = lcno;
    map['hcno'] = hcno;
    return map;
  }
}

class OfficeAdress {
  OfficeAdress({
    this.zipCode,
    this.country,
    this.streetAdress,
    this.city,
    this.state,
    this.latLng,
  });

  OfficeAdress.fromJson(dynamic json) {
    zipCode = json['zipCode'];
    country = json['country'];
    streetAdress = json['streetAdress'];
    city = json['city'];
    state = json['state'];
    latLng = json['latLng'];
  }
  String? zipCode;
  String? country;
  String? streetAdress;
  String? city;
  String? state;
  GeoPoint? latLng;
  OfficeAdress copyWith({
    String? zipCode,
    String? country,
    String? streetAdress,
    String? city,
    String? state,
    GeoPoint? latLng,
  }) =>
      OfficeAdress(
        zipCode: zipCode ?? this.zipCode,
        country: country ?? this.country,
        streetAdress: streetAdress ?? this.streetAdress,
        city: city ?? this.city,
        state: state ?? this.state,
        latLng: latLng ?? this.latLng,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['zipCode'] = zipCode;
    map['country'] = country;
    map['streetAdress'] = streetAdress;
    map['city'] = city;
    map['state'] = state;
    map['latLng'] = latLng;
    return map;
  }
}

class PhoneNumberModel {
  PhoneNumberModel({
    this.number,
    this.isoCode,
    this.countryCode,
  });

  PhoneNumberModel.fromJson(dynamic json) {
    number = json['number'];
    isoCode = json['isoCode'];
    countryCode = json['countryCode'];
  }
  String? number;
  String? isoCode;
  String? countryCode;
  PhoneNumberModel copyWith({
    String? number,
    String? isoCode,
    String? countryCode,
  }) =>
      PhoneNumberModel(
        number: number ?? this.number,
        isoCode: isoCode ?? this.isoCode,
        countryCode: countryCode ?? this.countryCode,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number'] = number;
    map['isoCode'] = isoCode;
    map['countryCode'] = countryCode;
    return map;
  }
}

class Qualifications {
  Qualifications({
    this.year,
    this.degree,
    this.institute,
  });

  Qualifications.fromJson(dynamic json) {
    year = json['year'];
    degree = json['degree'];
    institute = json['institute'];
  }
  bool? showDeleteIcon;
  String? year;
  String? degree;
  String? institute;
  Qualifications copyWith({
    String? year,
    String? degree,
    String? institute,
  }) =>
      Qualifications(
        year: year ?? this.year,
        degree: degree ?? this.degree,
        institute: institute ?? this.institute,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['year'] = year;
    map['degree'] = degree;
    map['institute'] = institute;
    return map;
  }
}

class Experience {
  Experience({
    this.lawFirm,
    this.endDate,
    this.position,
    this.startDate,
  });

  Experience.fromJson(dynamic json) {
    lawFirm = json['lawFirm'];
    endDate = json['endDate'];
    position = json['position'];
    startDate = json['startDate'];
  }
  String? lawFirm;
  String? endDate;
  String? position;
  String? startDate;
  Experience copyWith({
    String? lawFirm,
    String? endDate,
    String? position,
    String? startDate,
  }) =>
      Experience(
        lawFirm: lawFirm ?? this.lawFirm,
        endDate: endDate ?? this.endDate,
        position: position ?? this.position,
        startDate: startDate ?? this.startDate,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lawFirm'] = lawFirm;
    map['endDate'] = endDate;
    map['position'] = position;
    map['startDate'] = startDate;
    return map;
  }
}
