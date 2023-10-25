import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_user_controller.dart';

class HomeUserView extends GetView<HomeUserController> {
  const HomeUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeUserView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HomeUserView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
