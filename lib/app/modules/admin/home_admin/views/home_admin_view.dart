import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

import '../controllers/home_admin_controller.dart';

class HomeAdminView extends GetView<HomeAdminController> {
  const HomeAdminView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.authC.currentUser.value.role == 'admin'
            ? 'Admin Panel'
            : 'Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: GridView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            children: [
              Obx(() {
                return CustomCard(
                  title: 'Total Users',
                  value: controller.dataC.users.length,
                  onTap: () {},
                  icon: FontAwesomeIcons.users,
                );
              }),
              CustomCard(
                title: 'Total Store',
                value: controller.dataC.stores.length,
                onTap: () {},
                icon: FontAwesomeIcons.store,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
