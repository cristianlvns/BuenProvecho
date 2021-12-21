import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String texto;
  final void Function() onPressed;
  final bool extendido;
  const CustomButton({
    Key? key,
    required this.texto,
    required this.onPressed,
    this.extendido = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: SizedBox(
        child: Text(
          texto,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
        width: extendido ? double.infinity : null,
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
