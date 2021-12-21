import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String texto;
  final IconData icono;
  final bool isPassword;
  final TextInputType keyboardType;
  const CustomInput({
    Key? key,
    required this.controller,
    required this.texto,
    required this.icono,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        prefixIcon: Icon(icono),
        labelText: texto,
      ),
      keyboardType: keyboardType,
      obscureText: isPassword,
    );
  }
}
