import 'package:get/get.dart';
import 'package:smart_manager/app/modules/admin/dashboard_admin/bindings/dashboard_admin_binding.dart';
import 'package:smart_manager/app/modules/admin/dashboard_admin/views/dashboard_admin_view.dart';
import 'package:smart_manager/app/modules/admin/home_admin/bindings/home_admin_binding.dart';
import 'package:smart_manager/app/modules/admin/home_admin/views/home_admin_view.dart';
import 'package:smart_manager/app/modules/admin/profile_admin/bindings/profile_admin_binding.dart';
import 'package:smart_manager/app/modules/admin/profile_admin/views/profile_admin_view.dart';
import 'package:smart_manager/app/modules/admin/users_admin/bindings/users_admin_binding.dart';
import 'package:smart_manager/app/modules/admin/users_admin/views/users_admin_view.dart';
import '../modules/forgot/bindings/forgot_binding.dart';
import '../modules/forgot/views/forgot_view.dart';
import '../modules/loading/bindings/loading_binding.dart';
import '../modules/loading/views/loading_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
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
      name: _Paths.DASHBOARD,
      page: () => const DashboardAdminView(),
      binding: DashboardAdminBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT,
      page: () => const ForgotView(),
      binding: ForgotBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileAdminView(),
      binding: ProfileAdminBinding(),
    ),
    GetPage(
      name: _Paths.USERS,
      page: () => const UsersAdminView(),
      binding: UsersAdminBinding(),
    ),
    GetPage(
      name: _Paths.LOADING,
      page: () => const LoadingView(),
      binding: LoadingBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
