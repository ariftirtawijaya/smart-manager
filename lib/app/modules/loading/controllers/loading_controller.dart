import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/controllers/auth_controller.dart';
import 'package:smart_manager/app/controllers/data_controller.dart';
import 'package:smart_manager/app/data/services/db_service.dart';
import 'package:smart_manager/app/routes/app_pages.dart';

class LoadingController extends GetxController {
  final dataC = Get.find<DataController>();
  final authC = Get.find<AuthController>();

  @override
  void onInit() {
    dataC.getUsers().then((_) async {
      if (authC.currentUser.value.role! == 'admin') {
        await dataC
            .getStores()
            .then((value) => Get.offAllNamed(Routes.DASHBOARD_ADMIN));
      } else {
        dataC.getStore(authC.currentUser.value.uid!).then((_) async {
          // if (authC.currentUser.value.role! == 'admin') {
          // Get.offAllNamed(Routes.DASHBOARD_ADMIN);
          // } else {
          if (authC.currentUser.value.active!) {
            if (dataC.store.value.id != null) {
              await dataC.getRoles().then((_) async {
                await dataC.getCategories().then((_) async {
                  await dataC.getProducts().then((_) async {
                    await dataC.getVariantType().then((_) {
                      Get.offAllNamed(Routes.DASHBOARD_USER);
                    });
                  });
                });
              });
            } else {
              Get.offAllNamed(Routes.CREATE_STORE);
            }
          } else {
            EasyLoading.showError(
              'Your account is inactive!\nPlease contact our support.\n\nYou will be logged out in 5 seconds',
              duration: const Duration(seconds: 5),
              dismissOnTap: false,
              maskType: EasyLoadingMaskType.black,
            );
            Timer(const Duration(seconds: 5), () async {
              dataC.clear();
              await DBService.removeLocalData(key: 'userCredentials');
              await DBService.auth.signOut();
              Get.offAllNamed(Routes.LOGIN);
            });
          }
          // }
        });
      }
    });
    super.onInit();
  }
}
