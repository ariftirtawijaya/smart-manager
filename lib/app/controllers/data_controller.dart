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
        from: storesRef,
        id: store.value.storeId!,
        subCollection: categoriesRef);
    categories.clear();
    for (var element in querySnapshot.docs) {
      categories.add(CategoryModel.fromSnapshot(element));
    }
    categories.sort(
      (a, b) => a.categoryName!.compareTo(b.categoryName!),
    );
    isLoading.value = false;
  }

  Future<void> getProducts() async {
    isLoading.value = true;
    final querySnapshot = await DBService.getSubCollection(
        from: storesRef, id: store.value.storeId!, subCollection: productsRef);
    products.clear();
    for (var element in querySnapshot.docs) {
      Map<String, dynamic> productData = {
        'product': {
          "productId": element.id,
          "productCategoryId": element["productCategoryId"],
          "productRegularPrice": element["productRegularPrice"],
          "productSKU": element["productSKU"],
          "productImage": element["productImage"],
          "productStock": element["productStock"],
          "productName": element["productName"],
          "productMemberPrice": element["productMemberPrice"],
          "productDescription": element.toString().contains("Description")
              ? element["productDescription"]
              : '',
        },
      };
      await DBService.db
          .collection(storesRef)
          .doc(store.value.storeId)
          .collection(productsRef)
          .doc(element.id)
          .collection(variantsRef)
          .get()
          .then((variant) {
        if (variant.docs.isNotEmpty) {
          List<Map<String, dynamic>> variantData = [];
          for (var element in variant.docs) {
            Map<String, dynamic> variantOnly = {
              "variantId": element.id,
              "variantStock": element["variantStock"],
              "variantRegularPrice": element["variantRegularPrice"],
              "variantName": element["variantName"],
              "variantMemberPrice": element["variantMemberPrice"],
            };
            variantData.add(variantOnly);
          }
          productData.addAll({'variants': variantData});
        }
      });
      products.add(ProductModel.fromJson(productData));
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
