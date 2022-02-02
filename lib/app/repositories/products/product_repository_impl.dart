import 'dart:developer';

import 'package:dart_week_vakinha_burger/app/core/exceptions/rest_client_exception.dart';
import 'package:dart_week_vakinha_burger/app/core/rest_client/rest_client.dart';
import 'package:dart_week_vakinha_burger/app/models/product_model.dart';

import './product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {

  final RestClient _restClient;

  ProductRepositoryImpl({
    required RestClient restClient
  }): _restClient = restClient;
  
  @override
  Future<List<ProductModel>> findAll() async {
    
    final result = await _restClient.get('/products/');

    if(result.hasError) {

      log(
        'Erro ao buscar produtos ${result.statusCode}',
        error: result.statusText,
        stackTrace: StackTrace.current,
      );

      throw RestClientException('Erro ao buscar produtos');
    }

    return result.body.map<ProductModel>((e) => ProductModel.fromMap(e)).toList();
  }

}