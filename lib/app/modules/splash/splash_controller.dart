import 'package:dart_week_vakinha_burger/app/core/services/auth_service.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  void checkLogged() {
    Get.putAsync(() => AuthService().init());
  }
}