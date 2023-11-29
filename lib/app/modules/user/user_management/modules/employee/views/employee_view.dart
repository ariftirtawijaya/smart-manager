import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_manager/app/constant/app_colors.dart';
import 'package:smart_manager/app/modules/user/user_management/modules/employee/views/component/employee_list.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

import '../controllers/employee_controller.dart';

class EmployeeView extends GetView<EmployeeController> {
  const EmployeeView({super.key});
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
                child: TextFormField(
                  controller: controller.searchC,
                  onChanged: (value) {
                    controller.changeKeyword();
                  },
                  decoration: const InputDecoration(
                    isDense: false,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search Employee',
                    suffixIcon: Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return controller.dataC.getEmployees();
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
                    if (controller.dataC.employees.isEmpty) {
                      return const CustomNoDataWidget(text: 'Employee');
                    } else if (controller.listSearch.isNotEmpty) {
                      return EmployeeList(
                        itemCount: controller.listSearch.length,
                        userData: controller.listSearch,
                      );
                    } else if (controller.listSearch.isEmpty &&
                        controller.keyword.value != '') {
                      return const CustomNoDataWidget(text: 'Employee');
                    } else {
                      return EmployeeList(
                        itemCount: controller.dataC.employees.length,
                        userData: controller.dataC.employees,
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
