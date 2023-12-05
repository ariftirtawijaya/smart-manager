import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quickalert/quickalert.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/controllers/data_controller.dart';
import 'package:smart_manager/app/data/models/role_model.dart';
import 'package:smart_manager/app/data/services/db_service.dart';
import 'package:smart_manager/app/utils/functions/reusable_functions.dart';

class RoleController extends GetxController {
  final dataC = Get.find<DataController>();
  var logger = Logger();
  var listSearch = RxList<RoleModel>([]);
  List<String> statusList = ['Active', 'Inactive'];

  var keyword = ''.obs;
  final TextEditingController searchC = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController roleName = TextEditingController();
  final TextEditingController roleDescription = TextEditingController();
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

  Future<void> createRole(BuildContext context) async {
    showLoading(status: 'Creating Role ...');
    try {
      Map<String, dynamic> data = {};
      if (roleDescription.text.isEmpty) {
        data = {
          'name': roleName.text,
          'active': statusController.text == 'Active' ? true : false,
          'permission': permissions
        };
      } else {
        data = {
          'name': roleName.text,
          'description': roleDescription.text,
          'active': statusController.text == 'Active' ? true : false,
          'permission': permissions
        };
      }

      await DBService.db
          .collection(storesRef)
          .doc(dataC.store.value.id)
          .collection(rolesRef)
          .add(data)
          .then((result) async {
        await dataC.getRoles();
        endLoading();
        Get.back();
        EasyLoading.showSuccess('New Role Created!');
        clear();
      });
    } catch (e) {
      logger.e(e.toString());
      endLoading().then(
        (value) => showAlert(
          context: context,
          text: 'Error While Creating User',
          type: QuickAlertType.error,
        ),
      );
    }
  }

  void clear() {
    roleName.clear();
    roleDescription.clear();
    statusController.text = 'Active';
  }
}
