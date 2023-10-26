import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  String? storeId;
  String? storeEmail;
  String? storeName;
  String? userId;
  String? storePhone;
  String? storeAddress;
  String? storeLogo;

  StoreModel({
    this.storeId,
    this.storeEmail,
    this.storeName,
    this.userId,
    this.storePhone,
    this.storeAddress,
    this.storeLogo,
  });

  @override
  String toString() {
    return '${storeName!.toLowerCase()}, ${storeEmail!.toLowerCase()}, ${userId!.toLowerCase()}, ${storePhone!.toLowerCase()}';
  }

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      storeId: map['storeId'],
      storeName: map['storeName'],
      storeEmail: map['storeEmail'],
      userId: map['userId'],
      storePhone: map['storePhone'],
      storeAddress: map['storeAddress'],
      storeLogo: map['storeLogo'],
    );
  }
  factory StoreModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return StoreModel(
      storeId: snapshot.id,
      storeEmail: data['storeEmail'],
      storeName: data["storeName"],
      userId: data["userId"],
      storePhone: data["storePhone"],
      storeAddress: data["storeAddress"],
      storeLogo: data["storeLogo"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storeId': storeId,
      'storeEmail': storeEmail,
      'storeName': storeName,
      'userId': userId,
      'storePhone': storePhone,
      'storeAddress': storeAddress,
      'storeLogo': storeLogo,
    };
  }
}
