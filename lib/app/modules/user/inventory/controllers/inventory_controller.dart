import 'package:get/get.dart';
import 'package:smart_manager/app/controllers/auth_controller.dart';
import 'package:smart_manager/app/controllers/data_controller.dart';

class InventoryController extends GetxController {
  final authC = Get.find<AuthController>();
  final dataC = Get.find<DataController>();
  var tabIndex = 0;

  RxBool isLoading = false.obs;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  Future<void> addCategory() async {}
}
