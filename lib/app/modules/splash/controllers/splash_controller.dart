import 'dart:async';

import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/controllers/auth_controller.dart';
import 'package:smart_manager/app/data/models/user_model.dart';
import 'package:smart_manager/app/data/services/db_service.dart';
import 'package:smart_manager/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final authC = Get.find<AuthController>();
  RxString status = 'Checking Connection'.obs;

  @override
  void onReady() {
    Timer(
      const Duration(seconds: 2),
      () async {
        status.value = 'Authenticating';
        if (DBService.auth.currentUser == null) {
          Get.offAllNamed(Routes.LOGIN);
        } else {
          await DBService.getDocument(
                  from: usersRef, doc: DBService.auth.currentUser!.uid)
              .then((userDataFromDB) async {
            Map<String, dynamic> dataUser = {};
            dataUser.clear();
            dataUser.addAll(userDataFromDB.data() as Map<String, dynamic>);
            authC.currentUser.value = UserModel.fromMap(dataUser);
            Get.offAllNamed(Routes.LOADING);
          }).onError((error, stackTrace) {
            Get.offAllNamed(Routes.SPLASH);
          });
        }
      },
    );
    super.onReady();
  }
}
