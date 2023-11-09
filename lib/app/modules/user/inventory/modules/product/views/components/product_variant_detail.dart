import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/data/models/product_model.dart';
import 'package:smart_manager/app/modules/user/inventory/modules/product/controllers/product_controller.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class ProductVariantDetail extends GetView<ProductController> {
  const ProductVariantDetail({super.key});

  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Variant Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    controller.selectedPriceUpdate.clear();
                    Get.bottomSheet(
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              topRight: Radius.circular(12.0),
                            ),
                            color: Colors.white),
                        padding: const EdgeInsets.all(16),
                        child: GetBuilder<ProductController>(
                            builder: (controller) {
                          return Column(
                            children: [
                              Text(
                                'Select variant you want to set',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                value: controller.selectedPriceUpdate.length ==
                                    controller.productPrices.length,
                                onChanged: (value) {
                                  controller.selectAllUpdate(value!);
                                },
                                title: const Text('Select All'),
                              ),
                              const Divider(
                                color: grey3,
                              ),
                              if (controller.productVariant.length > 1)
                                const SizedBox(
                                  height: 16.0,
                                ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: controller.productVariant.length >
                                            1
                                        ? controller
                                            .productVariant.first.options!
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  entry.value,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 8.0,
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: controller
                                                      .productVariant
                                                      .last
                                                      .options!
                                                      .asMap()
                                                      .entries
                                                      .map((entry2) {
                                                    Map<String, dynamic>
                                                        option = {
                                                      entry.value: entry2.value
                                                    };
                                                    return CheckboxListTile(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      value: controller
                                                          .selectedPriceUpdate
                                                          .where((price) =>
                                                              price
                                                                  .toString() ==
                                                              option.toString())
                                                          .isNotEmpty,
                                                      onChanged: (value) {
                                                        controller
                                                            .selectPriceUpdate(
                                                                value!, option);
                                                      },
                                                      title: Text(entry2.value),
                                                    );
                                                  }).toList(),
                                                ),
                                                const SizedBox(
                                                  height: 8.0,
                                                ),
                                              ],
                                            );
                                          }).toList()
                                        : controller
                                            .productVariant.first.options!
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                            Map<String, dynamic> option = {
                                              entry.value: entry.value
                                            };
                                            return CheckboxListTile(
                                              contentPadding: EdgeInsets.zero,
                                              value: controller
                                                  .selectedPriceUpdate
                                                  .where((price) =>
                                                      price.toString() ==
                                                      option.toString())
                                                  .isNotEmpty,
                                              onChanged: (value) {
                                                controller.selectPriceUpdate(
                                                    value!, option);
                                              },
                                              title: Text(entry.value),
                                            );
                                          }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Container(
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
                                child: CustomButton(
                                  onPressed: controller
                                          .selectedPriceUpdate.isEmpty
                                      ? null
                                      : () {
                                          controller.bulkUpdateForm(context);
                                        },
                                  text: controller.selectedPriceUpdate.isEmpty
                                      ? 'Next'
                                      : 'Next (${controller.selectedPriceUpdate.length})',
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      // isScrollControlled: true,
                      ignoreSafeArea: false,
                      enableDrag: true,
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Bulk Update',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('Set Price, Stock, and SKU at once'),
                  trailing: const Icon(
                    FontAwesomeIcons.pencil,
                    size: 20.0,
                    color: secondaryColor,
                  ),
                ),
                GetBuilder<ProductController>(builder: (controller) {
                  return Column(
                    children: controller.productVariant.length > 1
                        ? controller.productVariant.first.options!
                            .asMap()
                            .entries
                            .map(
                              (entry) => ExpansionTile(
                                key: GlobalKey(),
                                initiallyExpanded: true,
                                tilePadding: EdgeInsets.zero,
                                title: Text(
                                  entry.value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: controller
                                        .productVariant.last.options!
                                        .asMap()
                                        .entries
                                        .map((entry2) {
                                      Map<String, dynamic> targetOption = {
                                        entry.value: entry2.value
                                      };

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(entry2.value,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CustomTextField(
                                                    initialValue: controller
                                                        .productPrices
                                                        .firstWhere((price) =>
                                                            price.option
                                                                .toString() ==
                                                            targetOption
                                                                .toString())
                                                        .price
                                                        .toString(),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    isPriceField: true,
                                                    onChanged: (value) {
                                                      if (value.isCurrency) {
                                                        controller.productPrices
                                                            .firstWhere((price) =>
                                                                price.option
                                                                    .toString() ==
                                                                targetOption
                                                                    .toString())
                                                            .price = double.parse(value);
                                                      }
                                                    },
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Cannot Empty!\n';
                                                      }
                                                      if (!value.isCurrency) {
                                                        return 'Wrong Format!\n';
                                                      }
                                                      return null;
                                                    },
                                                    title: 'Price',
                                                    hintText: 'Insert Price'),
                                              ),
                                              const SizedBox(
                                                width: 6.0,
                                              ),
                                              Expanded(
                                                // flex: 1,
                                                child: CustomTextField(
                                                    initialValue: controller
                                                        .productPrices
                                                        .firstWhere((price) =>
                                                            price.option
                                                                .toString() ==
                                                            targetOption
                                                                .toString())
                                                        .stock
                                                        .toString(),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (value) {
                                                      if (value.isNumericOnly) {
                                                        controller.productPrices
                                                            .firstWhere((price) =>
                                                                price.option
                                                                    .toString() ==
                                                                targetOption
                                                                    .toString())
                                                            .stock = int.parse(value);
                                                      }
                                                    },
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Cannot Empty!\n';
                                                      }
                                                      if (!value
                                                          .isNumericOnly) {
                                                        return 'Numeric Only!\n';
                                                      }
                                                      return null;
                                                    },
                                                    title: 'Stock',
                                                    hintText: 'Insert Stock'),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 16.0,
                                          ),
                                          CustomTextField(
                                              initialValue: controller
                                                  .productPrices
                                                  .firstWhere((price) =>
                                                      price.option.toString() ==
                                                      targetOption.toString())
                                                  .sku,
                                              textCapitalization:
                                                  TextCapitalization.characters,
                                              onChanged: (value) {
                                                controller.productPrices
                                                    .firstWhere((price) =>
                                                        price.option
                                                            .toString() ==
                                                        targetOption.toString())
                                                    .sku = value;
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Cannot Empty!\n';
                                                }
                                                return null;
                                              },
                                              title: 'SKU',
                                              hintText: 'Insert SKU'),
                                          const SizedBox(
                                            height: 16.0,
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            )
                            .toList()
                        : controller.productVariant
                            .asMap()
                            .entries
                            .map((entry) {
                            return ExpansionTile(
                              key: GlobalKey(),
                              initiallyExpanded: true,
                              tilePadding: EdgeInsets.zero,
                              title: Text(
                                entry.value.name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: entry.value.options!
                                      .asMap()
                                      .entries
                                      .map((entry2) {
                                    Map<String, dynamic> targetOption = {
                                      entry2.value: entry2.value
                                    };
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(entry2.value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!),
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: CustomTextField(
                                                  initialValue: controller
                                                      .productPrices
                                                      .firstWhere((price) =>
                                                          price.option
                                                              .toString() ==
                                                          targetOption
                                                              .toString())
                                                      .price
                                                      .toString(),
                                                  onChanged: (value) {
                                                    if (value.isCurrency) {
                                                      controller.productPrices
                                                          .firstWhere((price) =>
                                                              price.option
                                                                  .toString() ==
                                                              targetOption
                                                                  .toString())
                                                          .price = double.parse(value);
                                                    }
                                                  },
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Cannot Empty!\n';
                                                    }
                                                    return null;
                                                  },
                                                  title: 'Price',
                                                  hintText: 'Insert Price'),
                                            ),
                                            const SizedBox(
                                              width: 6.0,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: CustomTextField(
                                                  initialValue: controller
                                                      .productPrices
                                                      .firstWhere((price) =>
                                                          price.option
                                                              .toString() ==
                                                          targetOption
                                                              .toString())
                                                      .stock
                                                      .toString(),
                                                  onChanged: (value) {
                                                    if (value.isNumericOnly) {
                                                      controller.productPrices
                                                          .firstWhere((price) =>
                                                              price.option
                                                                  .toString() ==
                                                              targetOption
                                                                  .toString())
                                                          .stock = int.parse(value);
                                                    }
                                                  },
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Cannot Empty!\n';
                                                    }
                                                    if (!value.isNumericOnly) {
                                                      return 'Numeric Only!\n';
                                                    }
                                                    return null;
                                                  },
                                                  title: 'Stock',
                                                  hintText: 'Insert Stock'),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 16.0,
                                        ),
                                        CustomTextField(
                                            initialValue: controller
                                                .productPrices
                                                .firstWhere((price) =>
                                                    price.option.toString() ==
                                                    targetOption.toString())
                                                .sku,
                                            onChanged: (value) {
                                              controller.productPrices
                                                  .firstWhere((price) =>
                                                      price.option.toString() ==
                                                      targetOption.toString())
                                                  .sku = value;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Cannot Empty!\n';
                                              }
                                              return null;
                                            },
                                            title: 'SKU',
                                            hintText: 'Insert SKU'),
                                        const SizedBox(
                                          height: 16.0,
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                )
                              ],
                            );
                          }).toList(),
                  );
                }),
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
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              logger.i(
                controller.productVariant.toString(),
              );
              logger.i(
                controller.productPrices.toString(),
              );
              await controller.createProduct(context);
            }
          },
          text: 'Save Product',
        ),
      ),
    );
  }
}
