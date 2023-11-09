import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:smart_manager/app/constant/app_colors.dart';
import 'package:smart_manager/app/data/models/product_model.dart';
import 'package:smart_manager/app/modules/user/inventory/modules/product/controllers/product_controller.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:math' as math;

class ProductDetail extends GetView<ProductController> {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel product = Get.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: Get.width * 0.9,
            floating: true,
            pinned: true,
            // elevation: 50,
            backgroundColor: primaryColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Get.back();
              },
            ),
            flexibleSpace: _MyAppSpace(product: product),
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
                          Text(
                            "${product.variants!.first.name!} :",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
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
                          Text(
                            "${product.variants!.last.name!} :",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
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
                            Text(
                              "${product.variants!.first.name!} :",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
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
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  child: Text(
                    "Product Details :",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Obx(() => Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text("SKU",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  product.prices!
                                      .firstWhere((price) =>
                                          price.option.toString() ==
                                          controller.selectedPriceOption
                                              .toString())
                                      .sku!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: darkBlue,
                            thickness: 0.1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text("Stock",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  product.prices!
                                      .firstWhere((price) =>
                                          price.option.toString() ==
                                          controller.selectedPriceOption
                                              .toString())
                                      .stock!
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: darkBlue,
                            thickness: 0.1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text("Category",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  controller.dataC.categories
                                      .firstWhere((category) =>
                                          category.categoryId ==
                                          product.product.categoryId)
                                      .categoryName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: darkBlue,
                            thickness: 0.1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text("Sold",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  product.product.sold.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: darkBlue,
                            thickness: 0.1,
                          ),
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product Descriptions :",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        product.product.description != null
                            ? product.product.description!
                                .replaceAll("\\n", "\n")
                            : "No description for this product",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                onPressed: () {},
                text: 'Edit',
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: CustomOutlinedButton(
                onPressed: () {},
                text: 'Delete',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyAppSpace extends GetView<ProductController> {
  final ProductModel product;

  const _MyAppSpace({required this.product});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        final deltaExtent = settings!.maxExtent - settings.minExtent;
        final t =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0);
        final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
        const fadeEnd = 1.0;
        final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);

        return Stack(
          children: [
            SafeArea(
              child: Center(
                child: Opacity(
                    opacity: 1 - opacity,
                    child: Text(
                      "${product.product.name} ${product.variants != null ? product.variants!.length > 1 ? "- ${controller.selectedPriceOption.keys.first}, ${controller.selectedPriceOption.values.first} " : "- ${controller.selectedPriceOption.keys.first}" : ""}",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    )),
              ),
            ),
            Opacity(
              opacity: opacity,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  getImage(product.product.image ?? ""),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget getImage(String image) {
    return Stack(
      children: [
        InstaImageViewer(
          child: CustomImageView(imageUrl: image),
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
    );
  }
}
