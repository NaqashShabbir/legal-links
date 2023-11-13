class LawyersModel {
  String? id;
  String? username;
  String? lawyerType;
  String? gender;
  String? location;
  String? profileImageUrl;
  String? description;
  String? experience;
  String? fee;

  LawyersModel(
      {this.id,
      this.username,
      this.lawyerType,
      this.gender,
      this.location,
      this.profileImageUrl,
      this.description,
      this.experience,
      this.fee});

  toList() {}
}
