import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/controllers/auth_controller.dart';
import 'package:smart_manager/app/controllers/data_controller.dart';
import 'package:smart_manager/app/routes/app_pages.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class CustomUserPage extends StatelessWidget {
  CustomUserPage({
    super.key,
    required this.title,
    required this.body,
    this.bottom,
    this.floatingActionButton,
  });

  final String title;
  final Widget body;
  final PreferredSizeWidget? bottom;
  final Widget? floatingActionButton;

  final advancedDrawerController = AdvancedDrawerController();
  final authC = Get.find<AuthController>();
  void handleMenuButtonPressed() {
    advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      drawer: const DrawerWidget(),
      backdrop: Container(color: darkBlue),
      controller: advancedDrawerController,
      animationCurve: Curves.easeInOut,
      // openScale: 1,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          bottom: bottom,
          title: Text(title),
        ),
        body: body,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();
    final dataC = Get.find<DataController>();
    return SafeArea(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomImageView(
                imageUrl: dataC.store.value.storeLogo!,
                size: 128,
                radius: 128,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: secondaryColor),
                ),
                padding: const EdgeInsets.all(8),
                child: Text(
                  dataC.store.value.storeName!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              ListTile(
                onTap: () {
                  Get.offAllNamed(Routes.DASHBOARD_USER);
                },
                leading: const SizedBox(
                    width: 48, child: Icon(FontAwesomeIcons.house)),
                title: const Text('Dashboard'),
              ),
              ListTile(
                onTap: () {
                  Get.offAllNamed(Routes.INVENTORY);
                },
                leading: const SizedBox(
                    width: 48, child: Icon(FontAwesomeIcons.box)),
                title: const Text('Inventory'),
              ),
              ListTile(
                onTap: () {
                  Get.offAllNamed(Routes.USER_MANAGEMENT);
                },
                leading: const SizedBox(
                    width: 48, child: Icon(FontAwesomeIcons.users)),
                title: const Text('User Management'),
              ),
              ListTile(
                onTap: () {
                  Get.offAllNamed(Routes.TRANSACTION);
                },
                leading: const SizedBox(
                    width: 48, child: Icon(FontAwesomeIcons.moneyBill)),
                title: const Text('Transaction'),
              ),
              ListTile(
                onTap: () {
                  Get.offAllNamed(Routes.REPORT);
                },
                leading: const SizedBox(
                    width: 48, child: Icon(FontAwesomeIcons.clipboardList)),
                title: const Text('Report'),
              ),
              ListTile(
                onTap: () {
                  Get.offAllNamed(Routes.PROFILE);
                },
                leading: const SizedBox(
                    width: 48, child: Icon(FontAwesomeIcons.userGear)),
                title: const Text('Account'),
              ),
              ListTile(
                onTap: () {
                  Get.offAllNamed(Routes.STORE_SETTING);
                },
                leading: const SizedBox(
                    width: 48, child: Icon(FontAwesomeIcons.store)),
                title: const Text('Store Setting'),
              ),
              const Spacer(),
              Row(
                children: [
                  authC.currentUser.value.profilePic != null
                      ? Image.asset(
                          imagePlaceholder,
                          width: 48,
                        )
                      : CustomImageView(
                          imageUrl: authC.currentUser.value.profilePic!,
                          size: 48,
                        ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authC.currentUser.value.name!,
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Text(
                        authC.currentUser.value.role! == 'user'
                            ? 'Store Owner'
                            : '',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              CustomButton(
                  onPressed: () {
                    authC.signOut(context);
                  },
                  text: 'Logout'),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
