import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/modules/user/inventory/controllers/inventory_controller.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

// ignore: must_be_immutable
class VariantForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController regularPriceController;
  final TextEditingController stockController;
  final TextEditingController memberPriceController;
  final int? index;
  bool? saved;

  VariantForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.regularPriceController,
    required this.memberPriceController,
    required this.stockController,
    this.index,
    this.saved = false,
  });

  @override
  State<VariantForm> createState() => _VariantFormState();
}

class _VariantFormState extends State<VariantForm> {
  bool noMemberPrice = true;

  void togleMemberPrice(bool value) {
    noMemberPrice = value;
    if (value == true) {
      widget.memberPriceController.text = widget.regularPriceController.text;
    } else {
      widget.memberPriceController.clear();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: widget.formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                widget.formKey.currentState!.validate();
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Variant name cannot empty\n';
                              }
                              return null;
                            },
                            controller: widget.nameController,
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
                                    if (noMemberPrice == true) {
                                      widget.memberPriceController.text =
                                          widget.regularPriceController.text;
                                    }
                                    if (value.isNotEmpty) {
                                      widget.formKey.currentState!.validate();
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
                                  controller: widget.regularPriceController,
                                  title: 'Reg Price',
                                  hintText: 'Regular price\n'),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Expanded(
                              child: CustomTextField(
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      widget.formKey.currentState!.validate();
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
                                  controller: widget.stockController,
                                  title: 'Stock',
                                  hintText: 'Variant stock'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Column(
                          children: [
                            CustomTextField(
                                readOnly: noMemberPrice == false ? false : true,
                                isPriceField: true,
                                controller: widget.memberPriceController,
                                title: 'Member Price',
                                hintText: 'Member price'),
                            CheckboxListTile(
                              title: const Text('Same as regular price'),
                              value: noMemberPrice,
                              contentPadding: const EdgeInsets.only(left: 16),
                              onChanged: (value) {
                                togleMemberPrice(value!);
                              },
                            )
                          ],
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
                  Get.find<InventoryController>()
                      .deleteVariantForm(widget.index!);
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
