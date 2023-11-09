import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smart_manager/app/utils/widgets/custom_user_page.dart';

import '../controllers/user_management_controller.dart';

class UserManagementView extends GetView<UserManagementController> {
  const UserManagementView({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomUserPage(
      title: 'User Management',
      body: const Center(
        child: Text('User Management Will Be Here'),
      ),
    );
  }
}
