import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/controllers/auth_controller.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

import '../controllers/forgot_controller.dart';

class ForgotView extends GetView<ForgotController> {
  const ForgotView({super.key});
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
                        width: getWidth(context) * 0.3,
                        child: SvgPicture.memory(
                          logoByteData,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                      ),
                      Text(
                        "Reset Password",
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
                        controller: authC.emailController,
                        hintText: 'Enter your registered email',
                        title: 'Email',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email cannot empty';
                          }
                          if (!value.isEmail) {
                            return 'Email not valid';
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
                            'Remember Password ? ',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Text(
                              'Login',
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
                authC.resetPassword(context);
              }
            },
            text: 'Reset',
          ),
        ),
      ),
    );
  }
}
