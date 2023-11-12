import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/customer_controller.dart';

class CustomerView extends GetView<CustomerController> {
  const CustomerView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'CustomerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
