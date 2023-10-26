import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/modules/admin/users_admin/controllers/users_admin_controller.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class UsersAdminAddView extends GetView<UsersAdminController> {
  const UsersAdminAddView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> addUserKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: addUserKey,
            child: Column(
              children: [
                GetBuilder<UsersAdminController>(builder: (controller) {
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
                            ? Image.file(
                                File(
                                  controller.imagePath,
                                ),
                                height: 48,
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
                      addUserKey.currentState!.validate();
                    }
                  },
                  controller: controller.nameController,
                  title: 'Name',
                  hintText: 'Full name',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name cannot empty\n';
                    }
                    if (value.length < 3) {
                      return 'Name to short';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomDropdownField(
                  items: controller.genderList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (p0) {
                    controller.genderController.text = p0;
                    print(p0);
                    print(controller.genderController.text);
                  },
                  controller: controller.genderController,
                  title: 'Gender',
                  hintText: 'Select gender',
                  validator: (v) {
                    String? value = v;
                    if (value == null) {
                      return 'Gender cannot empty\n';
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
                      addUserKey.currentState!.validate();
                    }
                  },
                  controller: controller.loginNumberController,
                  title: 'Login Number',
                  hintText: '7 digits login number',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Login Number cannot empty\n';
                    }
                    if (!value.isNumericOnly) {
                      return 'Login number not valid\n';
                    }
                    if (value.length < 7) {
                      return 'Name to short';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomPasswordField(
                  onChanged: (p0) {
                    if (p0.isNotEmpty) {
                      addUserKey.currentState!.validate();
                    }
                  },
                  controller: controller.passwordController,
                  title: 'Password',
                  hintText: '*******',
                  hiddenController: controller.isHidden,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password cannot empty\n';
                    }
                    if (value.length < 7) {
                      return 'Password to weak\n';
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
                      addUserKey.currentState!.validate();
                    }
                  },
                  controller: controller.emailController,
                  title: 'Email',
                  hintText: 'email@gmail.com',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email cannot empty\n';
                    }
                    if (!value.isEmail) {
                      return 'Email not valid\n';
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
                      addUserKey.currentState!.validate();
                    }
                  },
                  controller: controller.phoneController,
                  title: 'Phone Number',
                  hintText: 'Phone number',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Phone number cannot empty\n';
                    }
                    if (!value.isPhoneNumber) {
                      return 'Phone number not valid\n';
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
                      addUserKey.currentState!.validate();
                    }
                  },
                  controller: controller.addressController,
                  title: 'Address',
                  hintText: 'Enter user full address',
                  maxLines: 4,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Address cannot empty\n';
                    }
                    if (value.length < 10) {
                      return 'Address to short';
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
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
        child: CustomButton(
          onPressed: () {
            if (addUserKey.currentState!.validate()) {
              controller.createUser(context);
            }
          },
          text: 'Add',
        ),
      ),
    );
  }
}
