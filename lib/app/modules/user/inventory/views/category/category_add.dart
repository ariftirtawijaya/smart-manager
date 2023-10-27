import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/modules/user/inventory/controllers/inventory_controller.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class CategoryAdd extends GetView<InventoryController> {
  const CategoryAdd({super.key});

  @override
  Widget build(BuildContext context) {
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
            'Add Category',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16.0,
          ),
          GetBuilder<InventoryController>(builder: (controller) {
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
                      : Image.asset(
                          imagePlaceholder,
                          height: 48,
                        ),
                  CustomButtonSmall(
                      onPressed: () {
                        controller.pickImage(context);
                      },
                      text: controller.imagePath.isNotEmpty
                          ? 'Change Icon'
                          : 'Choose Icon')
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
                controller.createCategory(context);
              },
              text: "Add"),
        ],
      ),
    );
  }
}
