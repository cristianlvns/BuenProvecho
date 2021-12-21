import 'package:buen_provecho/models/platillo.dart';
import 'package:buen_provecho/models/restaurante.dart';
import 'package:buen_provecho/services/platillo_service.dart';
import 'package:buen_provecho/services/restaurante_service.dart';
import 'package:buen_provecho/widgets/card_platillo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestauranteScreen extends StatefulWidget {
  RestauranteScreen({Key? key}) : super(key: key);

  @override
  _RestauranteScreenState createState() => _RestauranteScreenState();
}

class _RestauranteScreenState extends State<RestauranteScreen> {
  late PlatilloService platilloService;
  late RestauranteService restauranteService;
  List<CardPlatillo> _platillos = [];

  @override
  void initState() {
    super.initState();
    this.platilloService = Provider.of<PlatilloService>(context, listen: false);
    this.restauranteService =
        Provider.of<RestauranteService>(context, listen: false);
    final restaurante = platilloService.restauranteSeleccionado;
    _cargarPlatillos(restaurante!.restauranteid);
  }

  void _cargarPlatillos(String restauranteId) async {
    List<Platillo> lista =
        await this.platilloService.enlistarPlatillos(restauranteId);
    //restaurante =
    //    await this.restauranteService.obtenerRestaurante(restauranteId);
    final mapaPlatillo = lista.map((e) => CardPlatillo(
          nombre: e.nombre,
          descripcion: e.descripcion,
          precio: e.precio,
          imagen: NetworkImage(e.imagen),
          onTap: () async {
            //final platilloService =
            //    Provider.of<PlatilloService>(context, listen: false);
            print(e.platilloid);
            final platSeleccionado =
                await this.platilloService.obtenerPlatillo(e.platilloid);
            platilloService.platilloSeleccionado = platSeleccionado;

            Navigator.pushNamed(context, 'platillo');
          },
        ));

    setState(() {
      _platillos.insertAll(0, mapaPlatillo);
    });
  }

  @override
  Widget build(BuildContext context) {
    final restaurante = platilloService.restauranteSeleccionado;
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurante!.nombre),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'mipedido');
            },
            icon: Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(restaurante.direccion),
                Text('Horario:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Lunes: ' + restaurante.horario.lunes!),
                Text('Martes: ' + restaurante.horario.martes!),
                Text('Miércoles: ' + restaurante.horario.miercoles!),
                Text('Jueves: ' + restaurante.horario.jueves!),
                Text('Viernes: ' + restaurante.horario.viernes!),
                Text('Sábado: ' + restaurante.horario.sabado!),
                Text('Domingo: ' + restaurante.horario.domingo!),
                SizedBox(height: 16),
                ListView.builder(
                  itemBuilder: (_, i) => _platillos[i],
                  itemCount: _platillos.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
