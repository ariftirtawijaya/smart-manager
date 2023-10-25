import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

import '../controllers/dashboard_user_controller.dart';

class DashboardUserView extends GetView<DashboardUserController> {
  const DashboardUserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashboardUserView'),
        centerTitle: true,
      ),
      body: Center(
        child: CustomButton(
          onPressed: () async {
            await controller.authC.signOut(context);
          },
          text: 'Logout',
        ),
      ),
    );
  }
}
