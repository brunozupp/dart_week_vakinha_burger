import 'package:get/get.dart';

import 'package:dart_week_vakinha_burger/app/core/services/shopping_card_service.dart';
import 'package:dart_week_vakinha_burger/app/models/product_model.dart';

class ProductDetailController extends GetxController {

  final ShoppingCardService _shoppingCardService;
  
  ProductDetailController({
    required ShoppingCardService shoppingCardService,
  }) : _shoppingCardService = shoppingCardService;

  final _product = Rx<ProductModel>(Get.arguments);
  final _totalPrice = 0.0.obs;
  final _quantity = 1.obs;
  final _alreadyAdded = false.obs;

  ProductModel get product => _product.value;
  double get totalPrice => _totalPrice.value;
  int get quantity => _quantity.value;
  bool get alreadyAdded => _alreadyAdded.value;

  void addProduct() {
    _quantity.value += 1;
  }

  void removeProduct() {

    if(quantity > 1) {
      _quantity.value -= 1;
    }
  }

  void addProductInShoppingCard() {
    _shoppingCardService.addAndRemoveProductInShoppingCard(product, quantity: quantity);

    Get.back();
  }

  @override
  void onInit() {
    super.onInit();

    _totalPrice(product.price);

    ever<int>(_quantity, (quantity) {
      _totalPrice.value = product.price * quantity;
    });

    final productShoppingCard = _shoppingCardService.getById(product.id);

    if(productShoppingCard != null) {
      _quantity(productShoppingCard.quantity);
      _alreadyAdded(true);
    }
  }
}
