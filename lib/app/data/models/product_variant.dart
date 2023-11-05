import 'package:get/get.dart';

class VariantType {
  String? name;
  RxList<VariantOptions>? options;

  VariantType({
    this.name,
    this.options,
  });

  factory VariantType.fromJson(Map<String, dynamic> json) {
    var optionsList = (json['options'] as List<dynamic>) ?? [];
    var optionsRxList = RxList<VariantOptions>(
      optionsList.map((option) => VariantOptions.fromJson(option)).toList(),
    );

    return VariantType(
      name: json['name'],
      options: optionsRxList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'options': options?.map((option) => option.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'VariantType{name: $name, options: $options}';
  }
}

class VariantOptions {
  String? name;
  double? price;
  int? stock;
  String? sku;

  VariantOptions({
    this.name,
    this.price,
    this.stock,
    this.sku,
  });

  factory VariantOptions.fromJson(Map<String, dynamic> json) {
    return VariantOptions(
      name: json['name'],
      price: json['price'],
      stock: json['stock'],
      sku: json['sku'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'stock': stock,
      'sku': sku,
    };
  }

  @override
  String toString() {
    return 'VariantOptions{name: $name, price: $price, stock: $stock, sku: $sku}';
  }
}
