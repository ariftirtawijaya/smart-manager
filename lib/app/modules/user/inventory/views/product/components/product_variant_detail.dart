import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/modules/user/inventory/controllers/inventory_controller.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class ProductVariantDetail extends GetView<InventoryController> {
  const ProductVariantDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    List<List<TextEditingController>> priceControllers = List.generate(
        controller.productVariant.first.options!.length,
        (index) => List<TextEditingController>.generate(
            controller.productVariant.last.options!.length,
            (index) => TextEditingController()));
    List<List<TextEditingController>> stockControllers = List.generate(
        controller.productVariant.first.options!.length,
        (index) => List<TextEditingController>.generate(
            controller.productVariant.last.options!.length,
            (index) => TextEditingController()));
    List<List<TextEditingController>> skuControllers = List.generate(
        controller.productVariant.first.options!.length,
        (index) => List<TextEditingController>.generate(
            controller.productVariant.last.options!.length,
            (index) => TextEditingController()));
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
                            entry.value.name!,
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
                                int rowIndex = entry.key;
                                int colIndex = entry2.key;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(entry2.value.name!,
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
                                                if (value.isNumericOnly) {
                                                  entry2.value.price =
                                                      double.parse(value);
                                                }
                                              },
                                              controller:
                                                  priceControllers[rowIndex]
                                                      [colIndex],
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
                                                  entry2.value.stock =
                                                      int.parse(value);
                                                }
                                              },
                                              controller:
                                                  stockControllers[rowIndex]
                                                      [colIndex],
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
                                          entry2.value.sku = value;
                                        },
                                        controller: skuControllers[rowIndex]
                                            [colIndex],
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
                              int rowIndex = entry.key;
                              int colIndex = entry2.key;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(entry2.value.name!,
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
                                              if (value.isNumericOnly) {
                                                entry2.value.price =
                                                    double.parse(value);
                                              }
                                            },
                                            controller:
                                                priceControllers[rowIndex]
                                                    [colIndex],
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
                                                entry2.value.stock =
                                                    int.parse(value);
                                              }
                                            },
                                            controller:
                                                stockControllers[rowIndex]
                                                    [colIndex],
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
                                        entry2.value.sku = value;
                                      },
                                      controller: skuControllers[rowIndex]
                                          [colIndex],
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
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
        child: CustomButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              // for (var i = 0; i < priceControllers.length; i++) {
              //   var item = priceControllers[i];
              //   for (var j = 0; j < item.length; j++) {
              //     var price = priceControllers[i][j];
              //     var stock = stockControllers[i][j];
              //     var sku = skuControllers[i][j];
              //     print("Price ${price.value.text}");
              //     print("Stock : ${stock.value.text}");
              //     print("SKU : ${sku.value.text}");
              //   }
              // }
              for (var i = 0; i < controller.productVariant.length; i++) {
                var item = controller.productVariant[i];
                print(item.toJson());
                // print("itemName : ${item.name}");
                // for (var j = 0; j < item.options!.length; j++) {
                //   var item2 = item.options![j];

                //   print("item2Name : ${item2.name}");
                //   print("item2Price : ${item2.price}");
                //   print("item2SKU : ${item2.sku}");
                //   print("item2Stock : ${item2.stock}");
                // }
              }
            }
          },
          text: 'Next',
        ),
      ),
    );
  }
}
