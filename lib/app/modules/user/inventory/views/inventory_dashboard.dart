import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_colors.dart';
import 'package:smart_manager/app/modules/user/inventory/controllers/inventory_controller.dart';
import 'package:smart_manager/app/modules/user/inventory/views/category_view.dart';
import 'package:smart_manager/app/modules/user/inventory/views/inventory_view.dart';
import 'package:smart_manager/app/modules/user/inventory/views/product_view.dart';
import 'package:smart_manager/app/utils/widgets/custom_user_page.dart';

class InventoryDashboardView extends GetView<InventoryController> {
  const InventoryDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InventoryController>(builder: (controller) {
      return CustomUserPage(
        extendBody: true,
        title: controller.tabIndex == 0
            ? 'List Products'
            : controller.tabIndex == 1
                ? 'List Categories'
                : 'Inventory',
        actions: controller.tabIndex == 0
            ? [
                IconButton(
                  onPressed: () {
                    EasyLoading.showInfo('Add Product');
                  },
                  icon: const Icon(
                    FontAwesomeIcons.squarePlus,
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
                      onPressed: () {
                        EasyLoading.showInfo('Add Category');
                      },
                      icon: const Icon(
                        FontAwesomeIcons.squarePlus,
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
                        EasyLoading.showInfo('Add Inventory');
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
              ProductView(),
              CategoryView(),
              InventoryView(),
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
                    FontAwesomeIcons.box,
                    size: 20,
                  ),
                  title: const Text(
                    'Product',
                  ),
                ),
                CustomNavigationBarItem(
                  icon: const Icon(
                    FontAwesomeIcons.tags,
                    size: 20,
                  ),
                  title: const Text(
                    'Category',
                  ),
                ),
                CustomNavigationBarItem(
                  icon: const Icon(
                    FontAwesomeIcons.boxArchive,
                    size: 20,
                  ),
                  title: const Text(
                    'Inventory',
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
