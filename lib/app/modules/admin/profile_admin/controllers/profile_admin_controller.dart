import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/controllers/auth_controller.dart';
import 'package:smart_manager/app/data/models/user_model.dart';
import 'package:smart_manager/app/data/services/db_service.dart';
import 'package:smart_manager/app/utils/functions/reusable_functions.dart';

class ProfileAdminController extends GetxController {
  final authC = Get.find<AuthController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController loginNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isHidden = true.obs;

  void clear() {
    imagePath = '';
    nameController.clear();
    loginNumberController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
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
          compressFormat: ImageCompressFormat.png,
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

  Future<void> updateProfile(BuildContext context, UserModel user) async {
    showLoading(status: 'Updating Profile ...');
    List<String> isValid = await checkFieldUpdate(user.uid!);
    if (isValid.isNotEmpty) {
      String message = isValid
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll(',', '\n');
      endLoading().then(
        (value) => showAlert(
          context: context,
          text: message,
          type: QuickAlertType.error,
        ),
      );
    } else {
      try {
        await DBService.updateUserCredentials(
                uid: user.uid!,
                email: emailController.text,
                password: passwordController.text)
            .then((result) async {
          await DBService.update(
            from: usersRef,
            name: user.uid!,
            data: {
              'uid': user.uid,
              'name': nameController.text,
              'email': emailController.text,
              'loginNumber': loginNumberController.text,
              'phone': phoneController.text,
              'role': 'admin',
            },
          ).then((_) async {
            if (imagePath != '') {
              if (user.profilePic != null) {
                final storageRef =
                    FirebaseStorage.instance.refFromURL(user.profilePic!);
                await storageRef.delete();
              }
              String imagesFile =
                  DateTime.now().microsecondsSinceEpoch.toString();
              Reference referenceRoot = FirebaseStorage.instance.ref();
              Reference referenceDirImages = referenceRoot.child("profile");
              Reference referenceImageUpload =
                  referenceDirImages.child(imagesFile);
              await referenceImageUpload.putFile(File(imagePath));
              String imageUrl = await referenceImageUpload.getDownloadURL();
              await DBService.update(
                from: usersRef,
                name: user.uid!,
                data: {'profilePic': imageUrl},
              );
            }
            await authC.getMe();
            endLoading();
            Get.back();
            EasyLoading.showSuccess('Profile Updated!');
            clear();
          });
        });
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        endLoading().then(
          (value) => showAlert(
            context: context,
            text: 'Error While Updating Profile',
            type: QuickAlertType.error,
          ),
        );
      }
    }
  }

  Future<List<String>> checkFieldUpdate(String uid) async {
    List<String> message = [];
    bool isLoginNumberValid = await checkUpdate(
        uid: uid, field: 'loginNumber', data: loginNumberController.text);
    bool isEmailValid =
        await checkUpdate(uid: uid, field: 'email', data: emailController.text);
    bool isPhoneValid =
        await checkUpdate(uid: uid, field: 'phone', data: phoneController.text);
    if (!isLoginNumberValid) {
      message.add('Login Number already exist');
    }
    if (!isEmailValid) {
      message.add('Email aready exist');
    }
    if (!isPhoneValid) {
      message.add('Phone Number already exist');
    }
    return message;
  }

  Future<bool> checkUpdate(
      {required String uid,
      required String field,
      required String data}) async {
    bool available = false;
    await DBService.getCollections(
            from: usersRef, where: field, isEqualTo: data)
        .then((result) {
      if (result.docs.isEmpty) {
        available = true;
      } else {
        for (var element in result.docs) {
          if (element.id == uid) {
            available = true;
          } else {
            available = false;
          }
        }
      }
    });
    return available;
  }

  Future<void> changeContent(
      {required BuildContext context,
      required String content,
      required String section}) async {
    showLoading();
    try {
      await DBService.update(
          from: settingsRef,
          name: section,
          data: {'content': content}).then((_) {
        update();
        endLoading().then((_) => showAlert(
              context: context,
              text: 'Content Updated Successfully',
              type: QuickAlertType.success,
            ));
      });
    } catch (e) {
      endLoading().then(
        (value) => showAlert(
          context: context,
          text: 'Error While Updating Profile',
          type: QuickAlertType.error,
        ),
      );
    }
  }
}
