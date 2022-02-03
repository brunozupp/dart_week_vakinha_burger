import 'package:dart_week_vakinha_burger/app/core/rest_client/rest_client.dart';
import 'package:dart_week_vakinha_burger/app/core/services/shopping_card_service.dart';
import 'package:get/get.dart';

class ApplicationBindings implements Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<RestClient>(() => RestClient(), fenix: true);

    Get.lazyPut(() => ShoppingCardService());
  }
  
}