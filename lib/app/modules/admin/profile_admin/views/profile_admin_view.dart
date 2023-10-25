import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/data/models/user_model.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

import '../controllers/profile_admin_controller.dart';

class ProfileAdminView extends GetView<ProfileAdminController> {
  const ProfileAdminView({super.key});
  @override
  Widget build(BuildContext context) {
    final UserModel me = controller.authC.currentUser.value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            me.profilePic == null
                ? Center(
                    child: Container(
                      width: Get.width * 0.3,
                      height: Get.width * 0.3,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imagePlaceholder),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: CachedNetworkImage(
                      imageUrl: me.profilePic!,
                      imageBuilder: (context, imageProvider) => Container(
                        width: Get.width * 0.3,
                        height: Get.width * 0.3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(80.0),
                          ),
                        ),
                      ),
                      placeholder: (context, url) {
                        return Shimmer.fromColors(
                            baseColor: grey3,
                            highlightColor: grey4,
                            child: Container(
                              width: Get.width * 0.3,
                              height: Get.width * 0.3,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(imagePlaceholder),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ));
                      },
                      errorWidget: (context, url, error) {
                        return Container(
                          width: Get.width * 0.3,
                          height: Get.width * 0.3,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(imagePlaceholder),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            const SizedBox(
              height: 16.0,
            ),
            Center(
              child: Text(
                me.name!,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Center(
              child: Text(
                me.role!.capitalize!,
                style: Theme.of(context).textTheme.titleMedium!,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Center(
              child: Text(
                me.email!,
                style: Theme.of(context).textTheme.titleMedium!,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            CustomListMenu(
              ontap: () {},
              title: 'Edit Profile',
            ),
            const SizedBox(
              height: 8.0,
            ),
            CustomListMenu(
              ontap: () {},
              title: 'Change Password',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: (kBottomNavigationBarHeight * 2) + 8,
        ),
        child: CustomButton(
          onPressed: () async {
            await controller.authC.signOut(context);
          },
          text: 'Logout',
        ),
      ),
    );
  }
}
