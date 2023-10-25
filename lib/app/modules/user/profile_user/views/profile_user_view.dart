import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_user_controller.dart';

class ProfileUserView extends GetView<ProfileUserController> {
  const ProfileUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileUserView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProfileUserView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
