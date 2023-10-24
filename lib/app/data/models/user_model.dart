import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? name;
  String? loginNumber;
  String? phone;
  String? profilePic;
  String? role;
  String? gender;
  bool? active;

  UserModel({
    this.uid,
    this.email,
    this.name,
    this.loginNumber,
    this.phone,
    this.profilePic,
    this.role,
    this.active,
    this.gender,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      loginNumber: map['loginNumber'],
      phone: map['phone'],
      profilePic: map['profilePic'],
      role: map['role'],
      gender: map['gender'],
      active: map['active'],
    );
  }
  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot.id,
      email: data['email'],
      name: data["name"],
      loginNumber: data["loginNumber"],
      phone: data["phone"],
      profilePic: data["profilePic"],
      role: data["role"],
      gender: data["gender"],
      active: data["active"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'loginNumber': loginNumber,
      'phone': phone,
      'profilePic': profilePic,
      'role': role,
      'gender': gender,
      'active': active,
    };
  }
}
