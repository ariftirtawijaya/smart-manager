import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smart_manager/app/utils/widgets/custom_user_page.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomUserPage(
      title: 'Profile',
      body: const Center(
        child: Text('Profile Will Be Here'),
      ),
    );
  }
}
