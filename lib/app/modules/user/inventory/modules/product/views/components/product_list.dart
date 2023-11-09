import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/data/models/product_model.dart';
import 'package:smart_manager/app/modules/user/inventory/modules/product/controllers/product_controller.dart';
import 'package:smart_manager/app/modules/user/inventory/modules/product/views/product_detail.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';
import 'package:intl/intl.dart' as intl;

class ProductList extends GetView<ProductController> {
  const ProductList({
    super.key,
    required this.itemCount,
    required this.products,
  });

  final int itemCount;
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return AutoHeightGridView(
      itemCount: itemCount,
      physics: const AlwaysScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      padding: const EdgeInsets.all(16),
      builder: (context, index) {
        final ProductModel product = products[index];
        return GestureDetector(
          onTap: () {
            controller.selectedPrice.value = product.variants == null
                ? product.product.price
                : product.prices!.first.price!;
            print(product.prices!.first);
            controller.selectedPriceOption.value =
                product.prices!.first.option!;
            print(controller.selectedPriceOption);
            Get.to(() => const ProductDetail(), arguments: product);
          },
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
                  child: CustomImageView(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    imageUrl: product.product.image ?? "",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        product.product.name,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      AutoSizeText(
                        "B\$ ${intl.NumberFormat.currency(decimalDigits: 2, locale: "ms_BN", symbol: '').format(product.variants == null ? product.product.price : product.prices!.first.price)}",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: secondaryColor),
                        maxLines: 1,
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
  }
}
