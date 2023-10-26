import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/modules/user/inventory/controllers/inventory_controller.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class CategoryView extends GetView<InventoryController> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: const Scaffold(
        body: Column(
          children: [
            CustomSearch(
              text: 'Search categories',
            ),
            Expanded(
                child: Center(
              child: Text('Categories Will Be Here'),
            )),
            SizedBox(
              height: kBottomNavigationBarHeight,
            ),
          ],
        ),
      ),
    );
  }
}
