import 'package:buen_provecho/models/pedido.dart';
import 'package:buen_provecho/services/login_service.dart';
import 'package:buen_provecho/services/pedido_service.dart';
import 'package:buen_provecho/widgets/card_pedido.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PedidosTab extends StatefulWidget {
  PedidosTab({Key? key}) : super(key: key);

  @override
  _PedidosTabState createState() => _PedidosTabState();
}

class _PedidosTabState extends State<PedidosTab> {
  late PedidoService pedidosService;
  late LoginService usuarioService;
  List<CardPedido> _pedidos = [];

  @override
  void initState() {
    super.initState();
    this.pedidosService = Provider.of<PedidoService>(context, listen: false);
    this.usuarioService = Provider.of<LoginService>(context, listen: false);
    _cargarPedidos();
  }

  void _cargarPedidos() async {
    final usuario = usuarioService.usuario;
    print(usuario.uid);
    List<Pedido> lista = await this.pedidosService.enlistarPedidos(usuario.uid);
    final mapaRest = lista.map(
      (e) => CardPedido(
        fecha: e.createdAt!,
        monto: e.total,
        estatus: e.estatus,
        items: e.items,
      ),
    );
    setState(() {
      _pedidos.insertAll(0, mapaRest);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: _pedidos.length > 0 ? conPedidos() : sinPedidos(),
        ),
      ),
    );
  }

  Widget conPedidos() {
    return ListView.builder(
      itemBuilder: (_, i) => _pedidos[i],
      itemCount: _pedidos.length,
      shrinkWrap: true,
      physics: ScrollPhysics(),
    );
  }

  Widget sinPedidos() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox,
            size: 48,
          ),
          Text('No se han realizado pedidos'),
        ],
      ),
    );
  }
}
