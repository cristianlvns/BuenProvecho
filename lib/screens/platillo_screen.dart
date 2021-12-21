import 'package:buen_provecho/models/pedido.dart';
import 'package:buen_provecho/models/platillo.dart';
import 'package:buen_provecho/services/login_service.dart';
import 'package:buen_provecho/services/pedido_service.dart';
import 'package:buen_provecho/services/platillo_service.dart';
import 'package:buen_provecho/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:provider/provider.dart';

class PlatilloScreen extends StatefulWidget {
  PlatilloScreen({Key? key}) : super(key: key);

  @override
  _PlatilloScreenState createState() => _PlatilloScreenState();
}

class _PlatilloScreenState extends State<PlatilloScreen> {
  late PedidoService pedidoService;
  late LoginService usuarioService;
  late PlatilloService platilloService;
  late Platillo platillo;
  int cantidad = 1;

  @override
  void initState() {
    super.initState();
    pedidoService = Provider.of<PedidoService>(context, listen: false);
    usuarioService = Provider.of<LoginService>(context, listen: false);
    platilloService = Provider.of<PlatilloService>(context, listen: false);
    //_cargarPlatillo();
  }

  /*void _cargarPlatillo() async {
    platillo = await platilloService
        .obtenerPlatillo(platilloService.platilloSeleccionado!.platilloid);
    setState(() {});
  }*/

  @override
  Widget build(BuildContext context) {
    final platillo = platilloService.platilloSeleccionado;
    return Scaffold(
      appBar: AppBar(
        title: Text(platillo!.nombre),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image(
              image: NetworkImage(platillo.imagen),
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text(platillo.nombre),
              subtitle: Text('Precio: \$' + platillo.precio.toString()),
            ),
            SpinBox(
              min: 1,
              max: 10,
              value: 1,
              decimals: 0,
              step: 1,
              acceleration: null,
              decoration: const InputDecoration(
                labelText: 'Cantidad',
              ),
              onChanged: (valor) {
                setState(() {
                  cantidad = valor.toInt();
                });
              },
            ),
            ListTile(
              title: Text('Total:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Text(
                '\$' + (platillo.precio * cantidad).toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
            ),
            CustomButton(
              texto: 'Agregar al pedido',
              onPressed: () {
                Item item = Item(
                  nombre: platillo.nombre,
                  precio: platillo.precio,
                  cantidad: cantidad,
                );
                pedidoService.listaItems.add(item);
                Navigator.pop(context);
              },
              extendido: false,
            )
          ],
        ),
      ),
    );
  }
}
