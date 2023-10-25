import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

import '../controllers/profile_admin_controller.dart';

class ProfileAdminView extends GetView<ProfileAdminController> {
  const ProfileAdminView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
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
