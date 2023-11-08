import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/data/models/category_model.dart';
import 'package:smart_manager/app/modules/user/inventory/modules/category/controllers/category_controller.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class CategoryEdit extends GetView<CategoryController> {
  const CategoryEdit({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    controller.nameController.text = category.categoryName!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Edit Category',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16.0,
          ),
          GetBuilder<CategoryController>(builder: (controller) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                border: Border.all(color: grey2, width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  controller.imagePath.isNotEmpty
                      ? Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(File(controller.imagePath)),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                        )
                      : category.categoryIcon != null
                          ? CustomImageView(
                              imageUrl: category.categoryIcon!, size: 48)
                          : Image.asset(
                              imagePlaceholder,
                              height: 48,
                            ),
                  CustomButtonSmall(
                      onPressed: () {
                        controller.pickImage(context);
                      },
                      text: 'Change Icon')
                ],
              ),
            );
          }),
          const SizedBox(
            height: 16.0,
          ),
          CustomTextField(
              controller: controller.nameController,
              title: 'Name',
              hintText: 'Insert category name'),
          const SizedBox(
            height: 16.0,
          ),
          CustomButton(
              onPressed: () {
                controller.updateCategory(context, category);
              },
              text: "Add"),
        ],
      ),
    );
  }
}
