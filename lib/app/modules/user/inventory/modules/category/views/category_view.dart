import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/modules/user/inventory/modules/category/controllers/category_controller.dart';
import 'package:smart_manager/app/modules/user/inventory/modules/category/views/components/category_list.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});

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
            GetBuilder<CategoryController>(builder: (controller) {
              return CustomSearch(
                text: 'Search categories',
                controller: controller.searchCategoryC,
                onChanged: (p0) {
                  controller.changeKeyword();
                },
                onSuffixPressed: () {
                  controller.searchCategoryC.clear();
                  controller.changeKeyword();
                },
              );
            }),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return controller.dataC.getCategories();
                },
                child: Obx(() {
                  if (controller.dataC.isLoading.isTrue) {
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 16, left: 16, right: 16),
                          child: Shimmer.fromColors(
                            baseColor: grey3,
                            highlightColor: grey4,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                title: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.0),
                                    ),
                                    color: Colors.red,
                                  ),
                                  width: Get.width,
                                  height: 24,
                                ),
                                leading: Container(
                                  width: 52,
                                  height: 52,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    if (controller.dataC.categories.isEmpty) {
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
                    } else if (controller.listSearchCategory.isNotEmpty) {
                      return CategoryList(
                        itemCount: controller.listSearchCategory.length,
                        productData: controller.dataC.products,
                        categoryData: controller.listSearchCategory,
                      );
                    } else if (controller.listSearchCategory.isEmpty &&
                        controller.keywordCategory.value != '') {
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
                      return CategoryList(
                        itemCount: controller.dataC.categories.length,
                        productData: controller.dataC.products,
                        categoryData: controller.dataC.categories,
                      );
                    }
                  }
                }),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
