import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smart_manager/app/utils/widgets/custom_user_page.dart';

import '../controllers/store_setting_controller.dart';

class StoreSettingView extends GetView<StoreSettingController> {
  const StoreSettingView({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomUserPage(
      title: 'Store Setting',
      body: const Center(
        child: Text('Store Setting Will Be Here'),
      ),
    );
  }
}
