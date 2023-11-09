import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/data/models/store_model.dart';
import 'package:smart_manager/app/data/models/user_model.dart';
import 'package:smart_manager/app/data/services/db_service.dart';
import 'package:smart_manager/app/modules/admin/users_admin/controllers/users_admin_controller.dart';
import 'package:smart_manager/app/modules/admin/users_admin/views/users_admin_edit.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class UsersAdminDetailView extends GetView<UsersAdminController> {
  const UsersAdminDetailView({super.key});

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
                      Text(
                        'Status',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(user.active == true ? 'Active' : 'Inactive',
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
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        'Address',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(user.address!,
                          style: Theme.of(context).textTheme.titleMedium!),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: DBService.getCollections(
                    from: storesRef, where: 'userId', isEqualTo: user.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                        baseColor: grey3,
                        highlightColor: grey4,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          width: Get.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                child: Text(
                                  'Store Info',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
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
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                child: Text(
                                  'Store Name',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                child: Text("storeData.name!",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                child: Text(
                                  'Total Employee',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                child: Text(user.phone!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                child: Text(
                                  'Total Product',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                child: Text(user.phone!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!),
                              ),
                            ],
                          ),
                        ));
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (snapshot.data!.docs.isNotEmpty) {
                    final StoreModel storeData =
                        StoreModel.fromSnapshot(snapshot.data!.docs.first);
                    return Card(
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
                            Text(storeData.name!,
                                style:
                                    Theme.of(context).textTheme.titleMedium!),
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
                            FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                future: FirebaseFirestore.instance
                                    .collection('stores')
                                    .doc(storeData.id)
                                    .collection('employees')
                                    .get(),
                                builder: (context, snapshot) {
                                  return Text(
                                      "${snapshot.data?.docs.length ?? '0'}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!);
                                }),
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
                            FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                future: FirebaseFirestore.instance
                                    .collection('stores')
                                    .doc(storeData.id)
                                    .collection('products')
                                    .get(),
                                builder: (context, snapshot) {
                                  return Text(
                                      "${snapshot.data?.docs.length ?? '0'}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!);
                                }),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -5),
              color: grey3,
              blurRadius: 4,
            )
          ],
        ),
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                onPressed: () {
                  Get.back();
                  Get.to(() => const UsersAdminEdit(), arguments: user);
                },
                text: 'Edit',
              ),
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: CustomButton(
                color: red,
                onPressed: () {
                  controller.deleteUser(
                    context,
                    user,
                    true,
                  );
                },
                text: 'Delete',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
