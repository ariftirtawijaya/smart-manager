import 'package:get/get.dart';
import 'package:smart_manager/app/controllers/data_controller.dart';
import 'package:smart_manager/app/routes/app_pages.dart';

class LoadingController extends GetxController {
  final dataC = Get.find<DataController>();

  @override
  void onInit() {
    dataC.getUsers().then((_) => Get.offAllNamed(Routes.DASHBOARD));
    super.onInit();
  }
}
