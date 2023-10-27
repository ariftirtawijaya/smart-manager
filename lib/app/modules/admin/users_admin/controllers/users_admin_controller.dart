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
  TextEditingController genderController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  RxBool isHidden = true.obs;

  List<String> genderList = ['Male', 'Female'];
  List<String> statusList = ['Active', 'Inactive'];

  void clear() {
    statusController.clear();
    genderController.clear();
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

  Future<void> deleteUser(
      BuildContext context, UserModel user, bool fromDetail) async {
    endLoading().then(
      (value) => showAlert(
        context: context,
        text:
            'Are you sure want to delete this user including store and employee ?\n\nThis action canot be undone!',
        type: QuickAlertType.confirm,
        confirmText: 'Delete User',
        onConfirmBtnTap: () async {
          try {
            showLoading();
            final response = await DBService.deleteAccount(uid: user.uid!);
            if (response.statusCode == 200) {
              if (user.profilePic != null) {
                final storageRef =
                    FirebaseStorage.instance.refFromURL(user.profilePic!);
                await storageRef.delete();
              }
              await DBService.getCollections(
                      from: storesRef, where: 'userId', isEqualTo: user.uid)
                  .then((result) async {
                if (result.docs.isNotEmpty) {
                  await DBService.delete(
                      from: storesRef, name: result.docs.first.id);
                  await DBService.deleteStoreFolder(
                      storeId: result.docs.first.id);
                }
              }).then((_) async {
                await DBService.delete(from: usersRef, name: user.uid!)
                    .then((value) async {
                  await dataC.getUsers();
                  endLoading();
                  Get.back();
                  if (fromDetail == true) {
                    Get.back();
                  }
                  EasyLoading.showSuccess('User Successfully Deleted!');
                });
              });
            } else {
              endLoading().then(
                (value) => showAlert(
                  context: context,
                  text: 'Error While Deleting User',
                  type: QuickAlertType.error,
                ),
              );
            }
          } catch (e) {
            if (kDebugMode) {
              print(e.toString());
            }
            endLoading().then(
              (value) => showAlert(
                context: context,
                text: 'Error While Deleting User',
                type: QuickAlertType.error,
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> updateUser(BuildContext context, UserModel user) async {
    showLoading(status: 'Updating User ...');
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
              'active': statusController.text == 'Active',
              'gender': genderController.text,
              'address': addressController.text,
              'loginNumber': loginNumberController.text,
              'phone': phoneController.text,
              'role': 'user',
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
            await dataC.getUsers();
            endLoading();
            Get.back();
            EasyLoading.showSuccess('User Updated!');
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
            text: 'Error While Updating User',
            type: QuickAlertType.error,
          ),
        );
      }
    }
  }

  Future<void> createUser(BuildContext context) async {
    showLoading(status: 'Creating User ...');
    List<String> isValid = await checkField();
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
        await DBService.createUser(
                email: emailController.text, password: passwordController.text)
            .then((result) async {
          String uid = result.body;
          await DBService.insert(
            into: usersRef,
            name: uid,
            data: {
              'uid': uid,
              'name': nameController.text,
              'email': emailController.text,
              'active': statusController.text == 'Active',
              'gender': genderController.text,
              'address': addressController.text,
              'loginNumber': loginNumberController.text,
              'phone': phoneController.text,
              'role': 'user',
            },
          ).then((_) async {
            if (imagePath != '') {
              String imagesFile =
                  DateTime.now().microsecondsSinceEpoch.toString();
              Reference referenceRoot = FirebaseStorage.instance.ref();
              Reference referenceDirImages =
                  referenceRoot.child("profile/${result.body}");
              Reference referenceImageUpload =
                  referenceDirImages.child(imagesFile);
              await referenceImageUpload.putFile(File(imagePath));
              String imageUrl = await referenceImageUpload.getDownloadURL();
              await DBService.update(
                from: usersRef,
                name: uid,
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

  Future<List<String>> checkField() async {
    List<String> message = [];
    bool isLoginNumberValid =
        await check(field: 'loginNumber', data: loginNumberController.text);
    bool isEmailValid = await check(field: 'email', data: emailController.text);
    bool isPhoneValid = await check(field: 'phone', data: phoneController.text);
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

  Future<bool> check({required String field, required String data}) async {
    bool available = false;
    await DBService.getCollections(
            from: usersRef, where: field, isEqualTo: data)
        .then((result) {
      if (result.docs.isEmpty) {
        available = true;
      }
    });
    return available;
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
}
