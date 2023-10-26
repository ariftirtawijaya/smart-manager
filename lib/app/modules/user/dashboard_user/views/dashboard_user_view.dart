import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/utils/widgets/custom_user_page.dart';

import '../controllers/dashboard_user_controller.dart';

class DashboardUserView extends GetView<DashboardUserController> {
  const DashboardUserView({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomUserPage(
      title: controller.dataC.store.value.storeName!,
      body: Center(
        child: Text(controller.text),
      ),
    );
  }
}
