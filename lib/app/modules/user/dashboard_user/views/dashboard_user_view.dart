import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/utils/widgets/custom_user_page.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

import '../controllers/dashboard_user_controller.dart';

class DashboardUserView extends GetView<DashboardUserController> {
  DashboardUserView({super.key});
  final GlobalKey<ScaffoldState> dashboardUserKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return CustomUserPage(
        title: controller.dataC.store.value.storeName!,
        body: Center(child: Text(controller.text)));
  }
}
