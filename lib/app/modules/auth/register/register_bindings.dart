import 'package:dart_week_vakinha_burger/app/modules/auth/register/register_controller.dart';
import 'package:dart_week_vakinha_burger/app/repositories/auth/auth_repository.dart';
import 'package:dart_week_vakinha_burger/app/repositories/auth/auth_repository_impl.dart';
import 'package:get/get.dart';

class RegisterBindings implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(
      restClient: Get.find()
    ));

    Get.lazyPut<RegisterController>(() => RegisterController(
      authRepository: Get.find()
    ));
  }

}