import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/store_setting_controller.dart';

class StoreSettingView extends GetView<StoreSettingController> {
  const StoreSettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StoreSettingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StoreSettingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
