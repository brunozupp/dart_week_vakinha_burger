import 'package:dart_week_vakinha_burger/app/modules/auth/login/login_page.dart';
import 'package:dart_week_vakinha_burger/app/modules/auth/register/register_page.dart';
import 'package:get/get.dart';

class AuthRouters {

  AuthRouters._();

  static final routers = <GetPage>[
    GetPage(name: "/auth/login", page: () => const LoginPage()),
    GetPage(name: "/auth/register", page: () => const RegisterPage()),
  ];
}