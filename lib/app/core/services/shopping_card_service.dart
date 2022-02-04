import 'package:dart_week_vakinha_burger/app/models/product_model.dart';
import 'package:dart_week_vakinha_burger/app/models/shopping_card_model.dart';
import 'package:get/get.dart';

class ShoppingCardService extends GetxService {
  
  final _shoppingCard = <int, ShoppingCardModel>{}.obs;

  List<ShoppingCardModel> get products => _shoppingCard.values.toList();

  int get totalProducts => _shoppingCard.values.length;

  // double get totalValue {

  //   var listOfTotalPerProduct = products.map((shoppingCardModel) => shoppingCardModel.quantity * shoppingCardModel.product.price);

  //   var sum = listOfTotalPerProduct.reduce((value, element) => value + element);

  //   return sum;
  // }

  double get totalValue {
    return _shoppingCard.values.fold(0, (totalValue, shoppingCardModel) {
      return totalValue += shoppingCardModel.quantity * shoppingCardModel.product.price;
    });
  }

  ShoppingCardModel? getById(int id) => _shoppingCard[id];

  void addAndRemoveProductInShoppingCard(ProductModel product, {required int quantity}) {

    if(quantity == 0) {
      _shoppingCard.remove(product.id);
    } else {

      _shoppingCard.update(product.id, (product) {
        product.quantity = quantity;
        return product;
      }, ifAbsent: () {
        return ShoppingCardModel(
          quantity: quantity,
          product: product
        );
      });
    }
  }

  void clear() => _shoppingCard.clear();
  
}