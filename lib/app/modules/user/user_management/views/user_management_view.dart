import 'dart:developer';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_colors.dart';
import 'package:smart_manager/app/modules/user/user_management/modules/customer/views/customer_view.dart';
import 'package:smart_manager/app/modules/user/user_management/modules/employee/views/employee_view.dart';
import 'package:smart_manager/app/modules/user/user_management/modules/role/controllers/role_controller.dart';
import 'package:smart_manager/app/modules/user/user_management/modules/role/views/add_role.dart';
import 'package:smart_manager/app/modules/user/user_management/modules/role/views/role_view.dart';
import 'package:smart_manager/app/utils/widgets/custom_user_page.dart';

import '../controllers/user_management_controller.dart';

class UserManagementView extends GetView<UserManagementController> {
  const UserManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserManagementController>(builder: (controller) {
      return CustomUserPage(
        extendBody: true,
        title: controller.tabIndex == 0
            ? 'List Employee'
            : controller.tabIndex == 1
                ? 'List Customer'
                : 'Role Management',
        actions: controller.tabIndex == 0
            ? [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.userPlus,
                    size: 24.0,
                  ),
                ),
                const SizedBox(
                  width: 4.0,
                ),
              ]
            : controller.tabIndex == 1
                ? [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.userPlus,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                  ]
                : [
                    IconButton(
                      onPressed: () {
                        Get.find<RoleController>().clear();
                        Get.find<RoleController>().generatePermissions();
                        Get.to(() => const AddRole());
                      },
                      icon: const Icon(
                        FontAwesomeIcons.squarePlus,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                  ],
        body: Center(
          child: IndexedStack(
            index: controller.tabIndex,
            children: const [
              EmployeeView(),
              CustomerView(),
              RoleView(),
            ],
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomNavigationBar(
              borderRadius: const Radius.circular(16),
              selectedColor: primaryColor,
              unSelectedColor: grey1,
              strokeColor: primaryColor,
              currentIndex: controller.tabIndex,
              bubbleCurve: Curves.decelerate,
              scaleFactor: 0.5,
              scaleCurve: Curves.fastOutSlowIn,
              isFloating: true,
              onTap: (index) {
                controller.changeTabIndex(index);
              },
              items: [
                CustomNavigationBarItem(
                  icon: const Icon(
                    FontAwesomeIcons.userLarge,
                    size: 20,
                  ),
                  title: const Text(
                    'Employee',
                  ),
                ),
                CustomNavigationBarItem(
                  icon: const Icon(
                    FontAwesomeIcons.userTag,
                    size: 20,
                  ),
                  title: const Text(
                    'Customer',
                  ),
                ),
                CustomNavigationBarItem(
                  icon: const Icon(
                    FontAwesomeIcons.userGear,
                    size: 20,
                  ),
                  title: const Text(
                    'Role',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
          ],
        ),
      );
    });
  }
}
