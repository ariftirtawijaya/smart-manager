import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  String? id;
  String? email;
  String? name;
  String? userId;
  String? phone;
  String? address;
  String? logo;

  StoreModel({
    this.id,
    this.email,
    this.name,
    this.userId,
    this.phone,
    this.address,
    this.logo,
  });

  @override
  String toString() {
    return '${name!.toLowerCase()}, ${email!.toLowerCase()}, ${userId!.toLowerCase()}, ${phone!.toLowerCase()}';
  }

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      userId: map['userId'],
      phone: map['phone'],
      address: map['address'],
      logo: map['logo'],
    );
  }
  factory StoreModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return StoreModel(
      id: snapshot.id,
      email: data['email'],
      name: data["name"],
      userId: data["userId"],
      phone: data["phone"],
      address: data["address"],
      logo: data["logo"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'userId': userId,
      'phone': phone,
      'address': address,
      'logo': logo,
    };
  }
}
