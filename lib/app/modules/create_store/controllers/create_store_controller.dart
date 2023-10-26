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
import 'package:smart_manager/app/data/services/db_service.dart';
import 'package:smart_manager/app/routes/app_pages.dart';
import 'package:smart_manager/app/utils/functions/reusable_functions.dart';

class CreateStoreController extends GetxController {
  final authC = Get.find<AuthController>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String imagePath = '';
  final picker = ImagePicker();

  void clear() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    addressController.clear();
  }

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

  Future<void> createStore(BuildContext context) async {
    showLoading(status: 'Creating Store ...');
    try {
      await DBService.add(
        into: storesRef,
        data: {
          'userId': authC.currentUser.value.uid!,
          'storeName': nameController.text,
          'storeEmail': emailController.text,
          'storeAddress': addressController.text,
          'storePhone': phoneController.text,
        },
      ).then((storeData) async {
        await DBService.update(
          from: storesRef,
          name: storeData.id,
          data: {'storeId': storeData.id},
        );
        if (imagePath != '') {
          String imagesFile = DateTime.now().microsecondsSinceEpoch.toString();
          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceDirImages =
              referenceRoot.child("store/${storeData.id}/logo");
          Reference referenceImageUpload = referenceDirImages.child(imagesFile);
          await referenceImageUpload.putFile(File(imagePath));
          String imageUrl = await referenceImageUpload.getDownloadURL();
          await DBService.update(
            from: storesRef,
            name: storeData.id,
            data: {'storeLogo': imageUrl},
          );
        }
        endLoading();
        EasyLoading.showSuccess('Store Successfully Created!');
        clear();
        Get.offAllNamed(Routes.LOADING);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      endLoading().then(
        (value) => showAlert(
          context: context,
          text: 'Error While Creating Store',
          type: QuickAlertType.error,
        ),
      );
    }
  }
}
