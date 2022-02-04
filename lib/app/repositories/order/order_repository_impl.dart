import 'dart:developer';

import 'package:dart_week_vakinha_burger/app/core/exceptions/rest_client_exception.dart';
import 'package:dart_week_vakinha_burger/app/core/rest_client/rest_client.dart';
import 'package:dart_week_vakinha_burger/app/models/order_pix.dart';
import 'package:dart_week_vakinha_burger/app/models/order.dart';
import 'package:dart_week_vakinha_burger/app/repositories/order/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {

  final RestClient _restClient;

  OrderRepositoryImpl({
    required RestClient restClient
  }) : _restClient = restClient;

  @override
  Future<OrderPix> createOrder(Order order) async {
    
    var body = {
      "userId": order.userId,
      "cpf": order.cpf,
      "address": order.address,
      "items": order.items.map((shoppingCard) => {
        'quantity': shoppingCard.quantity,
        'productId': shoppingCard.product.id
      }).toList(),
    };

    final result = await _restClient.post('/order/', body);

    if(result.hasError) {
      log(
        "Erro ao realizar pedido ${result.statusCode}",
        error: result.statusText,
        stackTrace: StackTrace.current
      );
      throw RestClientException("Erro ao realizar pedido");
    }

    return OrderPix.fromMap(result.body);
  }

}