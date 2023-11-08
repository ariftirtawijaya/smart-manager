import 'package:get/get.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/modules/user/inventory/modules/inventory/controllers/inventory_controller.dart';
import 'package:smart_manager/app/modules/user/inventory/modules/product/views/components/product_variant.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class ProductAdd extends GetView<InventoryController> {
  const ProductAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> addProductKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: addProductKey,
            child: Column(
              children: [
                GetBuilder<InventoryController>(builder: (controller) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(color: grey2, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            controller.imagePath.isNotEmpty
                                ? Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(
                                            File(controller.imagePath)),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                  )
                                : Image.asset(
                                    imagePlaceholder,
                                    height: 48,
                                  ),
                            CustomButtonSmall(
                                onPressed: () {
                                  controller.pickImage(context);
                                },
                                text: controller.imagePath.isNotEmpty
                                    ? 'Change Image'
                                    : 'Choose Image')
                          ],
                        ),
                        Obx(() {
                          if (controller.isImageNull.isTrue) {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  "Image cannot empty",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: red),
                                ),
                              ],
                            );
                          } else {
                            return const SizedBox();
                          }
                        })
                      ],
                    ),
                  );
                }),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTextField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        addProductKey.currentState!.validate();
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Product name cannot empty\n';
                      }
                      return null;
                    },
                    controller: controller.nameController,
                    title: 'Name',
                    hintText: 'Insert product name'),
                const SizedBox(
                  height: 16.0,
                ),
                CustomDropdownField(
                  items: controller.dataC.categories
                      .map((category) => DropdownMenuItem(
                            value: category.categoryId,
                            child: Text(category.categoryName!),
                          ))
                      .toList(),
                  onChanged: (p0) {
                    print(p0);
                    if (p0 != null) {
                      controller.categoryController.text = p0;
                    }
                  },
                  controller: controller.categoryController,
                  title: 'Category',
                  hintText: 'Select category',
                  validator: (v) {
                    String? value = v;
                    if (value == null) {
                      return 'Category cannot empty\n';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTextField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        addProductKey.currentState!.validate();
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'SKU cannot empty\n';
                      }
                      return null;
                    },
                    controller: controller.skuController,
                    title: 'SKU',
                    hintText: 'Insert product sku'),
                const SizedBox(
                  height: 16.0,
                ),
                Obx(() {
                  if (controller.productVariant.isNotEmpty) {
                    return const SizedBox();
                  } else {
                    return Column(
                      children: [
                        CustomTextField(
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                addProductKey.currentState!.validate();
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Stock cannot empty\n';
                              }
                              if (!value.isNumericOnly) {
                                return 'Not valid!\n';
                              }
                              return null;
                            },
                            controller: controller.stockController,
                            title: 'Product Stock',
                            hintText: 'Insert product stock'),
                        const SizedBox(
                          height: 16.0,
                        ),
                        CustomTextField(
                            onChanged: (value) {
                              // if (controller.noMemberPrice.isTrue) {
                              //   controller.memberPriceController.text =
                              //       controller.regularPriceController.text;
                              // }
                              if (value.isNotEmpty) {
                                addProductKey.currentState!.validate();
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Price cannot empty\n';
                              }
                              if (!value.isCurrency) {
                                return 'Not valid!\n';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            isPriceField: true,
                            controller: controller.regularPriceController,
                            title: 'Price',
                            hintText: 'Insert product price'),
                        const SizedBox(
                          height: 16.0,
                        ),
                        // Obx(() {
                        //   return Column(
                        //     children: [
                        //       CustomTextField(
                        //           readOnly: controller.noMemberPrice.isFalse
                        //               ? false
                        //               : true,
                        //           keyboardType: TextInputType.number,
                        //           isPriceField: true,
                        //           validator: (value) {
                        //             if (!value!.isCurrency) {
                        //               return 'Not valid!\n';
                        //             }
                        //             return null;
                        //           },
                        //           controller: controller.memberPriceController,
                        //           title: 'Member Price',
                        //           hintText: 'Insert member price'),
                        //       CheckboxListTile(
                        //         title: const Text('Same as regular price'),
                        //         value: controller.noMemberPrice.value,
                        //         contentPadding: const EdgeInsets.only(left: 16),
                        //         onChanged: (value) {
                        //           controller.togleMemberPrice(value!);
                        //         },
                        //       )
                        //     ],
                        //   );
                        // }),
                      ],
                    );
                  }
                }),
                CustomTextField(
                    maxLines: 4,
                    controller: controller.descriptionController,
                    title: 'Description',
                    hintText: 'Product description (optional)'),
                // const SizedBox(
                //   height: 8.0,
                // ),
                // Obx(() {
                //   return CustomOutlinedButton(
                //     onPressed: () {
                //       if (controller.variantForms.isNotEmpty) {
                //         Get.to(() => const ProductVariant());
                //       } else {
                //         controller.hasVariant.value = true;
                //         controller.addVariantForm();
                //         Get.to(() => const ProductVariant());
                //       }
                //     },
                //     text: controller.variantForms.isEmpty
                //         ? 'Enable Variant'
                //         : 'Show Variant (${controller.variantForms.length})',
                //   );
                // }),
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
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
        child: CustomButton(
          onPressed: () {
            // if (controller.imagePath.isEmpty) {
            //   controller.isImageNull.value = true;
            // }
            // if (addProductKey.currentState!.validate() &&
            //     controller.isImageNull.isFalse) {
            // }

            if (controller.imagePath.isEmpty) {
              controller.isImageNull.value = true;
            }
            if (addProductKey.currentState!.validate() &&
                controller.isImageNull.isFalse) {
              Get.to(() => const ProductVariant());
              // controller.createProduct(context);
            }
          },
          text: 'Next',
        ),
      ),
    );
  }
}
