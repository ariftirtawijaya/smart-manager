import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:smart_manager/app/constant/app_colors.dart';
import 'package:smart_manager/app/constant/app_strings.dart';
import 'package:smart_manager/app/controllers/auth_controller.dart';
import 'package:smart_manager/app/controllers/data_controller.dart';
import 'package:smart_manager/app/data/models/category_model.dart';
import 'package:smart_manager/app/data/services/db_service.dart';
import 'package:smart_manager/app/utils/functions/reusable_functions.dart';

class CategoryController extends GetxController {
  final authC = Get.find<AuthController>();
  final dataC = Get.find<DataController>();
  var logger = Logger();
  var listSearchCategory = RxList<CategoryModel>([]);
  var keywordCategory = ''.obs;
  RxBool isImageNull = false.obs;

  final TextEditingController searchCategoryC = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  void clear() {
    nameController.clear();
    imagePath = '';
    isImageNull.value = false;
  }

  void changeKeyword() {
    keywordCategory.value = searchCategoryC.text;
    update();
  }

  @override
  void onInit() {
    debounce(
      time: const Duration(seconds: 1),
      keywordCategory,
      (callback) {
        listSearchCategory.clear();
        searchCategory(searchCategoryC.text);
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
          .doc(dataC.store.value.id)
          .collection(categoriesRef)
          .add({
        'categoryName': nameController.text,
      }).then((categoryData) async {
        if (imagePath != '') {
          String imagesFile = DateTime.now().microsecondsSinceEpoch.toString();
          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceDirImages =
              referenceRoot.child("store/${dataC.store.value.id}/categories");
          Reference referenceImageUpload = referenceDirImages.child(imagesFile);
          await referenceImageUpload.putFile(File(imagePath));
          String imageUrl = await referenceImageUpload.getDownloadURL();
          await DBService.db
              .collection(storesRef)
              .doc(dataC.store.value.id)
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
      logger.e(e.toString());

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
          .doc(dataC.store.value.id)
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
          Reference referenceDirImages =
              referenceRoot.child("store/${dataC.store.value.id}/categories");
          Reference referenceImageUpload = referenceDirImages.child(imagesFile);
          await referenceImageUpload.putFile(File(imagePath));
          String imageUrl = await referenceImageUpload.getDownloadURL();
          await DBService.db
              .collection(storesRef)
              .doc(dataC.store.value.id)
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
      logger.e(e.toString());
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
                .doc(dataC.store.value.id)
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
            logger.e(e.toString());
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
}
