import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smart_manager/app/utils/widgets/custom_user_page.dart';

import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomUserPage(
      title: 'Report',
      body: const Center(
        child: Text('Report Will Be Here'),
      ),
    );
  }
}
