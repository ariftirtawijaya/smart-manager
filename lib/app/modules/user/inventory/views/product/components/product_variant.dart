import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/modules/user/inventory/controllers/inventory_controller.dart';
import 'package:smart_manager/app/modules/user/inventory/views/product/components/variant_form.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class ProductVariant extends GetView<InventoryController> {
  const ProductVariant({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        controller.variantForms
            .removeWhere((form) => form.value.saved == false);
        if (controller.variantForms.isEmpty) {
          controller.hasVariant.value = false;
          controller.variantForms.clear();
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Variant'),
          actions: [
            Obx(() {
              return IconButton(
                onPressed: controller.variantForms.isEmpty
                    ? null
                    : () {
                        controller.saveVariant();
                      },
                icon: Icon(
                  FontAwesomeIcons.solidFloppyDisk,
                  size: 24.0,
                  color: controller.variantForms.isEmpty ? grey2 : null,
                ),
              );
            }),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(() {
            if (controller.variantForms.isNotEmpty) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    for (var index = 0;
                        index < controller.variantForms.length;
                        index++)
                      VariantForm(
                        formKey: controller.variantForms[index].value.formKey,
                        nameController:
                            controller.variantForms[index].value.nameController,
                        regularPriceController: controller
                            .variantForms[index].value.regularPriceController,
                        memberPriceController: controller
                            .variantForms[index].value.memberPriceController,
                        stockController: controller
                            .variantForms[index].value.stockController,
                        index: index,
                      ),
                  ],
                ),
              );
            } else {
              return Center(child: Lottie.asset(empty));
            }
          }),
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
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
          child: Obx(() => CustomButton(
                onPressed: () {
                  controller.addVariantForm();
                },
                text: controller.variantForms.isNotEmpty
                    ? 'Add More Variant'
                    : 'Add New Variant',
              )),
        ),
      ),
    );
  }
}
