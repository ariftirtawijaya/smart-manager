import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/modules/admin/users_admin/views/components/user_list.dart';
import 'package:smart_manager/app/modules/admin/users_admin/views/users_admin_add.dart';

import '../controllers/users_admin_controller.dart';

class UsersAdminView extends GetView<UsersAdminController> {
  const UsersAdminView({super.key});
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
        appBar: AppBar(
          title: const Text('List Users'),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                controller.clear();
                Get.to(() => const UsersAdminAddView());
              },
              child: SvgPicture.asset(
                plusSquare,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(
              width: 16.0,
            ),
          ],
        ),
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
                    hintText: 'Search Users',
                    suffixIcon: Icon(
                      Icons.search,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return controller.dataC.getUsers();
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
                    if (controller.dataC.users.isEmpty) {
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
                    } else if (controller.listSearch.isNotEmpty) {
                      print('1');

                      return UsersList(
                        itemCount: controller.listSearch.length,
                        userData: controller.listSearch,
                      );
                    } else if (controller.listSearch.isEmpty &&
                        controller.keyword.value != '') {
                      print('2');
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
                      print('3');

                      return UsersList(
                        itemCount: controller.dataC.users.length,
                        userData: controller.dataC.users,
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
