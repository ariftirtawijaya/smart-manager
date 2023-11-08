import 'package:flutter/material.dart';
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
    this.bottomNavigationBar,
    this.extendBody = false,
    this.actions,
  });

  final String title;
  final Widget body;
  final PreferredSizeWidget? bottom;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool extendBody;
  final List<Widget>? actions;

  final advancedDrawerController = AdvancedDrawerController();
  final authC = Get.find<AuthController>();
  void handleMenuButtonPressed() {
    advancedDrawerController.showDrawer();
  }

  Future<bool> _promptExit() async {
    late bool canExit;
    Future<void> showDialog() async {
      Get.dialog(
        AlertDialog(
          title: const Text('Exit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Are you sure want to exit app ?'),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                        onPressed: () => canExit = false, text: 'No'),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: CustomButton(
                        onPressed: () => canExit = true, text: 'Yes'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    await showDialog();
    return Future.value(canExit);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _promptExit,
      child: AdvancedDrawer(
        drawer: const DrawerWidget(),
        backdrop: Container(color: darkBlue),
        controller: advancedDrawerController,
        animationCurve: Curves.easeInOut,
        // openScale: 1,
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Scaffold(
          extendBody: extendBody,
          appBar: AppBar(
            leading: IconButton(
              onPressed: handleMenuButtonPressed,
              icon: ValueListenableBuilder<AdvancedDrawerValue>(
                valueListenable: advancedDrawerController,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      value.visible
                          ? FontAwesomeIcons.xmark
                          : FontAwesomeIcons.bars,
                      key: ValueKey<bool>(value.visible),
                    ),
                  );
                },
              ),
            ),
            bottom: bottom,
            title: Text(title),
            actions: actions,
          ),
          body: body,
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: bottomNavigationBar,
        ),
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
                imageUrl: dataC.store.value.logo!,
                size: 128,
                borderRadius: const BorderRadius.all(
                  Radius.circular(128.0),
                ),
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
                  dataC.store.value.name!,
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
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
                            width: 48,
                            child: Icon(FontAwesomeIcons.clipboardList)),
                        title: const Text('Report'),
                      ),
                      ListTile(
                        onTap: () {
                          Get.offAllNamed(Routes.PROFILE);
                        },
                        leading: const SizedBox(
                            width: 48, child: Icon(FontAwesomeIcons.userGear)),
                        title: const Text('Profile'),
                      ),
                      ListTile(
                        onTap: () {
                          Get.offAllNamed(Routes.STORE_SETTING);
                        },
                        leading: const SizedBox(
                            width: 48, child: Icon(FontAwesomeIcons.store)),
                        title: const Text('Store Setting'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  authC.currentUser.value.profilePic == null
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
