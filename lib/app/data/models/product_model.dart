import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductModel {
  Product product;
  List<ProductVariant>? variants;
  RxList<VariantPrices>? prices;

  ProductModel({
    required this.product,
    this.variants,
    this.prices,
  });

  factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final product = Product.fromJson(data['product']);
    final variants = (data['variants'] as List<dynamic>?)
        ?.map((variantData) => ProductVariant.fromMap(variantData))
        .toList();

    return ProductModel(product: product, variants: variants);
  }
  factory ProductModel.fromJson(Map<String, dynamic> data) {
    // final Map<String, dynamic> data = jsonDecode(json);
    final product = Product.fromJson(data['product']);
    final variants = (data['variants'] as List<dynamic>?)
        ?.map((variantData) => ProductVariant.fromMap(variantData))
        .toList();

    final prices = (data['prices'] as List<dynamic>?)
        ?.map((priceData) => VariantPrices.fromMap(priceData))
        .toList()
        .obs;

    return ProductModel(product: product, variants: variants, prices: prices);
  }
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    final product = Product.fromMap(map['product']);
    final variants = (map['variants'] as List<dynamic>?)
        ?.map((variantData) => ProductVariant.fromMap(variantData))
        .toList();
    final prices = (map['prices'] as List<dynamic>?)
        ?.map((priceData) => VariantPrices.fromMap(priceData))
        .toList()
        .obs;
    return ProductModel(product: product, variants: variants, prices: prices);
  }
  String toJson() {
    final Map<String, dynamic> data = {
      'product': product.toJson(),
      'variants': variants?.map((variant) => variant.toMap()).toList(),
      'prices': prices?.map((price) => price.toMap()).toList(),
    };
    return jsonEncode(data);
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'variants': variants?.map((variant) => variant.toMap()).toList(),
      'prices': prices?.map((price) => price.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return toJson();
  }
}

class Product {
  String id;
  String categoryId;
  double price;
  String sku;
  String? image;
  int stock;
  String name;
  String? description;
  int sold;

  Product({
    required this.id,
    required this.categoryId,
    required this.price,
    required this.sku,
    this.image,
    required this.stock,
    required this.name,
    required this.sold,
    this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      categoryId: json['categoryId'],
      price: json['price'],
      sku: json['sku'],
      sold: json['sold'],
      image: json['image'],
      stock: json['stock'],
      name: json['name'],
      description: json['description'],
    );
  }
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      categoryId: map['categoryId'],
      price: map['price'],
      sku: map['sku'],
      image: map['image'],
      sold: map['sold'],
      stock: map['stock'],
      name: map['name'],
      description: map['description'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'price': price,
      'sku': sku,
      'image': image,
      'sold': sold,
      'stock': stock,
      'name': name,
      'description': description,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'price': price,
      'sku': sku,
      'image': image,
      'sold': sold,
      'stock': stock,
      'name': name,
      'description': description,
    };
  }
}

class ProductVariant {
  String? name;
  RxList<String>? options;

  ProductVariant({
    this.name,
    this.options,
  });

  @override
  String toString() {
    return 'ProductVariant(name: $name, options: $options)';
  }

  factory ProductVariant.fromMap(Map<String, dynamic> map) {
    return ProductVariant(
      name: map['name'],
      options: (map['options'] as List<dynamic>?)
          ?.map((option) => option.toString())
          .toList()
          .obs,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'options': options,
    };
  }
}

class VariantPrices {
  Map<String, dynamic>? option;
  double? price;
  int? stock;
  String? sku;

  VariantPrices({
    this.option,
    this.price,
    this.stock,
    this.sku,
  });

  @override
  String toString() {
    return 'VariantPrices(option: $option, price: $price, stock: $stock, sku: $sku)';
  }

  factory VariantPrices.fromMap(Map<String, dynamic> map) {
    double price = 0.0;
    if (map['price'].runtimeType == int) {
      price = double.parse(map['price'].toString());
    } else if (map['price'].runtimeType == double) {
      price = map['price'];
    }
    return VariantPrices(
      option: map['option'] as Map<String, dynamic>?,
      price: price,
      stock: map['stock'] as int?,
      sku: map['sku'] as String?,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'option': option,
      'price': price,
      'stock': stock,
      'sku': sku,
    };
  }
}
