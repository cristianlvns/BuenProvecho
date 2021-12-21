import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  const CustomAlert({
    Key? key,
    required this.titulo,
    required this.subtitulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titulo),
      content: Text(subtitulo),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
