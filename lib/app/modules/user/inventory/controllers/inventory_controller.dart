import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/controllers/auth_controller.dart';
import 'package:smart_manager/app/controllers/data_controller.dart';
import 'package:smart_manager/app/data/models/category_model.dart';
import 'package:smart_manager/app/data/models/product_model.dart';
import 'package:smart_manager/app/data/services/db_service.dart';
import 'package:smart_manager/app/modules/user/inventory/views/product/components/variant_form.dart';
import 'package:smart_manager/app/utils/functions/reusable_functions.dart';

class InventoryController extends GetxController {
  final authC = Get.find<AuthController>();
  final dataC = Get.find<DataController>();
  var tabIndex = 0;

  RxInt selectedCategoryIndex = 1.obs;
  RxString selectedCategoryId = "".obs;
  RxBool isImageNull = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController skuController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController regularPriceController = TextEditingController();
  TextEditingController memberPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  RxBool isLoading = false.obs;

  RxBool noMemberPrice = true.obs;

  void productByCategory({required int index, required String categoryId}) {
    selectedCategoryIndex.value = index;
  }

  void togleMemberPrice(bool value) {
    noMemberPrice.value = value;
    if (value == true) {
      memberPriceController.text = regularPriceController.text;
    } else {
      memberPriceController.clear();
    }
  }

  var hasVariant = false.obs;
  var variantForms = <Rx<VariantForm>>[].obs;

  void saveVariant() {
    bool success = false;
    for (var element in variantForms) {
      if (element.value.formKey.currentState!.validate()) {
        element.value.saved = true;
        success = true;
      } else {
        success = false;
      }
    }
    if (success) {
      Get.back();
      EasyLoading.showSuccess('Product Variant Saved Successfully!');
    }
  }

  void addVariantForm() {
    var formKey = GlobalKey<FormState>();
    var name = TextEditingController();
    var regularPrice = TextEditingController();
    var memberPrice = TextEditingController();
    var stock = TextEditingController();

    variantForms.add(
      Rx(
        VariantForm(
          formKey: formKey,
          nameController: name,
          regularPriceController: regularPrice,
          memberPriceController: memberPrice,
          stockController: stock,
        ),
      ),
    );
  }

  void deleteVariantForm(int index) {
    if (index >= 0 && index < variantForms.length) {
      variantForms.removeAt(index);
    }
  }

  void clear() {
    stockController.clear();
    descriptionController.clear();
    noMemberPrice.value = true;
    hasVariant.value = false;
    variantForms.clear();
    nameController.clear();
    categoryController.clear();
    skuController.clear();
    regularPriceController.clear();
    memberPriceController.clear();
    imagePath = '';
    isImageNull.value = false;
  }

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  var listSearchCategory = RxList<CategoryModel>([]);
  var listSearchProduct = RxList<ProductModel>([]);
  var keywordCategory = ''.obs;
  var keywordProduct = ''.obs;
  final TextEditingController searchCategoryC = TextEditingController();
  final TextEditingController searchProductC = TextEditingController();
  void changeKeyword(String type) {
    switch (type) {
      case "category":
        keywordCategory.value = searchCategoryC.text;
        break;
      case "product":
        keywordProduct.value = searchProductC.text;
        break;
    }
  }

  @override
  void onInit() {
    selectedCategoryIndex.value = 1;
    selectedCategoryId.value = '';
    debounce(
      time: const Duration(seconds: 1),
      keywordCategory,
      (callback) {
        listSearchCategory.clear();
        searchCategory(searchCategoryC.text);
      },
    );
    debounce(
      time: const Duration(seconds: 1),
      keywordProduct,
      (callback) {
        listSearchProduct.clear();
        searchProduct(searchProductC.text);
      },
    );
    super.onInit();
  }

  searchCategory(String value) {
    if (value.isEmpty) {
      listSearchCategory.clear();
    } else {
      listSearchCategory.value = dataC.categories
          .where((category) =>
              category.toString().toLowerCase().contains(value.toLowerCase()) ||
              category.toString().toLowerCase().startsWith(value.toLowerCase()))
          .toList();
    }
  }

  searchProduct(String value) {
    if (value.isEmpty) {
      listSearchProduct.clear();
    } else {
      listSearchProduct.value = dataC.products
          .where((product) =>
              product.toString().toLowerCase().contains(value.toLowerCase()) ||
              product.toString().toLowerCase().startsWith(value.toLowerCase()))
          .toList();
    }
  }

  String imagePath = '';
  final picker = ImagePicker();

  void pickImage(BuildContext context) async {
    try {
      imagePath = '';
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          maxWidth: 500,
          maxHeight: 500,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
          compressFormat: ImageCompressFormat.png,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
              hideBottomControls: false,
              dimmedLayerColor: Colors.black.withOpacity(0.8),
              showCropGrid: false,
            ),
            IOSUiSettings(
                title: 'Crop Image',
                hidesNavigationBar: true,
                rectHeight: Get.width,
                rectWidth: Get.width),
          ],
          compressQuality: 60,
        );
        print(croppedFile);
        if (croppedFile != null) {
          imagePath = croppedFile.path;
          isImageNull.value = false;
        }
      }
    } on PlatformException catch (e) {
      endLoading().then(
        (value) => showAlert(
            context: context,
            type: QuickAlertType.error,
            text: e.message.toString()),
      );
    } catch (e) {
      endLoading().then(
        (value) => showAlert(
            context: context,
            type: QuickAlertType.error,
            text: "Error while opening image, try to select another image"),
      );
    }
    update();
  }

  Future<void> createCategory(BuildContext context) async {
    showLoading(status: 'Creating Category ...');
    try {
      await DBService.db
          .collection(storesRef)
          .doc(dataC.store.value.storeId)
          .collection(categoriesRef)
          .add({
        'categoryName': nameController.text,
      }).then((categoryData) async {
        if (imagePath != '') {
          String imagesFile = DateTime.now().microsecondsSinceEpoch.toString();
          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceDirImages = referenceRoot
              .child("store/${dataC.store.value.storeId}/categories");
          Reference referenceImageUpload = referenceDirImages.child(imagesFile);
          await referenceImageUpload.putFile(File(imagePath));
          String imageUrl = await referenceImageUpload.getDownloadURL();
          await DBService.db
              .collection(storesRef)
              .doc(dataC.store.value.storeId)
              .collection(categoriesRef)
              .doc(categoryData.id)
              .update({'categoryIcon': imageUrl});
        }
      });
      await dataC.getCategories();
      endLoading();
      Get.back();
      EasyLoading.showSuccess('New Category Created!');
      clear();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      endLoading().then(
        (value) => showAlert(
          context: context,
          text: 'Error While Creating Category!',
          type: QuickAlertType.error,
        ),
      );
    }
  }

  Future<void> updateCategory(
      BuildContext context, CategoryModel category) async {
    showLoading(status: 'Updating Category ...');
    try {
      await DBService.db
          .collection(storesRef)
          .doc(dataC.store.value.storeId)
          .collection(categoriesRef)
          .doc(category.categoryId)
          .update({
        'categoryName': nameController.text,
      }).then((_) async {
        if (imagePath != '') {
          if (category.categoryIcon != null) {
            final storageRef =
                FirebaseStorage.instance.refFromURL(category.categoryIcon!);
            await storageRef.delete();
          }
          String imagesFile = DateTime.now().microsecondsSinceEpoch.toString();
          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceDirImages = referenceRoot
              .child("store/${dataC.store.value.storeId}/categories");
          Reference referenceImageUpload = referenceDirImages.child(imagesFile);
          await referenceImageUpload.putFile(File(imagePath));
          String imageUrl = await referenceImageUpload.getDownloadURL();
          await DBService.db
              .collection(storesRef)
              .doc(dataC.store.value.storeId)
              .collection(categoriesRef)
              .doc(category.categoryId)
              .update({'categoryIcon': imageUrl});
        }
        await dataC.getCategories();
        endLoading();
        Get.back();
        EasyLoading.showSuccess('Category Updated!');
        clear();
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      endLoading().then(
        (value) => showAlert(
          context: context,
          text: 'Error While Updating Category',
          type: QuickAlertType.error,
        ),
      );
    }
  }

  Future<void> deleteCategory(
      BuildContext context, CategoryModel category) async {
    endLoading().then(
      (value) => showAlert(
        context: context,
        text:
            'Are you sure want to delete this category ?\n\nThis action cannot be undone!',
        type: QuickAlertType.confirm,
        confirmText: 'Delete Category',
        onConfirmBtnTap: () async {
          try {
            showLoading();
            if (category.categoryIcon != null) {
              final storageRef =
                  FirebaseStorage.instance.refFromURL(category.categoryIcon!);
              await storageRef.delete();
            }
            await DBService.db
                .collection(storesRef)
                .doc(dataC.store.value.storeId)
                .collection(categoriesRef)
                .doc(category.categoryId)
                .delete()
                .then((_) async {
              await dataC.getProducts();
              endLoading();
              Get.back();
              EasyLoading.showSuccess('Category Successfully Deleted!');
            });
          } catch (e) {
            if (kDebugMode) {
              print(e.toString());
            }
            endLoading().then(
              (value) => showAlert(
                context: context,
                text: 'Error While Deleting Category',
                type: QuickAlertType.error,
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> createProduct(BuildContext context) async {
    showLoading(status: 'Creating Product ...');
    try {
      Map<String, dynamic> product = {
        'productName': nameController.text,
        'productCategoryId': categoryController.text,
        'productSKU': skuController.text,
        'productStock': int.parse(stockController.text),
        'productRegularPrice': double.parse(regularPriceController.text),
        'productMemberPrice': double.parse(memberPriceController.text),
      };
      if (descriptionController.text.isNotEmpty) {
        product.addAll({'productDescription': descriptionController.text});
      }
      await DBService.db
          .collection(storesRef)
          .doc(dataC.store.value.storeId)
          .collection(productsRef)
          .add(product)
          .then((productData) async {
        if (imagePath != '') {
          String imagesFile = DateTime.now().microsecondsSinceEpoch.toString();
          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceDirImages = referenceRoot
              .child("store/${dataC.store.value.storeId}/products");
          Reference referenceImageUpload = referenceDirImages.child(imagesFile);
          await referenceImageUpload.putFile(File(imagePath));
          String imageUrl = await referenceImageUpload.getDownloadURL();
          await DBService.db
              .collection(storesRef)
              .doc(dataC.store.value.storeId)
              .collection(productsRef)
              .doc(productData.id)
              .update({'productImage': imageUrl});
        }
        if (hasVariant.isTrue) {
          for (var variant in variantForms) {
            await DBService.db
                .collection(storesRef)
                .doc(dataC.store.value.storeId)
                .collection(productsRef)
                .doc(productData.id)
                .collection(variantsRef)
                .add({
              'variantName': variant.value.nameController.text,
              'variantRegularPrice':
                  double.parse(variant.value.regularPriceController.text),
              'variantMemberPrice':
                  double.parse(variant.value.memberPriceController.text),
              'variantStock': int.parse(variant.value.stockController.text),
            });
          }
        }
      });
      // await dataC.getCategory();
      endLoading();
      Get.back();
      EasyLoading.showSuccess('New Product Created!');
      clear();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      endLoading().then(
        (value) => showAlert(
          context: context,
          text: 'Error While Creating Product!',
          type: QuickAlertType.error,
        ),
      );
    }
  }
}
