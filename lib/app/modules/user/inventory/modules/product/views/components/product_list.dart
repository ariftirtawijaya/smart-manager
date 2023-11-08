import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/data/models/product_model.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';
import 'package:intl/intl.dart' as intl;

class ProductList extends StatelessWidget {
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
            Get.bottomSheet(Container(
              padding: const EdgeInsets.all(16),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "${product.product.name} asda asdasdas dasdasdas",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      Text(
                        "Stock : ${product.product.stock}",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: primaryColor),
                      ),
                    ],
                  )
                ],
              ),
            ));
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
                    imageUrl: product.product.image,
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
                      Text(
                        product.product.name,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "B\$ ${intl.NumberFormat.currency(decimalDigits: 2, locale: "ms_BN", symbol: '').format(product.product.price)}",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: secondaryColor),
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
