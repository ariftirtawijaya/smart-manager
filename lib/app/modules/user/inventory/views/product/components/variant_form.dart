import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/modules/user/inventory/controllers/inventory_controller.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

// ignore: must_be_immutable
class VariantForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController stockController;
  const VariantForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.priceController,
    required this.stockController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                formKey.currentState!.validate();
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Variant name cannot empty\n';
                              }
                              return null;
                            },
                            controller: nameController,
                            title: 'Name',
                            hintText: 'Variant name'),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      formKey.currentState!.validate();
                                    }
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Cannot empty\n';
                                    }
                                    if (!value.isCurrency) {
                                      return 'Not valid!\n';
                                    }
                                    return null;
                                  },
                                  isPriceField: true,
                                  keyboardType: TextInputType.number,
                                  controller: priceController,
                                  title: 'Price',
                                  hintText: 'Insert price\n'),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Expanded(
                              child: CustomTextField(
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      formKey.currentState!.validate();
                                    }
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Cannot empty\n';
                                    }
                                    if (!value.isCurrency) {
                                      return 'Not valid!\n';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: stockController,
                                  title: 'Stock',
                                  hintText: 'Variant stock'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              IconButton(
                constraints: const BoxConstraints(),
                splashRadius: 24,
                onPressed: () {
                  // Get.find<InventoryController>()
                  //     .deleteVariantForm(widget.index!);
                },
                icon: const Icon(
                  Icons.delete,
                  color: red,
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}
