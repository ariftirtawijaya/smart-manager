import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/modules/user/inventory/modules/product/controllers/product_controller.dart';
import 'package:smart_manager/app/modules/user/inventory/modules/product/views/components/product_variant_detail.dart';
import 'package:smart_manager/app/modules/user/inventory/modules/product/views/product_add.dart';
import 'package:smart_manager/app/routes/app_pages.dart';
import '../../../../../../../data/models/product_model.dart' as model;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/utils/functions/reusable_functions.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class ProductVariant extends GetView<ProductController> {
  const ProductVariant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Variant'),
        actions: [
          Obx(() {
            if (controller.productVariant.isNotEmpty) {
              return IconButton(
                onPressed: () {
                  showAlert(
                    context: context,
                    type: QuickAlertType.confirm,
                    text: 'Delete all variant data for this product ?',
                    onConfirmBtnTap: () {
                      controller.productVariant.clear();
                      // controller.variantPrices.clear();
                      Get.back();
                    },
                  );
                },
                icon: const Icon(
                  FontAwesomeIcons.trash,
                  size: 20.0,
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.productVariant.isNotEmpty) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Variant Type",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: () {
                          controller.variantModal(
                              context: context, isFromAdd: true);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Text('+ Create New',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text("Select a maximum of 2 types of product variants",
                      style: Theme.of(context).textTheme.bodySmall),
                  SizedBox(
                    width: Get.width,
                    child: Wrap(
                      children: controller.dataC.variantTypes
                          .map((variantType) => Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ActionChip(
                                    label: Text(
                                      variantType,
                                      style: controller.productVariant
                                              .where((variantData) =>
                                                  variantData.name ==
                                                  variantType)
                                              .isNotEmpty
                                          ? const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)
                                          : null,
                                    ),
                                    backgroundColor: controller.productVariant
                                            .where((variantData) =>
                                                variantData.name == variantType)
                                            .isNotEmpty
                                        ? primaryColor
                                        : null,
                                    onPressed: () {
                                      if (controller.productVariant
                                          .where((variantData) =>
                                              variantData.name == variantType)
                                          .isEmpty) {
                                        if (controller.productVariant.length <
                                            2) {
                                          controller.productVariant.add(
                                            model.ProductVariant(
                                              name: variantType,
                                              options: RxList([]),
                                            ),
                                          );
                                        } else {
                                          EasyLoading.showToast(
                                              'Maximum 2 types of product variants');
                                        }
                                      } else {
                                        controller.productVariant.removeWhere(
                                            (variant) =>
                                                variant.name == variantType);
                                      }
                                    },
                                    pressElevation: 2,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Divider(
                    color: darkBlue,
                  ),
                  Obx(() => Column(
                        children: controller.productVariant
                            .map((variantType) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          variantType.name!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.addValueVariant(
                                                context, variantType);
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: secondaryColor,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            child: Text('+ Add',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: Colors.white)),
                                          ),
                                        )
                                      ],
                                    ),
                                    Obx(() {
                                      if (variantType.options!.isEmpty) {
                                        return const SizedBox();
                                      } else {
                                        return Column(
                                          children: [
                                            const SizedBox(
                                              height: 16.0,
                                            ),
                                            SizedBox(
                                              width: Get.width,
                                              child: Wrap(
                                                alignment: WrapAlignment.start,
                                                children: variantType.options!
                                                    .map((variantOption) => Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Chip(
                                                              label: Text(
                                                                variantOption,
                                                              ),
                                                              deleteIcon:
                                                                  const Icon(
                                                                Icons.cancel,
                                                                size: 16,
                                                                color: darkBlue,
                                                              ),
                                                              onDeleted: () {
                                                                controller.deleteValueVariant(
                                                                    variantType,
                                                                    variantOption);
                                                              },
                                                            ),
                                                            const SizedBox(
                                                              width: 8.0,
                                                            ),
                                                          ],
                                                        ))
                                                    .toList(),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    }),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    const Divider(
                                      color: darkBlue,
                                    ),
                                  ],
                                ))
                            .toList(),
                      )),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: Get.width * 0.4,
                    child: Image.asset(variant),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Add variants such as color, size, etc.",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CustomOutlinedButton(
                    onPressed: () {
                      controller.variantModal(
                          context: context, isFromAdd: false);
                    },
                    text: 'Add Variant',
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          padding: const EdgeInsets.only(top: 16),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("4 Easy ways to use variants",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 16.0,
                              ),
                              VariantHelp(),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: lighBlue2,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.solidLightbulb,
                            size: 24.0,
                            color: secondaryColor,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text("Learn more about product variants",
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
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
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        child: Obx(
          () => CustomButton(
            onPressed: () {
              if (controller.productVariant.isEmpty) {
                controller.createProduct(context);
              } else {
                controller.hasVariant = true;
                controller.setVariantPrices();
                Get.to(() => const ProductVariantDetail());
              }
            },
            text: controller.productVariant.isEmpty
                ? 'Skip And Save Product'
                : 'Next',
          ),
        ),
      ),
    );
  }
}

class VariantHelp extends StatelessWidget {
  VariantHelp({
    super.key,
  });
  final List<String> textFromIndex = [
    "Determine a maximum of 2 types of variants that suit your product",
    "Complete your variant type. The more complete it is, the more choices for sale",
    "Make sure to fill in your variant details such as price, stock and SKU so you can print and scan product barcodes",
    "Click 'Apply'",
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < textFromIndex.length; i++)
          Column(
            children: [
              ListTile(
                dense: true,
                leading: CircleAvatar(
                  maxRadius: 16,
                  child: Text("${i + 1}",
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                title: Text(textFromIndex[i],
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
      ],
    );
  }
}
