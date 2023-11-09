import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
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
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: controller.productVariant.length > 1
                  ? controller.productVariant.first.options!
                      .asMap()
                      .entries
                      .map(
                        (entry) => ExpansionTile(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: controller.productVariant.last.options!
                                  .asMap()
                                  .entries
                                  .map((entry2) {
                                Map<String, dynamic> targetOption = {
                                  entry.value: entry2.value
                                };
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          // flex: 2,
                                          child: CustomTextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              isPriceField: true,
                                              onChanged: (value) {
                                                if (value.isCurrency) {
                                                  for (var price in controller
                                                      .productPrices) {
                                                    if (controller.mapEquals(
                                                        price.option,
                                                        targetOption)) {
                                                      price.price =
                                                          double.parse(value);
                                                      break;
                                                    }
                                                  }
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
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                if (value.isNumericOnly) {
                                                  for (var price in controller
                                                      .productPrices) {
                                                    if (controller.mapEquals(
                                                        price.option,
                                                        targetOption)) {
                                                      price.stock =
                                                          int.parse(value);
                                                      break;
                                                    }
                                                  }
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
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        onChanged: (value) {
                                          for (var price
                                              in controller.productPrices) {
                                            if (controller.mapEquals(
                                                price.option, targetOption)) {
                                              price.sku = value;
                                              break;
                                            }
                                          }
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
                  : controller.productVariant.asMap().entries.map((entry) {
                      return ExpansionTile(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            onChanged: (value) {
                                              if (value.isCurrency) {
                                                for (var price in controller
                                                    .productPrices) {
                                                  if (controller.mapEquals(
                                                      price.option,
                                                      targetOption)) {
                                                    price.price =
                                                        double.parse(value);
                                                    break;
                                                  }
                                                }
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
                                            onChanged: (value) {
                                              if (value.isNumericOnly) {
                                                for (var price in controller
                                                    .productPrices) {
                                                  if (controller.mapEquals(
                                                      price.option,
                                                      targetOption)) {
                                                    price.stock =
                                                        int.parse(value);
                                                    break;
                                                  }
                                                }
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
                                      onChanged: (value) {
                                        for (var price
                                            in controller.productPrices) {
                                          if (controller.mapEquals(
                                              price.option, targetOption)) {
                                            price.sku = value;
                                            break;
                                          }
                                        }
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
