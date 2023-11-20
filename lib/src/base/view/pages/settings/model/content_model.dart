class ContentModel {
  ContentModel({
    this.termsOfUse,
    this.verificationPolicy,
    this.privacyPolicy,
    this.appName,
  });

  ContentModel.fromJson(dynamic json) {
    termsOfUse = json['termsOfUse'];
    verificationPolicy = json['verificationPolicy'];
    privacyPolicy = json['privacyPolicy'];
    appName = json['appName'];
  }
  String? termsOfUse;
  String? verificationPolicy;
  String? privacyPolicy;
  String? appName;
  ContentModel copyWith({
    String? termsOfUse,
    String? verificationPolicy,
    String? privacyPolicy,
    String? appName,
  }) =>
      ContentModel(
        termsOfUse: termsOfUse ?? this.termsOfUse,
        verificationPolicy: verificationPolicy ?? this.verificationPolicy,
        privacyPolicy: privacyPolicy ?? this.privacyPolicy,
        appName: appName ?? this.appName,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['termsOfUse'] = termsOfUse;
    map['verificationPolicy'] = verificationPolicy;
    map['privacyPolicy'] = privacyPolicy;
    map['appName'] = appName;
    return map;
  }
}
