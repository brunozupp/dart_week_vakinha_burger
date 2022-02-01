import 'package:flutter/material.dart';

class VakinhaAppBar extends AppBar {
  
  VakinhaAppBar({ 
    Key? key,
    double elevation = 2 
  }) : super(
    key: key,
    backgroundColor: Colors.white,
    elevation: elevation,
    centerTitle: true,
    title: Image.asset(
      "assets/images/logo.png",
      width: 80,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black
    )
  );

}