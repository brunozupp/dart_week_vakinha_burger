import 'package:dart_week_vakinha_burger/app/models/order.dart';
import 'package:dart_week_vakinha_burger/app/models/order_pix.dart';

abstract class OrderRepository {

  Future<OrderPix> createOrder(Order order);
}