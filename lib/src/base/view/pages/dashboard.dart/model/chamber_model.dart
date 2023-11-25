import 'package:cloud_firestore/cloud_firestore.dart';

class ChamberModel {
  ChamberModel({
      this.createdAt, 
      this.image, 
      this.name, 
      this.id, 
      this.updatedAt, 
      this.status,});

  ChamberModel.fromJson(dynamic json) {
    createdAt = json['createdAt'];
    image = json['image'];
    name = json['name'];
    id = json['id'];
    updatedAt = json['updatedAt'];
    status = json['status'];
  }
  Timestamp? createdAt;
  String? image;
  String? name;
  String? id;
  Timestamp? updatedAt;
  num? status;
ChamberModel copyWith({  Timestamp? createdAt,
  String? image,
  String? name,
  String? id,
  Timestamp? updatedAt,
  num? status,
}) => ChamberModel(  createdAt: createdAt ?? this.createdAt,
  image: image ?? this.image,
  name: name ?? this.name,
  id: id ?? this.id,
  updatedAt: updatedAt ?? this.updatedAt,
  status: status ?? this.status,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createdAt'] = createdAt;
    map['image'] = image;
    map['name'] = name;
    map['id'] = id;
    map['updatedAt'] = updatedAt;
    map['status'] = status;
    return map;
  }

}