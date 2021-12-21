import 'package:flutter/material.dart';

class CardRestaurante extends StatelessWidget {
  final String nombre;
  final String tipo;
  final NetworkImage imagen;
  final String direccion;
  final Function() onTap;
  const CardRestaurante({
    Key? key,
    required this.nombre,
    required this.tipo,
    required this.imagen,
    required this.direccion,
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
                        tipo,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        direccion,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
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
