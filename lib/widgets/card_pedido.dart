import 'package:buen_provecho/models/pedido.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardPedido extends StatelessWidget {
  final DateTime fecha;
  final double monto;
  final String estatus;
  final List<Item> items;

  const CardPedido({
    Key? key,
    required this.fecha,
    required this.monto,
    required this.estatus,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Realizado el ' + formatFecha(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            Text('Monto: \$' + monto.toStringAsFixed(2)),
            Text(
              'Platillos: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              children: items
                  .map((e) => Text(e.nombre +
                      ' • Cantidad: ' +
                      e.cantidad.toString() +
                      ' • P.U: \$' +
                      e.precio.toStringAsFixed(2)))
                  .toList(),
            ),
            Text(
              'Estatus: ' + estatus,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  String formatFecha() {
    DateFormat format = DateFormat('d/M/yyyy');
    return format.format(fecha);
  }
}
