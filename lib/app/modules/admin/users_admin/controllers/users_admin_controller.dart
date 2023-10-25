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
import 'package:smart_manager/app/controllers/data_controller.dart';
import 'package:smart_manager/app/data/models/user_model.dart';
import 'package:smart_manager/app/data/services/db_service.dart';
import 'package:smart_manager/app/utils/functions/reusable_functions.dart';

class UsersAdminController extends GetxController {
  final dataC = Get.find<DataController>();
  var listSearch = RxList<UserModel>([]);

  TextEditingController nameController = TextEditingController();
  TextEditingController loginNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isHidden = true.obs;

  void clear() {
    imagePath = '';
    nameController.clear();
    loginNumberController.clear();
    emailController.clear();
    phoneController.clear();
    addressController.clear();
    passwordController.clear();
  }

  var keyword = ''.obs;
  final TextEditingController searchC = TextEditingController();
  void changeKeyword() {
    keyword.value = searchC.text;
  }

  @override
  void onInit() {
    debounce(
      time: const Duration(seconds: 1),
      keyword,
      (callback) {
        listSearch.clear();
        searchUsers(searchC.text);
      },
    );
    super.onInit();
  }

  searchUsers(String value) {
    print(value.isEmpty);
    if (value.isEmpty) {
      listSearch.clear();
    } else {
      listSearch.value = dataC.users
          .where((user) =>
              user.toString().toLowerCase().contains(value.toLowerCase()) ||
              user.toString().toLowerCase().startsWith(value.toLowerCase()))
          .toList();
    }
    // update();
  }

  String imagePath = '';
  final picker = ImagePicker();

  void pickImage(BuildContext context) async {
    try {
      imagePath = '';
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imagePath = image.path;
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: imagePath,
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

  Future<void> createUser(BuildContext context) async {
    showLoading(status: 'Creating User ...');
    try {
      await DBService.auth
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((result) async {
        await DBService.insert(
          into: usersRef,
          name: result.user!.uid,
          data: {
            'uid': result.user!.uid,
            'name': nameController.text,
            'email': emailController.text,
            'active': true,
            'loginNumber': loginNumberController.text,
            'phone': phoneController.text,
            'role': 'user',
          },
        ).then((_) async {
          if (imagePath != '') {
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
              name: result.user!.uid,
              data: {'profilePic': imageUrl},
            );
          }
          await DBService.auth.signOut();
          var adminData = DBService.getLocalData(key: 'userCredentials');
          await DBService.login(
              email: adminData['email'], password: adminData['password']);
          await dataC.getUsers();
          endLoading();
          Get.back();
          EasyLoading.showSuccess('New User Created!');
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
          text: 'Error While Creating User',
          type: QuickAlertType.error,
        ),
      );
    }
  }
}
