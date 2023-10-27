import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/modules/user/inventory/controllers/inventory_controller.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class ProductView extends GetView<InventoryController> {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            CustomSearch(
              text: 'Search products or scan barcode',
              hasPrefixIcon: true,
              onPrefixPressed: () {
                EasyLoading.showInfo('Scan Barcode');
              },
              prefixIcon: FontAwesomeIcons.barcode,
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Center(
              child: Text('<- Categories Will Be Here ->'),
            ),
            const Expanded(
                child: Center(
              child: Text('Products Will Be Here'),
            )),
            const SizedBox(
              height: kBottomNavigationBarHeight,
            ),
          ],
        ),
      ),
    );
  }
}
