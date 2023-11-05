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
import 'package:smart_manager/app/data/models/product_variant.dart';
import 'package:smart_manager/app/data/services/db_service.dart';
import 'package:smart_manager/app/modules/user/inventory/views/product/components/variant_form.dart';
import 'package:smart_manager/app/utils/functions/reusable_functions.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

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
  TextEditingController variantController = TextEditingController();
  TextEditingController variantValueController = TextEditingController();
  TextEditingController regularPriceController = TextEditingController();
  // TextEditingController memberPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  RxBool isLoading = false.obs;

  var productVariant = RxList<VariantType>([]);

  void deleteValueVariant(VariantType variantType, String value) {
    productVariant
        .where((variantData) => variantData.name == variantType.name)
        .first
        .options!
        .removeWhere((element) => element.name == value);
  }

  void addValueVariant(BuildContext context, VariantType variantType) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    variantValueController.clear();
    Get.bottomSheet(Container(
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
              Text("Add ${variantType.name}",
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
                            variantOption.name!.toLowerCase() ==
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
                          .add(VariantOptions(
                              name: variantValueController.text));
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
                        .add(VariantOptions(name: variantValueController.text));
                    addVariantForm();
                    Get.back();
                  }
                },
                text: 'Add',
              )
            ],
          ),
        ),
      ),
    ));
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
                                                  productVariant.add(
                                                      VariantType(
                                                          name: variantType,
                                                          options: RxList([])));
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
          .doc(dataC.store.value.storeId)
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

  // RxBool noMemberPrice = true.obs;

  // void togleMemberPrice(bool value) {
  //   noMemberPrice.value = value;
  //   if (value == true) {
  //     memberPriceController.text = regularPriceController.text;
  //   } else {
  //     memberPriceController.clear();
  //   }
  // }

  var hasVariant = false.obs;
  var variantForms = <Rx<VariantForm>>[].obs;

  // void saveVariant() {
  //   bool success = false;
  //   for (var element in variantForms) {
  //     if (element.value.formKey.currentState!.validate()) {
  //       element.value.saved = true;
  //       success = true;
  //     } else {
  //       success = false;
  //     }
  //   }
  //   if (success) {
  //     Get.back();
  //     EasyLoading.showSuccess('Product Variant Saved Successfully!');
  //   }
  // }

  void addVariantForm() {
    var formKey = GlobalKey<FormState>();
    var name = TextEditingController();
    var price = TextEditingController();
    var stock = TextEditingController();

    variantForms.add(
      Rx(
        VariantForm(
          formKey: formKey,
          nameController: name,
          priceController: price,
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
    productVariant.clear();
    stockController.clear();
    descriptionController.clear();
    // noMemberPrice.value = true;
    hasVariant.value = false;
    variantForms.clear();
    nameController.clear();
    categoryController.clear();
    skuController.clear();
    regularPriceController.clear();
    // memberPriceController.clear();
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
        update();
        break;
      case "product":
        keywordProduct.value = searchProductC.text;
        update();
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
              await dataC.getCategories();
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

  // Future<void> createProduct(BuildContext context) async {
  //   showLoading(status: 'Creating Product ...');
  //   try {
  //     Map<String, dynamic> product = {
  //       'productName': nameController.text,
  //       'productCategoryId': categoryController.text,
  //       'productSKU': skuController.text,
  //       'productStock': int.parse(stockController.text),
  //       'productRegularPrice': double.parse(regularPriceController.text),
  //       // 'productMemberPrice': double.parse(memberPriceController.text),
  //     };
  //     if (descriptionController.text.isNotEmpty) {
  //       product.addAll({'productDescription': descriptionController.text});
  //     }
  //     await DBService.db
  //         .collection(storesRef)
  //         .doc(dataC.store.value.storeId)
  //         .collection(productsRef)
  //         .add(product)
  //         .then((productData) async {
  //       if (imagePath != '') {
  //         String imagesFile = DateTime.now().microsecondsSinceEpoch.toString();
  //         Reference referenceRoot = FirebaseStorage.instance.ref();
  //         Reference referenceDirImages = referenceRoot
  //             .child("store/${dataC.store.value.storeId}/products");
  //         Reference referenceImageUpload = referenceDirImages.child(imagesFile);
  //         await referenceImageUpload.putFile(File(imagePath));
  //         String imageUrl = await referenceImageUpload.getDownloadURL();
  //         await DBService.db
  //             .collection(storesRef)
  //             .doc(dataC.store.value.storeId)
  //             .collection(productsRef)
  //             .doc(productData.id)
  //             .update({'productImage': imageUrl});
  //       }
  //       if (hasVariant.isTrue) {
  //         for (var variant in variantForms) {
  //           await DBService.db
  //               .collection(storesRef)
  //               .doc(dataC.store.value.storeId)
  //               .collection(productsRef)
  //               .doc(productData.id)
  //               .collection(variantsRef)
  //               .add({
  //             'variantName': variant.value.nameController.text,
  //             'variantRegularPrice':
  //                 double.parse(variant.value.regularPriceController.text),
  //             'variantMemberPrice':
  //                 double.parse(variant.value.memberPriceController.text),
  //             'variantStock': int.parse(variant.value.stockController.text),
  //           });
  //         }
  //       }
  //     });
  //     await dataC.getProducts();
  //     endLoading();
  //     Get.back();
  //     EasyLoading.showSuccess('New Product Created!');
  //     clear();
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e.toString());
  //     }
  //     endLoading().then(
  //       (value) => showAlert(
  //         context: context,
  //         text: 'Error While Creating Product!',
  //         type: QuickAlertType.error,
  //       ),
  //     );
  //   }
  // }
}
