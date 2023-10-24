import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/data/models/user_model.dart';

class UsersDetailView extends GetView {
  const UsersDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel user = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 5,
                shadowColor: grey3,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: grey3,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      user.profilePic == null
                          ? Center(
                              child: Container(
                                width: Get.width * 0.35,
                                height: Get.width * 0.35,
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
                                imageUrl: user.profilePic!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: Get.width * 0.35,
                                  height: Get.width * 0.35,
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
                                        width: Get.width * 0.35,
                                        height: Get.width * 0.35,
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
                                    width: Get.width * 0.35,
                                    height: Get.width * 0.35,
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
                      Text(
                        'Name',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(user.name!.capitalize!,
                          style: Theme.of(context).textTheme.titleMedium!),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        'ID',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(user.loginNumber!,
                          style: Theme.of(context).textTheme.titleMedium!),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        'Gender',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(user.gender!.capitalizeFirst!,
                          style: Theme.of(context).textTheme.titleMedium!),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Card(
                elevation: 5,
                shadowColor: grey3,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: grey3,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Info',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Divider(
                        thickness: 2,
                        color: grey3,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Email',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(user.email!,
                          style: Theme.of(context).textTheme.titleMedium!),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        'Phone Number',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(user.phone!,
                          style: Theme.of(context).textTheme.titleMedium!),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Card(
                elevation: 5,
                shadowColor: grey3,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: grey3,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Store Info',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Divider(
                        thickness: 2,
                        color: grey3,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Store Name',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(user.email!,
                          style: Theme.of(context).textTheme.titleMedium!),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        'Total Employee',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(user.phone!,
                          style: Theme.of(context).textTheme.titleMedium!),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        'Total Product',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(user.phone!,
                          style: Theme.of(context).textTheme.titleMedium!),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
