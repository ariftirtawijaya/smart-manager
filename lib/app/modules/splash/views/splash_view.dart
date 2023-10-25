import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Column(
            children: [
              const Expanded(child: SizedBox()),
              Column(
                children: [
                  SizedBox(
                    width: getWidth(context) * 0.3,
                    child: SvgPicture.memory(
                      logoByteData,
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                  Text(
                    "SMART POS",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                  Text(
                    "MANAGER",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          letterSpacing: 5,
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              const Center(child: CustomProgressIndicator()),
              const SizedBox(
                height: 24.0,
              ),
              Obx(() {
                return Text(
                  controller.status.value,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                      ),
                  // style: size12width400.copyWith(fontWeight: FontWeight.w300),
                );
              }),
              const SizedBox(height: 24.0),
            ],
          ),
          SizedBox(
            height: getHeight(context),
            width: getWidth(context),
            child: SvgPicture.asset(
              bgSplash,
            ),
          ),
        ],
      ),
    );
  }
}
