import 'dart:convert';

import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/data/models/category_model.dart';
import 'package:smart_manager/app/data/models/product_model.dart';
import 'package:smart_manager/app/data/models/store_model.dart';
import 'package:smart_manager/app/data/models/user_model.dart';
import 'package:smart_manager/app/data/services/db_service.dart';

class DataController extends GetxController {
  var users = RxList<UserModel>([]);
  var categories = RxList<CategoryModel>([]);
  var products = RxList<ProductModel>([]);
  var variantTypes = RxList<String>([]);
  Rx<StoreModel> store = StoreModel().obs;

  RxBool isLoading = false.obs;

  Future<void> getUsers() async {
    isLoading.value = true;
    final querySnapshot = await DBService.getCollections(
        from: usersRef, where: 'role', isEqualTo: 'user');
    clear();
    for (var element in querySnapshot.docs) {
      users.add(UserModel.fromSnapshot(element));
    }
    users.sort(
      (a, b) => a.name!.compareTo(b.name!),
    );
    isLoading.value = false;
  }

  Future<void> getCategories() async {
    isLoading.value = true;
    final querySnapshot = await DBService.getSubCollection(
        from: storesRef, id: store.value.id!, subCollection: categoriesRef);
    categories.clear();
    for (var element in querySnapshot.docs) {
      categories.add(CategoryModel.fromSnapshot(element));
    }
    categories.sort(
      (a, b) => a.categoryName!.compareTo(b.categoryName!),
    );
    isLoading.value = false;
  }

  Future<void> getVariantType() async {
    final querySnapshot = await DBService.db
        .collection(storesRef)
        .doc(store.value.id)
        .collection(variantTypeRef)
        .get();
    variantTypes.clear();
    for (var element in querySnapshot.docs) {
      variantTypes.add(element.id);
    }
    variantTypes.sort(
      (a, b) => a.compareTo(b),
    );
  }

  Future<void> getProducts() async {
    isLoading.value = true;
    final querySnapshot = await DBService.getSubCollection(
        from: storesRef, id: store.value.id!, subCollection: productsRef);
    products.clear();
    for (var element in querySnapshot.docs) {
      Map<String, dynamic> productData = {
        'product': {
          "id": element.id,
          "categoryId": element["categoryId"],
          "price": element["price"],
          "sku": element["sku"],
          "image": element["image"],
          "stock": element["stock"],
          "name": element["name"],
          "description": element.toString().contains("description")
              ? element["description"]
              : '',
        },
      };
      List<Map<String, dynamic>> variantData = [];
      List<Map<String, dynamic>> variantPricesData = [];

      final variantSnapshot = await DBService.db
          .collection(storesRef)
          .doc(store.value.id)
          .collection(productsRef)
          .doc(element.id)
          .collection(variantsRef)
          .get();
      if (variantSnapshot.docs.isNotEmpty) {
        final variantPriceSnapshot = await DBService.db
            .collection(storesRef)
            .doc(store.value.id)
            .collection(productsRef)
            .doc(element.id)
            .collection(variantsPricesRef)
            .get();
        for (var variant in variantSnapshot.docs) {
          variantData.add(variant.data());
        }
        for (var prices in variantPriceSnapshot.docs) {
          variantPricesData.add(prices.data());
        }
        variantData.last.addAll({"prices": variantPricesData});
        productData.addAll({'variants': variantData});
      }
      products.add(ProductModel.fromMap(productData));
    }
    isLoading.value = false;
  }

  Future<void> getStore(String uid) async {
    await DBService.getCollections(
            from: storesRef, where: 'userId', isEqualTo: uid)
        .then((result) {
      if (result.docs.isNotEmpty) {
        store.value = StoreModel.fromSnapshot(result.docs.first);
      }
    });
  }

  void clear() {
    users.clear();
    store.value = StoreModel();
  }
}
