import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/controllers/data_controller.dart';
import 'package:smart_manager/app/data/models/user_model.dart';
import 'package:smart_manager/app/data/services/db_service.dart';
import 'package:smart_manager/app/routes/app_pages.dart';
import 'package:smart_manager/app/utils/functions/reusable_functions.dart';

class AuthController extends GetxController {
  var logger = Logger();
  Rx<UserModel> currentUser = UserModel().obs;
  final dataC = Get.find<DataController>();
  TextEditingController loginNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void clear() {
    emailController.clear();
    loginNumberController.clear();
    passwordController.clear();
  }

  Future<void> getMe() async {
    await DBService.getDocument(from: usersRef, doc: currentUser.value.uid!)
        .then((value) {
      currentUser.value = UserModel.fromSnapshot(value);
      update();
    });
  }

  Future<void> checkLoginNumber(BuildContext context) async {
    showLoading();
    try {
      Map<String, dynamic> data = {};
      await DBService.getCollections(
        from: usersRef,
        where: 'loginNumber',
        isEqualTo: loginNumberController.text,
      ).then((userCollection) {
        if (userCollection.docs.isNotEmpty) {
          for (var element in userCollection.docs) {
            logger.i(element.data());
            data = element.data();
          }
          login(data, context);
        } else {
          endLoading().then(
            (value) => showAlert(
              context: context,
              type: QuickAlertType.error,
              text: "No User Found!",
            ),
          );
        }
      });
    } catch (e) {
      endLoading().then(
        (value) => showAlert(
          context: context,
          type: QuickAlertType.error,
          text: e.toString(),
        ),
      );
    }
  }

  Future<void> login(
      Map<String, dynamic> userData, BuildContext context) async {
    try {
      await DBService.login(
              email: userData['email'], password: passwordController.text)
          .then(
        (authResult) async {
          currentUser.value = UserModel.fromMap(userData);
          await DBService.saveToLocal(
            key: 'userCredentials',
            value: {
              'email': userData['email'],
              'password': passwordController.text,
            },
          );
          endLoading();
          Get.offAllNamed(Routes.LOADING);
          clear();
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        endLoading().then(
          (value) => showAlert(
            context: context,
            type: QuickAlertType.error,
            text: "Invalid Login Credentials!",
          ),
        );
      } else if (e.code == 'too-many-requests') {
        endLoading().then(
          (value) => showAlert(
            context: context,
            type: QuickAlertType.error,
            text: "Too Many Request!",
          ),
        );
      } else {
        endLoading().then(
          (value) => showAlert(
            context: context,
            type: QuickAlertType.error,
            text: e.code.toString(),
          ),
        );
      }
      logger.e(e.code);
    } catch (e) {
      endLoading().then(
        (value) => showAlert(
          context: context,
          type: QuickAlertType.error,
          text: e.toString(),
        ),
      );
      logger.e(e);
    }
  }

  Future<void> signOut(BuildContext context) async {
    showAlert(
      context: context,
      type: QuickAlertType.confirm,
      text: "Are you sure want to end this session?",
      confirmText: 'Logout',
      onConfirmBtnTap: () async {
        showLoading();
        currentUser.value = UserModel();
        dataC.clear();
        Get.back();
        await DBService.removeLocalData(key: 'userCredentials');
        await DBService.auth.signOut();
        Get.offAllNamed(Routes.LOGIN);
        endLoading();
      },
    );
  }

  Future<void> resetPassword(BuildContext context) async {
    showLoading();
    try {
      Map<String, dynamic> data = {};
      await DBService.getCollections(
              from: usersRef, where: 'email', isEqualTo: emailController.text)
          .then((userCollection) async {
        if (userCollection.docs.isNotEmpty) {
          for (var element in userCollection.docs) {
            logger.i(element.data());
            data = element.data();
          }
          if (data['role'] == 'cashier') {
            endLoading().then(
              (value) => showAlert(
                context: context,
                type: QuickAlertType.error,
                text:
                    "You cannot reset your password, please contact your supervisor !",
              ),
            );
          } else {
            await DBService.auth
                .sendPasswordResetEmail(email: emailController.text)
                .then(
                  (value) => endLoading().then(
                    (value) => showAlert(
                      context: context,
                      type: QuickAlertType.success,
                      text:
                          "An email has been sent for resetting your password.",
                      onConfirmBtnTap: () {
                        clear();
                        Get.offAllNamed(Routes.LOGIN);
                      },
                    ),
                  ),
                );
          }
        } else {
          endLoading().then(
            (value) => showAlert(
              context: context,
              type: QuickAlertType.error,
              text: "No User Found!",
            ),
          );
        }
      });
    } catch (e) {
      endLoading().then(
        (value) => showAlert(
          context: context,
          type: QuickAlertType.error,
          text: e.toString(),
        ),
      );
    }
  }
}
