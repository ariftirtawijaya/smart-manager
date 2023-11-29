import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/modules/user/user_management/modules/role/views/components/role_list.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

import '../controllers/role_controller.dart';

class RoleView extends GetView<RoleController> {
  const RoleView({super.key});
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
            Container(
              decoration: BoxDecoration(
                color: primaryColor,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 4),
                    color: black.withOpacity(0.3),
                    blurRadius: 10,
                  ),
                ],
              ),
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Obx(() => TextFormField(
                      controller: controller.searchC,
                      onChanged: (value) {
                        controller.changeKeyword();
                      },
                      decoration: InputDecoration(
                        isDense: false,
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search Role',
                        suffixIcon: controller.keyword.isEmpty
                            ? const Icon(
                                FontAwesomeIcons.magnifyingGlass,
                                color: primaryColor,
                              )
                            : IconButton(
                                onPressed: () {
                                  controller.clearSearch();
                                },
                                icon: const Icon(FontAwesomeIcons.xmark)),
                      ),
                    )),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return controller.dataC.getRoles();
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
                    if (controller.dataC.roles.isEmpty) {
                      return const CustomNoDataWidget(text: 'Role');
                    } else if (controller.listSearch.isNotEmpty) {
                      return RoleList(
                        itemCount: controller.listSearch.length,
                        roleData: controller.listSearch,
                      );
                    } else if (controller.listSearch.isEmpty &&
                        controller.keyword.value != '') {
                      return const CustomNoDataWidget(text: 'Role');
                    } else {
                      return RoleList(
                        itemCount: controller.dataC.roles.length,
                        roleData: controller.dataC.roles,
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
