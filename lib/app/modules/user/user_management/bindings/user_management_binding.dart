import 'package:get/get.dart';

import '../controllers/user_management_controller.dart';

class UserManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      UserManagementController(),
    );
  }
}
