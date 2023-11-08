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
import 'package:smart_manager/app/constant/app_colors.dart';
import 'package:smart_manager/app/constant/app_strings.dart';
import 'package:smart_manager/app/controllers/auth_controller.dart';
import 'package:smart_manager/app/controllers/data_controller.dart';
import 'package:smart_manager/app/data/models/product_model.dart';
import 'package:smart_manager/app/data/services/db_service.dart';
import 'package:smart_manager/app/utils/functions/reusable_functions.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class ProductController extends GetxController {
  final authC = Get.find<AuthController>();
  final dataC = Get.find<DataController>();
  var productVariant = RxList<ProductVariant>([]);
  var productPrices = RxList<VariantPrices>([]);

  RxInt selectedCategoryIndex = 1.obs;
  RxString selectedCategoryId = "".obs;
  // RxBool isImageNull = false.obs;

  var listSearchProduct = RxList<ProductModel>([]);
  final TextEditingController searchProductC = TextEditingController();
  var keywordProduct = ''.obs;

  void clear() {
    productVariant.clear();
    stockController.clear();
    descriptionController.clear();
    nameController.clear();
    categoryController.clear();
    skuController.clear();
    regularPriceController.clear();
    imagePath = '';
    // isImageNull.value = false;
  }

  @override
  void onInit() {
    selectedCategoryIndex.value = 1;
    selectedCategoryId.value = '';
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

  void changeKeyword() {
    keywordProduct.value = searchProductC.text;
    update();
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
        if (croppedFile != null) {
          imagePath = croppedFile.path;
          // isImageNull.value = false;
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

  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController skuController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController variantController = TextEditingController();
  TextEditingController variantValueController = TextEditingController();
  TextEditingController regularPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void deleteValueVariant(ProductVariant variantType, String value) {
    productVariant
        .where((variantData) => variantData.name == variantType.name)
        .first
        .options!
        .removeWhere((element) => element == value);
  }

  bool mapEquals(Map<String, dynamic>? map1, Map<String, dynamic> map2) {
    if (map1 == null) {
      return false;
    }
    if (map1.length != map2.length) {
      return false;
    }
    for (var key in map1.keys) {
      if (map1[key] != map2[key]) {
        return false;
      }
    }
    return true;
  }

  void setVariantPrices() {
    if (productVariant.length > 1) {
      productPrices.clear();
      for (var firstOptions in productVariant.first.options!) {
        for (var secondOptions in productVariant.last.options!) {
          Map<String, String> priceOption = {firstOptions: secondOptions};
          productPrices.add(
            VariantPrices(
              option: priceOption,
              price: 0,
              sku: "",
              stock: 0,
            ),
          );
        }
      }
    } else {
      productPrices.clear();
      for (var firstOptions in productVariant.first.options!) {
        Map<String, String> priceOption = {firstOptions: firstOptions};
        productPrices.add(
          VariantPrices(
            option: priceOption,
            price: 0,
            sku: "",
            stock: 0,
          ),
        );
      }
    }
  }

  void addValueVariant(BuildContext context, ProductVariant variantType) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    variantValueController.clear();
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Add Options For ${variantType.name}",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTextField(
                    autofocus: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Cannot empty!\n';
                      }
                      if (productVariant
                          .where((variantData) =>
                              variantData.name == variantType.name)
                          .first
                          .options!
                          .where((variantOption) =>
                              variantOption.toLowerCase() ==
                              value.toLowerCase())
                          .isNotEmpty) {
                        return 'Name is already in use!\n';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      if (value.isEmpty) {
                        formKey.currentState!.reset();
                      }
                    },
                    onComplete: () {
                      if (formKey.currentState!.validate()) {
                        productVariant
                            .where((variantData) =>
                                variantData.name == variantType.name)
                            .first
                            .options!
                            .add(variantValueController.text);
                        Get.back();
                      }
                    },
                    controller: variantValueController,
                    title: "${variantType.name} Name",
                    hintText: "Insert ${variantType.name} Name"),
                const SizedBox(
                  height: 16.0,
                ),
                CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      productVariant
                          .where((variantData) =>
                              variantData.name == variantType.name)
                          .first
                          .options!
                          .add(variantValueController.text);
                      Get.back();
                    }
                  },
                  text: 'Add',
                )
              ],
            ),
          ),
        ),
      ),
      isDismissible: false,
    );
  }

  Future<void> variantModal(
      {required BuildContext context, required bool isFromAdd}) {
    variantController.clear();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                !isFromAdd
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Choose Variant Type",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Obx(
                            () => SizedBox(
                              width: Get.width,
                              child: Wrap(
                                children: dataC.variantTypes
                                    .map(
                                      (variantType) => Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ActionChip(
                                            label: Text(
                                              variantType,
                                              style: productVariant
                                                      .where((variantData) =>
                                                          variantData.name ==
                                                          variantType)
                                                      .isNotEmpty
                                                  ? const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)
                                                  : null,
                                            ),
                                            backgroundColor: productVariant
                                                    .where((variantData) =>
                                                        variantData.name ==
                                                        variantType)
                                                    .isNotEmpty
                                                ? primaryColor
                                                : null,
                                            onPressed: () {
                                              if (productVariant
                                                  .where((variantData) =>
                                                      variantData.name ==
                                                      variantType)
                                                  .isEmpty) {
                                                if (productVariant.length < 2) {
                                                  var selectedVariant =
                                                      ProductVariant(
                                                    name: variantType,
                                                    options: RxList<String>([]),
                                                  );
                                                  productVariant
                                                      .add(selectedVariant);
                                                  Get.back();
                                                } else {
                                                  EasyLoading.showToast(
                                                      'Maximum 2 types of product variants');
                                                }
                                              } else {
                                                productVariant.removeWhere(
                                                    (variant) =>
                                                        variant.name ==
                                                        variantType);
                                              }
                                            },
                                            pressElevation: 2,
                                          ),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                        ],
                      )
                    : const SizedBox(),
                Text(
                  isFromAdd ? "Create New Variant Type" : "Or Create New",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTextField(
                  onComplete: () {
                    if (formKey.currentState!.validate()) {
                      createVariantType(context);
                    }
                  },
                  onChanged: (value) {
                    if (value.isEmpty) {
                      formKey.currentState!.reset();
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Cannot empty!\n';
                    }
                    if (dataC.variantTypes.isNotEmpty) {
                      if (dataC.variantTypes
                          .where((variantType) =>
                              variantType.toLowerCase() == value.toLowerCase())
                          .isNotEmpty) {
                        return 'Variant type already exists!\n';
                      }
                    }
                    return null;
                  },
                  controller: variantController,
                  title: 'Variant Type Name',
                  hintText: 'Color, Size, Pattern, etc',
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      createVariantType(context);
                    }
                  },
                  text: 'Save',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createVariantType(BuildContext context) async {
    showLoading(status: 'Creating Variant Type ...');
    try {
      await DBService.db
          .collection(storesRef)
          .doc(dataC.store.value.id)
          .collection(variantTypeRef)
          .doc(variantController.text)
          .set({}).then((_) async {});
      await dataC.getVariantType();
      endLoading();
      EasyLoading.showSuccess('New Variant Type Created!');
      variantController.clear();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      endLoading().then(
        (value) => showAlert(
          context: context,
          text: 'Error While Creating Variant Type!',
          type: QuickAlertType.error,
        ),
      );
    }
  }

  Future<void> createProduct(BuildContext context) async {
    showLoading(status: 'Creating Product ...');
    try {
      Map<String, dynamic> product = {
        'name': nameController.text,
        'categoryId': categoryController.text,
        'sku': skuController.text,
        'stock': int.parse(stockController.text),
        'price': double.parse(regularPriceController.text),
      };
      if (descriptionController.text.isNotEmpty) {
        product.addAll({'description': descriptionController.text});
      }
      await DBService.db
          .collection(storesRef)
          .doc(dataC.store.value.id)
          .collection(productsRef)
          .add(product)
          .then((productData) async {
        if (imagePath != '') {
          String imagesFile = DateTime.now().microsecondsSinceEpoch.toString();
          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceDirImages =
              referenceRoot.child("store/${dataC.store.value.id}/products");
          Reference referenceImageUpload = referenceDirImages.child(imagesFile);
          await referenceImageUpload.putFile(File(imagePath));
          String imageUrl = await referenceImageUpload.getDownloadURL();
          await DBService.db
              .collection(storesRef)
              .doc(dataC.store.value.id)
              .collection(productsRef)
              .doc(productData.id)
              .update({'image': imageUrl});
        }
        if (productVariant.isNotEmpty) {
          for (var variant in productVariant) {
            await DBService.db
                .collection(storesRef)
                .doc(dataC.store.value.id)
                .collection(productsRef)
                .doc(productData.id)
                .collection(variantsRef)
                .add({
              'name': variant.name,
              'options': variant.options,
            });
          }
          for (var price in productPrices) {
            await DBService.db
                .collection(storesRef)
                .doc(dataC.store.value.id)
                .collection(productsRef)
                .doc(productData.id)
                .collection(variantsPricesRef)
                .add({
              'option': price.option,
              'price': price.price,
              'stock': price.stock,
              'sku': price.sku,
            });
          }
        }
      });
      // await dataC.getProducts();
      endLoading();
      // Get.back();
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
