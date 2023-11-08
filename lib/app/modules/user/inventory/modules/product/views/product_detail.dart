import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:smart_manager/app/constant/app_colors.dart';
import 'package:smart_manager/app/data/models/product_model.dart';
import 'package:smart_manager/app/modules/user/inventory/modules/product/controllers/product_controller.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';
import 'package:intl/intl.dart' as intl;

class ProductDetail extends GetView<ProductController> {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel product = Get.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              splashRadius: 24,
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 24.0,
              ),
            ),
            expandedHeight: Get.width * 0.9,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  InstaImageViewer(
                    child:
                        CustomImageView(imageUrl: product.product.image ?? ""),
                  ),
                  Container(
                    height: kToolbarHeight + (kToolbarHeight * 0.5),
                    // color: Colors.red,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, right: 16, bottom: 8),
                  child: Obx(
                    () => Text(
                      "${product.product.name} ${product.variants != null ? product.variants!.length > 1 ? "- ${controller.selectedPriceOption.keys.first}, ${controller.selectedPriceOption.values.first} " : "- ${controller.selectedPriceOption.keys.first}" : ""}",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Obx(
                    () => Text(
                      "B\$ ${intl.NumberFormat.currency(decimalDigits: 2, locale: "ms_BN", symbol: '').format(controller.selectedPrice.value)}",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold, color: secondaryColor),
                    ),
                  ),
                ),
                if (product.variants == null)
                  const SizedBox()
                else if (product.variants!.length > 1)
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${product.variants!.first.name!} :"),
                          SizedBox(
                            width: Get.width,
                            child: Wrap(
                              children: product.variants!.first.options!
                                  .map((variantType) => Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ActionChip(
                                            label: Text(
                                              variantType,
                                              style: controller
                                                          .selectedPriceOption
                                                          .keys
                                                          .first ==
                                                      variantType
                                                  ? const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)
                                                  : null,
                                            ),
                                            backgroundColor: controller
                                                        .selectedPriceOption
                                                        .keys
                                                        .first ==
                                                    variantType
                                                ? primaryColor
                                                : null,
                                            onPressed: () {
                                              print(variantType);
                                              String oldValue = controller
                                                  .selectedPriceOption
                                                  .values
                                                  .first;
                                              controller.changeSelectedVariant(
                                                keys: variantType,
                                                values: oldValue,
                                                prices: product.prices!,
                                              );
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
                          Text("${product.variants!.last.name!} :"),
                          SizedBox(
                            width: Get.width,
                            child: Wrap(
                              children: product.variants!.last.options!
                                  .map((variantType) => Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ActionChip(
                                            label: Text(
                                              variantType,
                                              style: controller
                                                          .selectedPriceOption
                                                          .values
                                                          .first ==
                                                      variantType
                                                  ? const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)
                                                  : null,
                                            ),
                                            backgroundColor: controller
                                                        .selectedPriceOption
                                                        .values
                                                        .first ==
                                                    variantType
                                                ? primaryColor
                                                : null,
                                            onPressed: () {
                                              print(variantType);
                                              String oldKey = controller
                                                  .selectedPriceOption
                                                  .keys
                                                  .first;
                                              controller.changeSelectedVariant(
                                                keys: oldKey,
                                                values: variantType,
                                                prices: product.prices!,
                                              );
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
                        ],
                      ),
                    ),
                  )
                else
                  Obx(() => Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${product.variants!.first.name!} :"),
                            SizedBox(
                              width: Get.width,
                              child: Wrap(
                                children: product.variants!.first.options!
                                    .map((variantType) => Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ActionChip(
                                              label: Text(
                                                variantType,
                                                style: controller
                                                                .selectedPriceOption
                                                                .keys
                                                                .first ==
                                                            variantType &&
                                                        controller
                                                                .selectedPriceOption
                                                                .values
                                                                .first ==
                                                            variantType
                                                    ? const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)
                                                    : null,
                                              ),
                                              backgroundColor: controller
                                                              .selectedPriceOption
                                                              .keys
                                                              .first ==
                                                          variantType &&
                                                      controller
                                                              .selectedPriceOption
                                                              .values
                                                              .first ==
                                                          variantType
                                                  ? primaryColor
                                                  : null,
                                              onPressed: () {
                                                print(variantType);
                                                controller
                                                    .changeSelectedVariant(
                                                  keys: variantType,
                                                  values: variantType,
                                                  prices: product.prices!,
                                                );
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
                          ],
                        ),
                      )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
