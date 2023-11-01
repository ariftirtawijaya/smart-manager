import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  Product product;
  List<Variant>? variants;

  ProductModel({
    required this.product,
    this.variants,
  });

  @override
  String toString() {
    return product.productName.toLowerCase();
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        product: Product.fromJson(json["product"]),
        variants: json["variants"] == null
            ? []
            : List<Variant>.from(
                json["variants"]!.map((x) => Variant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "variants": variants == null
            ? []
            : List<dynamic>.from(variants!.map((x) => x.toJson())),
      };
}

class Product {
  String productId;
  String productCategoryId;
  double productRegularPrice;
  String productSku;
  String productImage;
  int productStock;
  String productName;
  double productMemberPrice;
  String? productDescription;

  Product({
    required this.productId,
    required this.productCategoryId,
    required this.productRegularPrice,
    required this.productSku,
    required this.productImage,
    required this.productStock,
    required this.productName,
    required this.productMemberPrice,
    this.productDescription,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        productCategoryId: json["productCategoryId"],
        productRegularPrice: json["productRegularPrice"],
        productSku: json["productSKU"],
        productImage: json["productImage"],
        productStock: json["productStock"],
        productName: json["productName"],
        productMemberPrice: json["productMemberPrice"],
        productDescription: json["productDescription"],
      );

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Product(
      productId: snapshot.id,
      productCategoryId: data["productCategoryId"],
      productRegularPrice: data["productRegularPrice"],
      productSku: data["productSKU"],
      productImage: data["productImage"],
      productStock: data["productStock"],
      productName: data["productName"],
      productMemberPrice: data["productMemberPrice"],
      productDescription: data["productDescription"],
    );
  }

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productCategoryId": productCategoryId,
        "productRegularPrice": productRegularPrice,
        "productSKU": productSku,
        "productImage": productImage,
        "productStock": productStock,
        "productName": productName,
        "productMemberPrice": productMemberPrice,
        "productDescription": productDescription,
      };
}

class Variant {
  String variantId;
  int variantStock;
  double variantRegularPrice;
  String variantName;
  double variantMemberPrice;

  Variant({
    required this.variantId,
    required this.variantStock,
    required this.variantRegularPrice,
    required this.variantName,
    required this.variantMemberPrice,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        variantId: json["variantId"],
        variantStock: json["variantStock"],
        variantRegularPrice: json["variantRegularPrice"],
        variantName: json["variantName"],
        variantMemberPrice: json["variantMemberPrice"],
      );

  factory Variant.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Variant(
      variantId: snapshot.id,
      variantStock: data["variantStock"],
      variantRegularPrice: data["variantRegularPrice"],
      variantName: data["variantName"],
      variantMemberPrice: data["variantMemberPrice"],
    );
  }

  Map<String, dynamic> toJson() => {
        "variantId": variantId,
        "variantStock": variantStock,
        "variantRegularPrice": variantRegularPrice,
        "variantName": variantName,
        "variantMemberPrice": variantMemberPrice,
      };
}
