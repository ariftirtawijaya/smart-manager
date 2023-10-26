import 'package:get/get.dart';
import 'package:smart_manager/app/modules/user/inventory/views/inventory_dashboard.dart';

import '../modules/admin/dashboard_admin/bindings/dashboard_admin_binding.dart';
import '../modules/admin/dashboard_admin/views/dashboard_admin_view.dart';
import '../modules/admin/home_admin/bindings/home_admin_binding.dart';
import '../modules/admin/home_admin/views/home_admin_view.dart';
import '../modules/admin/profile_admin/bindings/profile_admin_binding.dart';
import '../modules/admin/profile_admin/views/profile_admin_view.dart';
import '../modules/admin/users_admin/bindings/users_admin_binding.dart';
import '../modules/admin/users_admin/views/users_admin_view.dart';
import '../modules/create_store/bindings/create_store_binding.dart';
import '../modules/create_store/views/create_store_view.dart';
import '../modules/forgot/bindings/forgot_binding.dart';
import '../modules/forgot/views/forgot_view.dart';
import '../modules/loading/bindings/loading_binding.dart';
import '../modules/loading/views/loading_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/user/dashboard_user/bindings/dashboard_user_binding.dart';
import '../modules/user/dashboard_user/views/dashboard_user_view.dart';
import '../modules/user/inventory/bindings/inventory_binding.dart';
import '../modules/user/inventory/views/inventory_view.dart';
import '../modules/user/profile/bindings/profile_binding.dart';
import '../modules/user/profile/views/profile_view.dart';
import '../modules/user/report/bindings/report_binding.dart';
import '../modules/user/report/views/report_view.dart';
import '../modules/user/store_setting/bindings/store_setting_binding.dart';
import '../modules/user/store_setting/views/store_setting_view.dart';
import '../modules/user/transaction/bindings/transaction_binding.dart';
import '../modules/user/transaction/views/transaction_view.dart';
import '../modules/user/user_management/bindings/user_management_binding.dart';
import '../modules/user/user_management/views/user_management_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME_ADMIN,
      page: () => const HomeAdminView(),
      binding: HomeAdminBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      transition: Transition.fadeIn,
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_ADMIN,
      page: () => const DashboardAdminView(),
      binding: DashboardAdminBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT,
      page: () => const ForgotView(),
      binding: ForgotBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_ADMIN,
      page: () => const ProfileAdminView(),
      binding: ProfileAdminBinding(),
    ),
    GetPage(
      name: _Paths.USERS_ADMIN,
      page: () => const UsersAdminView(),
      binding: UsersAdminBinding(),
    ),
    GetPage(
      name: _Paths.LOADING,
      page: () => const LoadingView(),
      binding: LoadingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.DASHBOARD_USER,
      page: () => const DashboardUserView(),
      binding: DashboardUserBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(
        milliseconds: 250,
      ),
    ),
    GetPage(
      name: _Paths.CREATE_STORE,
      page: () => const CreateStoreView(),
      binding: CreateStoreBinding(),
    ),
    GetPage(
      name: _Paths.INVENTORY,
      page: () => const InventoryDashboardView(),
      binding: InventoryBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(
        milliseconds: 250,
      ),
    ),
    GetPage(
      name: _Paths.USER_MANAGEMENT,
      page: () => const UserManagementView(),
      binding: UserManagementBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(
        milliseconds: 250,
      ),
    ),
    GetPage(
      name: _Paths.TRANSACTION,
      page: () => const TransactionView(),
      binding: TransactionBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(
        milliseconds: 250,
      ),
    ),
    GetPage(
      name: _Paths.REPORT,
      page: () => const ReportView(),
      binding: ReportBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(
        milliseconds: 250,
      ),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(
        milliseconds: 250,
      ),
    ),
    GetPage(
      name: _Paths.STORE_SETTING,
      page: () => const StoreSettingView(),
      binding: StoreSettingBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(
        milliseconds: 250,
      ),
    ),
  ];
}
