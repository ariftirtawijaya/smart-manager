import 'package:get/get.dart';
import 'package:smart_manager/app/modules/user/user_management/modules/customer/controllers/customer_controller.dart';
import 'package:smart_manager/app/modules/user/user_management/modules/employee/controllers/employee_controller.dart';
import 'package:smart_manager/app/modules/user/user_management/modules/role/controllers/role_controller.dart';

import '../controllers/user_management_controller.dart';

class UserManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserManagementController());
    Get.put(RoleController());
    Get.put(EmployeeController());
    Get.put(CustomerController());
  }
}
