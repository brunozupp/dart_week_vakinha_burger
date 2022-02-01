import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class VakinhaTextFormField extends StatelessWidget {

  final String label;
  final TextEditingController? controller;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const VakinhaTextFormField({
    Key? key,
    required this.label,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      cursorColor: context.theme.primaryColor,
      decoration: InputDecoration(
        isDense: true, // Diminuir as margens internas
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        errorStyle: const TextStyle(
          color: Colors.redAccent
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(23),
          borderSide: BorderSide(
            color: Colors.grey[400]!
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(23),
          borderSide: BorderSide(
            color: Colors.grey[400]!
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(23),
          borderSide: BorderSide(
            color: Colors.grey[400]!
          )
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
