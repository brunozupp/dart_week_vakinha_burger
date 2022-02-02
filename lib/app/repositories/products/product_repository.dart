import 'package:dart_week_vakinha_burger/app/models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> findAll();
}