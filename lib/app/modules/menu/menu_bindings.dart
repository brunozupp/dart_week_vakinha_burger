import 'package:dart_week_vakinha_burger/app/repositories/products/product_repository.dart';
import 'package:dart_week_vakinha_burger/app/repositories/products/product_repository_impl.dart';
import 'package:get/get.dart';
import './menu_controller.dart';

class MenuBindings implements Bindings {
  @override
  void dependencies() {

    Get.lazyPut<ProductRepository>(() => ProductRepositoryImpl(
      restClient: Get.find()
    ));

    Get.put(MenuController(
      productRepository: Get.find()
    ));
  }
}