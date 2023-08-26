import 'package:get/get.dart';
import 'package:addon/app/modules/bindings/home_binding.dart';
import 'package:addon/app/modules/views/home_view.dart';
import 'package:addon/app/modules/bindings/login_binding.dart';
import 'package:addon/app/modules/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
