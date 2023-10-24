import 'package:get/get.dart';
import 'package:smart_manager/app/controllers/auth_controller.dart';
import 'package:smart_manager/app/controllers/data_controller.dart';

class HomeController extends GetxController {
  final authC = Get.find<AuthController>();
  final dataC = Get.find<DataController>();
}
