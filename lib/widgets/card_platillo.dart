import 'package:flutter/material.dart';

class CardPlatillo extends StatelessWidget {
  final String nombre;
  final String descripcion;
  final NetworkImage imagen;
  final double precio;
  final Function() onTap;
  const CardPlatillo({
    Key? key,
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    required this.precio,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: 220,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nombre,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          descripcion,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '\$' + precio.toStringAsFixed(2),
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Image(
                  image: imagen,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 150,
                ),
              ],
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
