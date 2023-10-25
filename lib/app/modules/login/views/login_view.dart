import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/controllers/auth_controller.dart';
import 'package:smart_manager/app/routes/app_pages.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();
    GlobalKey<FormState> loginKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: SvgPicture.asset(
              bgSplash,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: loginKey,
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Get.width * 0.3,
                        child: SvgPicture.asset(
                          logo,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                      ),
                      Text(
                        "Login",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      CustomTextField(
                        controller: authC.loginNumberController,
                        hintText: 'Enter your 7 digits login number',
                        title: 'Number',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Login Number cannot empty';
                          }
                          if (!value.isNumericOnly) {
                            return 'Only number alowed';
                          }
                          if (value.length < 7) {
                            return 'Login Number not valid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      CustomPasswordField(
                        hiddenController: controller.isHidden,
                        controller: authC.passwordController,
                        hintText: 'Enter your password',
                        title: 'Password',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password cannot empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Forgot Password ? ',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.FORGOT),
                            child: Text(
                              'Reset',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: secondaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          width: Get.width,
          child: CustomButton(
            onPressed: () {
              if (loginKey.currentState!.validate()) {
                authC.checkLoginNumber(context);
              }
            },
            text: 'Login',
          ),
        ),
      ),
    );
  }
}
