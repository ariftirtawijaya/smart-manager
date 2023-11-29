import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:smart_manager/app/controllers/data_controller.dart';
import 'package:smart_manager/app/data/models/role_model.dart';

class RoleController extends GetxController {
  final dataC = Get.find<DataController>();
  var logger = Logger();
  var listSearch = RxList<RoleModel>([]);
  var keyword = ''.obs;
  final TextEditingController searchC = TextEditingController();
  void changeKeyword() {
    keyword.value = searchC.text;
  }

  void clearSearch() {
    listSearch.clear();
    searchC.clear();
    keyword.value = '';
  }

  @override
  void onInit() {
    debounce(
      time: const Duration(seconds: 1),
      keyword,
      (callback) {
        listSearch.clear();
        searchRole(searchC.text);
      },
    );
    super.onInit();
  }

  searchRole(String value) {
    if (value.isEmpty) {
      listSearch.clear();
    } else {
      listSearch.value = dataC.roles
          .where((role) =>
              role.toString().toLowerCase().contains(value.toLowerCase()) ||
              role.toString().toLowerCase().startsWith(value.toLowerCase()))
          .toList();
    }
  }

  var permissions = RxList<Map<String, Map<String, bool>>>([]);

  void checklistPermission(
      {required String modulName, required String permission}) {
    if (permission != 'view') {
      if (permissions
              .firstWhere((element) => element.keys.first == modulName)
              .values
              .first[permission] ==
          false) {
        permissions
            .firstWhere((element) => element.keys.first == modulName)
            .values
            .first['view'] = true;
      }
    } else {
      if (permissions
              .firstWhere((element) => element.keys.first == modulName)
              .values
              .first[permission] ==
          true) {
        permissions
            .firstWhere((element) => element.keys.first == modulName)
            .values
            .first['add'] = false;
        permissions
            .firstWhere((element) => element.keys.first == modulName)
            .values
            .first['edit'] = false;
        permissions
            .firstWhere((element) => element.keys.first == modulName)
            .values
            .first['delete'] = false;
      }
    }
    if (permissions
            .firstWhere((element) => element.keys.first == modulName)
            .values
            .first[permission] ==
        true) {
      permissions
          .firstWhere((element) => element.keys.first == modulName)
          .values
          .first[permission] = false;
    } else {
      permissions
          .firstWhere((element) => element.keys.first == modulName)
          .values
          .first[permission] = true;
    }
    update();
  }

  void generatePermissions() {
    permissions.clear();
    for (var i = 0; i < permissionType.length; i++) {
      var permissionName = permissionType[i];
      permissions.add({
        permissionName.keys.first: {
          "add": false,
          "view": false,
          "edit": false,
          "delete": false
        }
      });
    }
  }

  List<Map<String, String>> permissionType = [
    {"product": "Product"},
    {"category": "Category"},
    {"employee": "Employee"},
    {"payment": "Payment Method"},
    {"customer": "Customer"},
    {"order": "Order"},
    {"pre_order": "Pre Order"},
    {"history": "History Transaction"},
    {"report": "Report"},
    {"roles": "Roles"},
    {"inventory": "Inventory"},
    {"return": "Return"},
    {"store_settings": "Store Settings"},
  ];
}
