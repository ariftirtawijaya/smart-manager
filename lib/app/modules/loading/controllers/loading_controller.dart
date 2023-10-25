import 'package:get/get.dart';
import 'package:smart_manager/app/controllers/auth_controller.dart';
import 'package:smart_manager/app/controllers/data_controller.dart';
import 'package:smart_manager/app/routes/app_pages.dart';

class LoadingController extends GetxController {
  final dataC = Get.find<DataController>();
  final authC = Get.find<AuthController>();

  @override
  void onInit() {
    dataC.getUsers().then((_) {
      if (authC.currentUser.value.role! == 'admin') {
        Get.offAllNamed(Routes.DASHBOARD_ADMIN);
      } else {
        Get.offAllNamed(Routes.DASHBOARD_USER);
      }
    });
    super.onInit();
  }
}
