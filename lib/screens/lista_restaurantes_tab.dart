import 'package:buen_provecho/models/restaurante.dart';
import 'package:buen_provecho/services/platillo_service.dart';
import 'package:buen_provecho/services/restaurante_service.dart';
import 'package:buen_provecho/widgets/card_restaurante.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaRestaurantesTab extends StatefulWidget {
  ListaRestaurantesTab({Key? key}) : super(key: key);

  @override
  _ListaRestaurantesTabState createState() => _ListaRestaurantesTabState();
}

class _ListaRestaurantesTabState extends State<ListaRestaurantesTab> {
  late RestauranteService restauranteService;
  List<CardRestaurante> _restaurantes = [];

  @override
  void initState() {
    super.initState();
    this.restauranteService =
        Provider.of<RestauranteService>(context, listen: false);
    _cargarRestaurantes();
  }

  void _cargarRestaurantes() async {
    List<Restaurante> lista =
        await this.restauranteService.enlistarRestaurantes();
    final mapaRest = lista.map((e) => CardRestaurante(
          nombre: e.nombre,
          direccion: e.direccion,
          tipo: e.categoria,
          imagen: NetworkImage(e.imagen),
          onTap: () async {
            final platilloService =
                Provider.of<PlatilloService>(context, listen: false);
            print(e.restauranteid);
            final resSeleccionado = await this
                .restauranteService
                .obtenerRestaurante(e.restauranteid);
            platilloService.restauranteSeleccionado = resSeleccionado;
            Navigator.pushNamed(context, 'restaurante');
          },
        ));
    setState(() {
      _restaurantes.insertAll(0, mapaRest);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, i) => _restaurantes[i],
          itemCount: _restaurantes.length,
        ),
      ),
    );
  }
}
