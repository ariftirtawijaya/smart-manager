import 'package:get/get.dart';
import 'package:smart_manager/app/modules/home/controllers/home_controller.dart';
import 'package:smart_manager/app/modules/profile/controllers/profile_controller.dart';
import 'package:smart_manager/app/modules/users/controllers/users_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(UsersController());
    Get.put(HomeController());
    Get.put(ProfileController());
  }
}
