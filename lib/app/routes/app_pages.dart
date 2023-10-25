import 'package:get/get.dart';

import '../modules/admin/dashboard_admin/bindings/dashboard_admin_binding.dart';
import '../modules/admin/dashboard_admin/views/dashboard_admin_view.dart';
import '../modules/admin/home_admin/bindings/home_admin_binding.dart';
import '../modules/admin/home_admin/views/home_admin_view.dart';
import '../modules/admin/profile_admin/bindings/profile_admin_binding.dart';
import '../modules/admin/profile_admin/views/profile_admin_view.dart';
import '../modules/admin/users_admin/bindings/users_admin_binding.dart';
import '../modules/admin/users_admin/views/users_admin_view.dart';
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
import '../modules/user/home_user/bindings/home_user_binding.dart';
import '../modules/user/home_user/views/home_user_view.dart';
import '../modules/user/profile_user/bindings/profile_user_binding.dart';
import '../modules/user/profile_user/views/profile_user_view.dart';

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
    ),
    GetPage(
      name: _Paths.HOME_USER,
      page: () => const HomeUserView(),
      binding: HomeUserBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_USER,
      page: () => const ProfileUserView(),
      binding: ProfileUserBinding(),
    ),
  ];
}
