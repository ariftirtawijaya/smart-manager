import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/data/models/category_model.dart';
import 'package:smart_manager/app/data/models/product_model.dart';
import 'package:smart_manager/app/data/models/store_model.dart';
import 'package:smart_manager/app/data/models/user_model.dart';
import 'package:smart_manager/app/data/services/db_service.dart';

class DataController extends GetxController {
  final logger = Logger();
  var users = RxList<UserModel>([]);
  var employees = RxList<UserModel>([]);
  var categories = RxList<CategoryModel>([]);
  var products = RxList<ProductModel>([]);
  var stores = RxList<StoreModel>([]);
  var variantTypes = RxList<String>([]);
  Rx<StoreModel> store = StoreModel().obs;
  RxString status = ''.obs;

  RxBool isLoading = false.obs;

  Future<void> getUsers() async {
    status.value = 'Users';
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
    logger.i(users.toString());
    isLoading.value = false;
  }

  Future<void> getEmployees() async {
    status.value = 'Employees';
    isLoading.value = true;
    final querySnapshot = await DBService.db
        .collection(storesRef)
        .doc(store.value.id)
        .collection(employeeRef)
        .get();
    employees.clear();
    for (var element in querySnapshot.docs) {
      employees.add(UserModel.fromSnapshot(element));
    }
    employees.sort(
      (a, b) => a.name!.compareTo(b.name!),
    );
    logger.i(employees.toString());
    isLoading.value = false;
  }

  Future<void> getStores() async {
    status.value = 'Stores';
    final querySnapshot = await DBService.getCollections(from: storesRef);
    stores.clear();
    for (var element in querySnapshot.docs) {
      stores.add(StoreModel.fromSnapshot(element));
    }
    stores.sort(
      (a, b) => a.name!.compareTo(b.name!),
    );
    logger.i(stores.toString());
  }

  Future<void> getCategories() async {
    status.value = 'Categories';
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
    logger.i(categories.toString());
    isLoading.value = false;
  }

  Future<void> getVariantType() async {
    status.value = 'Variant Type';

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
    logger.i(variantTypes.toString());
  }

  Future<void> getProducts() async {
    status.value = 'Product Data';
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
          "stock": element["stock"],
          "name": element["name"],
          "sold": element["sold"]
        },
      };
      if (element.data().toString().contains("image")) {
        productData["product"]["image"] = element["image"];
      }
      if (element.data().toString().contains("description")) {
        productData["product"]["description"] = element["description"];
      }
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
        productData.addAll({"prices": variantPricesData});
        productData.addAll({'variants': variantData});
      }
      products.add(ProductModel.fromMap(productData));
    }
    logger.i(products);
    isLoading.value = false;
  }

  Future<void> getStore(String uid) async {
    status.value = 'Store';
    await DBService.getCollections(
            from: storesRef, where: 'userId', isEqualTo: uid)
        .then((result) {
      if (result.docs.isNotEmpty) {
        store.value = StoreModel.fromSnapshot(result.docs.first);
      }
    });
    logger.i(store.toString());
  }

  void clear() {
    users.clear();
    store.value = StoreModel();
  }
}
