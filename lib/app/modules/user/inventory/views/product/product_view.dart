import 'dart:developer';

import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/controllers/data_controller.dart';
import 'package:smart_manager/app/data/models/category_model.dart';
import 'package:smart_manager/app/data/models/product_model.dart';
import 'package:smart_manager/app/modules/user/inventory/controllers/inventory_controller.dart';
import 'package:smart_manager/app/modules/user/inventory/views/product/components/product_list.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class ProductView extends GetView<InventoryController> {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            CustomSearch(
              text: 'Search products or scan barcode',
              hasPrefixIcon: true,
              onPrefixPressed: () {
                EasyLoading.showInfo('Scan Barcode');
              },
              controller: controller.searchProductC,
              onChanged: (value) {
                controller.changeKeyword('product');
              },
              prefixIcon: FontAwesomeIcons.barcode,
            ),
            const SizedBox(
              height: 8.0,
            ),
            SizedBox(
              height: Get.height * 0.05,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: controller.dataC.categories.length + 3,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const SizedBox();
                  } else if (index == 1) {
                    return Obx(() => ActionChip(
                          label: Text(
                            'All Products',
                            style:
                                controller.selectedCategoryIndex.value == index
                                    ? const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)
                                    : null,
                          ),
                          backgroundColor:
                              controller.selectedCategoryIndex.value == index
                                  ? primaryColor
                                  : null,
                          onPressed: () {
                            controller.selectedCategoryId.value = "";
                            controller.selectedCategoryIndex.value = index;
                          },
                          pressElevation: 2,
                        ));
                  } else if (index == controller.dataC.categories.length + 2) {
                    return const SizedBox();
                  } else {
                    CategoryModel category =
                        controller.dataC.categories[index - 2];
                    return Obx(() => ActionChip(
                          label: Text(
                            category.categoryName!,
                            style:
                                controller.selectedCategoryIndex.value == index
                                    ? const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)
                                    : null,
                          ),
                          onPressed: () {
                            print(category.categoryId);
                            controller.selectedCategoryId.value =
                                category.categoryId!;
                            controller.selectedCategoryIndex.value = index;
                          },
                          backgroundColor:
                              controller.selectedCategoryIndex.value == index
                                  ? primaryColor
                                  : null,
                          pressElevation: 2,
                        ));
                  }
                },
                separatorBuilder: (context, index) => const SizedBox(
                  width: 16.0,
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => controller.dataC.getProducts(),
                child: Obx(() {
                  if (controller.dataC.isLoading.isTrue) {
                    return AutoHeightGridView(
                      itemCount: 10,
                      physics: const AlwaysScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      padding: const EdgeInsets.all(16),
                      builder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: grey3,
                          highlightColor: grey4,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: primaryColor,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(productImage),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        topRight: Radius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: primaryColor),
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8.0),
                                          ),
                                          color: Colors.red,
                                        ),
                                        child: Text(
                                          "product name",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4.0,
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8.0),
                                          ),
                                          color: Colors.red,
                                        ),
                                        child: Text(
                                          "B\$ 100.00",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: secondaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    if (controller.dataC.products.isEmpty) {
                      return Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: Lottie.asset(empty)),
                              const SizedBox(
                                height: 16.0,
                              ),
                            ],
                          ),
                          ListView(),
                        ],
                      );
                    } else if (controller.listSearchProduct.isNotEmpty) {
                      List<ProductModel> list = [];
                      if (controller.selectedCategoryId.isNotEmpty) {
                        list = controller.listSearchProduct
                            .where((product) =>
                                product.product.productCategoryId ==
                                controller.selectedCategoryId.value)
                            .toList();
                      } else {
                        list = controller.listSearchProduct;
                      }
                      if (list.isNotEmpty) {
                        return ProductList(
                          itemCount: list.length,
                          products: list,
                        );
                      } else {
                        return Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(child: Lottie.asset(empty)),
                                const SizedBox(
                                  height: 16.0,
                                ),
                              ],
                            ),
                            ListView(),
                          ],
                        );
                      }
                    } else if (controller.listSearchProduct.isEmpty &&
                        controller.keywordProduct.value != '') {
                      return Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: Lottie.asset(empty)),
                              const SizedBox(
                                height: 16.0,
                              ),
                            ],
                          ),
                          ListView(),
                        ],
                      );
                    } else {
                      log('INI');
                      List<ProductModel> list = [];
                      if (controller.selectedCategoryId.isNotEmpty) {
                        list = controller.dataC.products
                            .where((product) =>
                                product.product.productCategoryId ==
                                controller.selectedCategoryId.value)
                            .toList();
                      } else {
                        list = controller.dataC.products;
                      }
                      if (list.isNotEmpty) {
                        return ProductList(
                          itemCount: list.length,
                          products: list,
                        );
                      } else {
                        return Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(child: Lottie.asset(empty)),
                                const SizedBox(
                                  height: 16.0,
                                ),
                              ],
                            ),
                            ListView(),
                          ],
                        );
                      }
                    }
                  }
                }),
              ),
            ),
            const SizedBox(
              height: kBottomNavigationBarHeight,
            ),
          ],
        ),
      ),
    );
  }
}
