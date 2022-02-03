import 'package:dart_week_vakinha_burger/app/modules/home/home_bindings.dart';
import 'package:dart_week_vakinha_burger/app/modules/home/home_page.dart';
import 'package:dart_week_vakinha_burger/app/modules/product_detail/product_detail_bindings.dart';
import 'package:dart_week_vakinha_burger/app/modules/product_detail/product_detail_page.dart';
import 'package:get/get.dart';

class ProductRouters {

  ProductRouters._();

  static final routers = <GetPage>[
    GetPage(
      name: "/product_detail", 
      page: () => const ProductDetailPage(),
      binding: ProductDetailBindings()
    ),
  ];
}