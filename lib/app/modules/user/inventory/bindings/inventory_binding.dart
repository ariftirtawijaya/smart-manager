import 'package:get/get.dart';
import 'package:smart_manager/app/modules/user/inventory/modules/category/controllers/category_controller.dart';
import 'package:smart_manager/app/modules/user/inventory/modules/product/controllers/product_controller.dart';

import '../modules/inventory/controllers/inventory_controller.dart';

class InventoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InventoryController());
    Get.put(ProductController());
    Get.put(CategoryController());
  }
}
