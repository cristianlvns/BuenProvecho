import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String nombre;
  final int cantidad;
  final double precioUnitario;

  const CardItem({
    Key? key,
    required this.nombre,
    required this.cantidad,
    required this.precioUnitario,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nombre,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Cantidad: ' + cantidad.toString()),
            Text('Precio Unitario: \$' + precioUnitario.toStringAsFixed(2)),
            Text('Total: \$' + (precioUnitario * cantidad).toStringAsFixed(2)),
          ],
        ),
      ),
    );
  }
}
