import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? categoryId;
  String? categoryName;
  String? categoryIcon;

  CategoryModel({
    this.categoryId,
    this.categoryName,
    this.categoryIcon,
  });

  @override
  String toString() {
    return categoryName!.toLowerCase();
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['categoryId'],
      categoryName: map['categoryName'],
      categoryIcon: map['categoryIcon'],
    );
  }
  factory CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return CategoryModel(
      categoryId: snapshot.id,
      categoryName: data["categoryName"],
      categoryIcon: data["categoryIcon"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'categoryIcon': categoryIcon,
    };
  }
}
