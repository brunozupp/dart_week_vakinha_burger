import 'package:dart_week_vakinha_burger/app/modules/splash/splash_bindings.dart';
import 'package:dart_week_vakinha_burger/app/modules/splash/splash_page.dart';
import 'package:get/get.dart';

class SplashRouters {

  SplashRouters._();

  static final routers = <GetPage>[
    GetPage(
      name: "/", 
      binding: SplashBindings(),
      page: () => const SplashPage()
    ),
  ];
}