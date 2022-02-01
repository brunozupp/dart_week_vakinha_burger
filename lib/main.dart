import 'package:dart_week_vakinha_burger/app/core/bindings/application_bindings.dart';
import 'package:dart_week_vakinha_burger/app/core/ui/vakinha_ui.dart';
import 'package:dart_week_vakinha_burger/app/routes/auth_routers.dart';
import 'package:dart_week_vakinha_burger/app/routes/splash_routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const VakinhaBurgerMainApp());
}

class VakinhaBurgerMainApp extends StatelessWidget {
  const VakinhaBurgerMainApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Vakinha Burger",
      theme: VakinhaUI.theme,
      initialBinding: ApplicationBindings(),
      getPages: [
        ...SplashRouters.routers,
        ...AuthRouters.routers,
      ],
    );
  }
}