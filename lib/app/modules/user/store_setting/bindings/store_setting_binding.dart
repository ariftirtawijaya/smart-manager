import 'package:get/get.dart';

import '../controllers/store_setting_controller.dart';

class StoreSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      StoreSettingController(),
    );
  }
}
