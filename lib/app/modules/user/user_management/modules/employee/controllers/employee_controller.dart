import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:smart_manager/app/controllers/data_controller.dart';
import 'package:smart_manager/app/data/models/user_model.dart';

class EmployeeController extends GetxController {
  final dataC = Get.find<DataController>();

  var logger = Logger();
  var listSearch = RxList<UserModel>([]);
  var keyword = ''.obs;
  final TextEditingController searchC = TextEditingController();
  void changeKeyword() {
    keyword.value = searchC.text;
  }

  @override
  void onInit() {
    debounce(
      time: const Duration(seconds: 1),
      keyword,
      (callback) {
        listSearch.clear();
        searchEmployee(searchC.text);
      },
    );
    super.onInit();
  }

  searchEmployee(String value) {
    if (value.isEmpty) {
      listSearch.clear();
    } else {
      listSearch.value = dataC.employees
          .where((employee) =>
              employee.toString().toLowerCase().contains(value.toLowerCase()) ||
              employee.toString().toLowerCase().startsWith(value.toLowerCase()))
          .toList();
    }
  }
}
