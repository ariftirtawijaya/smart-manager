import 'package:get/get.dart';

import '../controllers/users_admin_controller.dart';

class UsersAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsersAdminController>(
      () => UsersAdminController(),
    );
  }
}
