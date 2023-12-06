import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/data/models/role_model.dart';
import 'package:smart_manager/app/modules/user/user_management/modules/role/controllers/role_controller.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class EditRole extends GetView<RoleController> {
  const EditRole({super.key});

  @override
  Widget build(BuildContext context) {
    final RoleModel role = Get.arguments;
    controller.statusController.text =
        role.active == true ? 'Active' : 'Inactive';
    controller.roleName.text = role.name;
    controller.roleDescription.text = role.description ?? '';
    final GlobalKey<FormState> editRoleKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User Role'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: editRoleKey,
            child: Column(
              children: [
                CustomTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Role name cannot empty!\n';
                      }
                      return null;
                    },
                    controller: controller.roleName,
                    title: 'Role Name',
                    hintText: 'Enter role name',
                    isMandatory: true),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTextField(
                    controller: controller.roleDescription,
                    title: 'Role Description',
                    hintText: 'Enter role description'),
                const SizedBox(
                  height: 16.0,
                ),
                CustomDropdownField(
                  items: controller.statusList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (p0) {
                    controller.statusController.text = p0;
                  },
                  value: controller.statusController.text,
                  controller: controller.statusController,
                  title: 'Status',
                  hintText: 'Select status',
                  validator: (v) {
                    String? value = v;
                    if (value == null) {
                      return 'Status cannot empty\n';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        border: Border.all(color: grey2, width: 1)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          "Permission",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        GetBuilder<RoleController>(builder: (controller) {
                          return Column(
                            children: controller.permissionType
                                .map((permission) => ExpansionTile(
                                      title: Text(
                                        permission.values.first,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      initiallyExpanded: true,
                                      tilePadding: EdgeInsets.zero,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CheckboxListTile(
                                                contentPadding: EdgeInsets.zero,
                                                value: controller.permissions
                                                    .firstWhere((element) =>
                                                        element.keys.first ==
                                                        permission.keys.first)
                                                    .values
                                                    .first['view'],
                                                onChanged: (value) {
                                                  controller
                                                      .checklistPermission(
                                                          modulName: permission
                                                              .keys.first,
                                                          permission: "view");
                                                },
                                                title: Text("View",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!),
                                              ),
                                            ),
                                            Expanded(
                                              child: CheckboxListTile(
                                                contentPadding: EdgeInsets.zero,
                                                value: controller.permissions
                                                    .firstWhere((element) =>
                                                        element.keys.first ==
                                                        permission.keys.first)
                                                    .values
                                                    .first['add'],
                                                onChanged: (value) {
                                                  controller
                                                      .checklistPermission(
                                                          modulName: permission
                                                              .keys.first,
                                                          permission: "add");
                                                },
                                                title: Text("Add",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CheckboxListTile(
                                                contentPadding: EdgeInsets.zero,
                                                value: controller.permissions
                                                    .firstWhere((element) =>
                                                        element.keys.first ==
                                                        permission.keys.first)
                                                    .values
                                                    .first['edit'],
                                                onChanged: (value) {
                                                  controller
                                                      .checklistPermission(
                                                          modulName: permission
                                                              .keys.first,
                                                          permission: "edit");
                                                },
                                                title: Text("Edit",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!),
                                              ),
                                            ),
                                            Expanded(
                                              child: CheckboxListTile(
                                                contentPadding: EdgeInsets.zero,
                                                value: controller.permissions
                                                    .firstWhere((element) =>
                                                        element.keys.first ==
                                                        permission.keys.first)
                                                    .values
                                                    .first['delete'],
                                                onChanged: (value) {
                                                  controller
                                                      .checklistPermission(
                                                          modulName: permission
                                                              .keys.first,
                                                          permission: "delete");
                                                },
                                                title: Text("Delete",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ))
                                .toList(),
                          );
                        }),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -5),
              color: grey3,
              blurRadius: 4,
            )
          ],
        ),
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        child: CustomButton(
          onPressed: () {
            if (editRoleKey.currentState!.validate()) {
              // log("Name : ${controller.roleName.text}");
              // log("Description : ${controller.roleDescription.text}");
              // log("Active : ${controller.statusController.text}");
              // log("Permissions : ${controller.permissions}");
              controller.editRole(context, role.id);
            }
          },
          text: 'Save',
        ),
      ),
    );
  }
}
