import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

import '../controllers/create_store_controller.dart';

class CreateStoreView extends GetView<CreateStoreController> {
  const CreateStoreView({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> addStoreKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Store'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: addStoreKey,
            child: Column(
              children: [
                GetBuilder<CreateStoreController>(builder: (controller) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                    image:
                                        FileImage(File(controller.imagePath)),
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
                                ? 'Change Image'
                                : 'Choose Image')
                      ],
                    ),
                  );
                }),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTextField(
                  onChanged: (p0) {
                    if (p0.isNotEmpty) {
                      addStoreKey.currentState!.validate();
                    }
                  },
                  controller: controller.nameController,
                  title: 'Store Name',
                  hintText: 'Input your store name',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Store name cannot empty\n';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (p0) {
                    if (p0.isNotEmpty) {
                      addStoreKey.currentState!.validate();
                    }
                  },
                  controller: controller.emailController,
                  title: 'Store Email',
                  hintText: 'store@email.com',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Store email cannot empty\n';
                    }
                    if (!value.isEmail) {
                      return 'Store email not valid\n';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTextField(
                  keyboardType: TextInputType.phone,
                  onChanged: (p0) {
                    if (p0.isNotEmpty) {
                      addStoreKey.currentState!.validate();
                    }
                  },
                  controller: controller.phoneController,
                  title: 'Store Phone',
                  hintText: 'Store Phone',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Store phone cannot empty\n';
                    }
                    if (!value.isPhoneNumber) {
                      return 'Store phone not valid\n';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTextField(
                  onChanged: (p0) {
                    if (p0.isNotEmpty) {
                      addStoreKey.currentState!.validate();
                    }
                  },
                  controller: controller.addressController,
                  title: 'Store Address',
                  hintText: 'Enter your store address',
                  maxLines: 4,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Store address cannot empty\n';
                    }
                    if (value.length < 10) {
                      return 'Store address to short';
                    }
                    return null;
                  },
                ),
              ],
            ),
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
        child: CustomButton(
          onPressed: () {
            if (addStoreKey.currentState!.validate()) {
              controller.createStore(context);
            }
          },
          text: 'Create',
        ),
      ),
    );
  }
}
