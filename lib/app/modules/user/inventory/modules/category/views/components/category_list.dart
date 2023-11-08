import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/data/models/category_model.dart';
import 'package:smart_manager/app/data/models/product_model.dart';
import 'package:smart_manager/app/modules/user/inventory/modules/category/views/category_edit.dart';
import 'package:smart_manager/app/modules/user/inventory/modules/inventory/controllers/inventory_controller.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class CategoryList extends GetView<InventoryController> {
  const CategoryList({
    super.key,
    required this.itemCount,
    required this.categoryData,
    required this.productData,
  });
  final int itemCount;
  final RxList<CategoryModel> categoryData;
  final RxList<ProductModel> productData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final CategoryModel category = categoryData[index];
        return Padding(
          padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
          child: Card(
            elevation: 5,
            shadowColor: grey3,
            borderOnForeground: true,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: grey3,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              overlayColor: const MaterialStatePropertyAll(primaryColor),
              onTap: () {
                // Get.to(() => const UsersAdminDetailView(), arguments: category);
              },
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(
                  category.categoryName!.capitalize!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  "(${productData.where((product) => product.product.categoryId == category.categoryId).length} products)",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                leading: category.categoryIcon == null
                    ? Image.asset(
                        imagePlaceholder,
                        height: 52,
                      )
                    : CustomImageView(
                        imageUrl: category.categoryIcon!,
                        size: 52,
                      ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconButton(
                      icon: FontAwesomeIcons.solidPenToSquare,
                      color: secondaryColor,
                      onTap: () {
                        controller.clear();
                        Get.bottomSheet(CategoryEdit(category: category));
                      },
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    CustomIconButton(
                      icon: FontAwesomeIcons.trash,
                      color: secondaryColor,
                      onTap: () {
                        controller.deleteCategory(context, category);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
