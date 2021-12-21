import 'package:buen_provecho/models/pedido.dart';
import 'package:buen_provecho/services/login_service.dart';
import 'package:buen_provecho/services/pedido_service.dart';
import 'package:buen_provecho/widgets/card_item.dart';
import 'package:buen_provecho/widgets/custom_alert.dart';
import 'package:buen_provecho/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MiPedidoScreen extends StatefulWidget {
  MiPedidoScreen({Key? key}) : super(key: key);

  @override
  _MiPedidoScreenState createState() => _MiPedidoScreenState();
}

class _MiPedidoScreenState extends State<MiPedidoScreen> {
  late PedidoService pedidosService;
  late LoginService usuarioService;
  List<CardItem> _items = [];

  @override
  void initState() {
    super.initState();
    this.pedidosService = Provider.of<PedidoService>(context, listen: false);
    this.usuarioService = Provider.of<LoginService>(context, listen: false);
    _cargarItems();
  }

  void _cargarItems() async {
    List<Item> lista = this.pedidosService.listaItems;
    final mapaRest = lista.map(
      (e) => CardItem(
        nombre: e.nombre,
        cantidad: e.cantidad,
        precioUnitario: e.precio,
      ),
    );
    setState(() {
      _items.insertAll(0, mapaRest);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: _items.length > 0 ? conItems() : sinItems(),
      ),
    );
  }

  double realizarCalculoTotal() {
    double total = 0;
    for (var element in this.pedidosService.listaItems) {
      total += element.precio * element.cantidad;
    }
    return total;
  }

  Widget conItems() {
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            itemBuilder: (_, i) => _items[i],
            itemCount: _items.length,
            physics: BouncingScrollPhysics(),
          ),
        ),
        SizedBox(height: 16),
        ListTile(
          title: Text('Total'),
          subtitle: Text('\$' + realizarCalculoTotal().toStringAsFixed(2)),
        ),
        SizedBox(height: 16),
        CustomButton(
          texto: 'Realizar Pedido',
          onPressed: () async {
            double preciototal = realizarCalculoTotal();
            final nuevoPedido = Pedido(
              uid: usuarioService.usuario.uid,
              items: pedidosService.listaItems,
              estatus: 'Solicitado',
              total: preciototal,
            );
            final confirm = await pedidosService.crearPedido(nuevoPedido);
            print('Usuario' + usuarioService.usuario.uid);
            print(pedidosService.listaItems);
            print(confirm);
            if (confirm) {
              pedidosService.listaItems.clear();
              _items.clear();
              Navigator.pop(context);
            } else {
              showDialog(
                context: context,
                builder: (_) => CustomAlert(
                  titulo: 'Error',
                  subtitulo: 'No se pudo concretar el pedido',
                ),
              );
            }
          },
          extendido: true,
        ),
      ],
    );
  }

  Widget sinItems() {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.inbox,
            size: 48,
          ),
          Text('No has seleccionado platillos'),
        ],
      ),
    );
  }
}
