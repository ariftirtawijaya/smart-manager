import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/modules/admin/home_admin/views/home_admin_view.dart';
import 'package:smart_manager/app/modules/admin/profile_admin/views/profile_admin_view.dart';
import 'package:smart_manager/app/modules/admin/users_admin/views/users_admin_view.dart';

import '../controllers/dashboard_admin_controller.dart';

class DashboardAdminView extends GetView<DashboardAdminController> {
  const DashboardAdminView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardAdminController>(builder: (controller) {
      return Scaffold(
        extendBody: true,
        body: Center(
          child: IndexedStack(
            index: controller.tabIndex,
            children: const [
              HomeAdminView(),
              UsersAdminView(),
              ProfileAdminView(),
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
                    FontAwesomeIcons.house,
                    size: 20,
                  ),
                  title: const Text(
                    'Home',
                  ),
                ),
                CustomNavigationBarItem(
                  icon: const Icon(
                    FontAwesomeIcons.users,
                    size: 20,
                  ),
                  title: const Text(
                    'Users',
                  ),
                ),
                CustomNavigationBarItem(
                  icon: const Icon(
                    FontAwesomeIcons.userLarge,
                    size: 20,
                  ),
                  title: const Text(
                    'Profile',
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
