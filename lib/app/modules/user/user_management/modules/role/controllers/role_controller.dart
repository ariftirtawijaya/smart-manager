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

  void assignPermission(List<Map<PermissionType, Permission>> permission) {
    permissions.clear();
    for (var element in permission) {
      String permissionKey =
          element.keys.first.toString().replaceAll("PermissionType.", "");
      String permissionName = permissionType
          .firstWhere((type) => type.keys.first == permissionKey)
          .values
          .first;
      permissions.add({
        permissionKey: {
          "add": element.values.first.add,
          "view": element.values.first.view,
          "edit": element.values.first.edit,
          "delete": element.values.first.delete,
        }
      });
    }
  }

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
    {"paymentMethod": "Payment Method"},
    {"customer": "Customer"},
    {"order": "Order"},
    {"preOrder": "Pre Order"},
    {"historyTransaction": "History Transaction"},
    {"report": "Report"},
    {"roles": "Roles"},
    {"inventory": "Inventory"},
    {"returnPermission": "Return"},
    {"storeSettings": "Store Settings"},
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
          text: 'Error While Creating Role',
          type: QuickAlertType.error,
        ),
      );
    }
  }

  Future<void> editRole(BuildContext context, String roleId) async {
    showLoading(status: 'Editing Role ...');
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
          .doc(roleId)
          .set(data)
          .then((result) async {
        await dataC.getRoles();
        endLoading();
        Get.back();
        EasyLoading.showSuccess('Role Updated!');
        clear();
      });
    } catch (e) {
      logger.e(e.toString());
      endLoading().then(
        (value) => showAlert(
          context: context,
          text: 'Error While Updating Role',
          type: QuickAlertType.error,
        ),
      );
    }
  }

  Future<void> toggleRoleStatus(
      BuildContext context, bool currentStatus, String roleId) async {
    showAlert(
      context: context,
      type: QuickAlertType.confirm,
      text:
          'Do you want to ${currentStatus == false ? 'activate' : 'deactivate'} this role?',
      onConfirmBtnTap: () async {
        showLoading(
            status:
                '${currentStatus == false ? 'Activating' : 'Deactivating'} Role ...');
        try {
          await DBService.db
              .collection(storesRef)
              .doc(dataC.store.value.id)
              .collection(rolesRef)
              .doc(roleId)
              .update({'active': currentStatus == false ? true : false}).then(
                  (result) async {
            await dataC.getRoles();
            endLoading();
            Get.back();
            EasyLoading.showSuccess('Role Updated!');
            clear();
          });
        } catch (e) {
          logger.e(e.toString());
          endLoading().then(
            (value) => showAlert(
              context: context,
              text: 'Error While Updating Role',
              type: QuickAlertType.error,
            ),
          );
        }
      },
    );
  }

  Future<void> deleteRole(
      BuildContext context, String roleId) async {
    showAlert(
      context: context,
      type: QuickAlertType.confirm,
      text:
      'Do you want to delete this role?',
      onConfirmBtnTap: () async {
        showLoading(
            status:
            'Deleting Role ...');
        try {
          await DBService.db
              .collection(storesRef)
              .doc(dataC.store.value.id)
              .collection(rolesRef)
              .doc(roleId)
              .delete().then(
                  (result) async {
                await dataC.getRoles();
                endLoading();
                Get.back();
                EasyLoading.showSuccess('Role Deleted!');
                clear();
              });
        } catch (e) {
          logger.e(e.toString());
          endLoading().then(
                (value) => showAlert(
              context: context,
              text: 'Error While Deleting Role',
              type: QuickAlertType.error,
            ),
          );
        }
      },
    );
  }

  void clear() {
    roleName.clear();
    roleDescription.clear();
    statusController.text = 'Active';
  }
}
