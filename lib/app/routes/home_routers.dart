import 'package:dart_week_vakinha_burger/app/modules/home/home_bindings.dart';
import 'package:dart_week_vakinha_burger/app/modules/home/home_page.dart';
import 'package:get/get.dart';

class HomeRouters {

  HomeRouters._();

  static final routers = <GetPage>[
    GetPage(
      name: "/home", 
      page: () => const HomePage(),
      binding: HomeBindings()
    ),
  ];
}