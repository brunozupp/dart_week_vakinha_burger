import 'package:dart_week_vakinha_burger/app/core/exceptions/rest_client_exception.dart';
import 'package:dart_week_vakinha_burger/app/core/mixins/loader_mixin.dart';
import 'package:dart_week_vakinha_burger/app/core/mixins/messages_mixin.dart';
import 'package:dart_week_vakinha_burger/app/models/order.dart';
import 'package:dart_week_vakinha_burger/app/models/shopping_card_model.dart';
import 'package:dart_week_vakinha_burger/app/modules/home/home_controller.dart';
import 'package:dart_week_vakinha_burger/app/repositories/order/order_repository.dart';
import 'package:get/get.dart';

import 'package:dart_week_vakinha_burger/app/core/services/auth_service.dart';
import 'package:dart_week_vakinha_burger/app/core/services/shopping_card_service.dart';

class ShoppingCardController extends GetxController with LoaderMixin, MessagesMixin {

  final AuthService _authService;
  final ShoppingCardService _shoppingCardService;
  final OrderRepository _orderRepository;

  ShoppingCardController({
    required AuthService authService,
    required ShoppingCardService shoppingCardService,
    required OrderRepository orderRepository
  }) : _authService = authService,
       _shoppingCardService = shoppingCardService,
       _orderRepository = orderRepository;

  final _address = ''.obs;
  final _cpf = ''.obs;

  set address(String value) => _address(value);
  set cpf(String value) => _cpf(value);

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  List<ShoppingCardModel> get products => _shoppingCardService.products;

  double get totalValue => _shoppingCardService.totalValue;

  void addQuantityInProduct(ShoppingCardModel shoppingCardModel) {
    _shoppingCardService.addAndRemoveProductInShoppingCard(
      shoppingCardModel.product, 
      quantity: shoppingCardModel.quantity + 1
    );
  }

  void subtractQuantityInProduct(ShoppingCardModel shoppingCardModel) {
    _shoppingCardService.addAndRemoveProductInShoppingCard(
      shoppingCardModel.product, 
      quantity: shoppingCardModel.quantity - 1
    );
  }

  void clear() => _shoppingCardService.clear();

  Future<void> createOrder() async {

    final userId = _authService.getUserId();

    final order = Order(
      userId: userId!, 
      cpf: _cpf.value, 
      address: _address.value, 
      items: products
    );

    _loading(true);

    try {
      var orderPix = await _orderRepository.createOrder(order);

      _loading(false);

      orderPix = orderPix.copyWith(
        totalValue: totalValue
      );

      clear();

      Get.offNamed('/orders/finished', arguments: orderPix);

      Get.back(id: HomeController.NAVIGATOR_KEY);
    } on RestClientException catch (e) {
      _loading(false);

      _message(MessageModel(
        title: "Erro!", 
        message: e.message, 
        type: MessageType.error
      ));
    } catch(e) {
      _loading(false);

      _message(MessageModel(
        title: "Erro!", 
        message: "Erro ao finalizar pedido", 
        type: MessageType.error
      ));
    }
  }

  @override
  void onInit() {
    super.onInit();

    loaderListener(_loading);
    messageListener(_message);
  }
}
