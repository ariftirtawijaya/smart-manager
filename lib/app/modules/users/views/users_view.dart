import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/data/models/user_model.dart';
import 'package:smart_manager/app/modules/users/views/users_add.dart';
import 'package:smart_manager/app/modules/users/views/users_detail.dart';

import '../controllers/users_controller.dart';

class UsersView extends GetView<UsersController> {
  const UsersView({super.key});
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
                Get.to(() => const UsersAddView());
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
                  decoration: InputDecoration(
                    isDense: false,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search Users',
                    suffixIcon: IconButton(
                      onPressed: () {
                        print('pressed');
                      },
                      icon: const Icon(
                        Icons.search,
                        color: primaryColor,
                      ),
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
                    } else {
                      return ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: controller.dataC.users.length,
                        itemBuilder: (context, index) {
                          final UserModel user = controller.dataC.users[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 16, right: 16),
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
                                overlayColor: const MaterialStatePropertyAll(
                                    primaryColor),
                                onTap: () {
                                  Get.to(() => const UsersDetailView(),
                                      arguments: user);
                                },
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  title: Text(
                                    user.name!.capitalize!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: user.profilePic == null
                                      ? Image.asset(
                                          imagePlaceholder,
                                          height: 52,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: user.profilePic!,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 52,
                                            height: 52,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) {
                                            return Shimmer.fromColors(
                                              baseColor: grey3,
                                              highlightColor: grey4,
                                              child: Image.asset(
                                                imagePlaceholder,
                                                height: 52,
                                              ),
                                            );
                                          },
                                          errorWidget: (context, url, error) {
                                            return Image.asset(
                                              imagePlaceholder,
                                              height: 52,
                                            );
                                          },
                                        ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        edit,
                                        colorFilter: const ColorFilter.mode(
                                            secondaryColor, BlendMode.srcIn),
                                      ),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      SvgPicture.asset(
                                        delete,
                                        colorFilter: const ColorFilter.mode(
                                            secondaryColor, BlendMode.srcIn),
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
