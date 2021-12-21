import 'dart:convert';
import 'horario.dart';

RestaurantesResponse restaurantesResponseFromJson(String str) =>
    RestaurantesResponse.fromJson(json.decode(str));

String restaurantesResponseToJson(RestaurantesResponse data) =>
    json.encode(data.toJson());

Restaurante restauranteFromJson(String str) =>
    Restaurante.fromJson(json.decode(str));

String restauranteToJson(Restaurante data) => json.encode(data.toJson());

class RestaurantesResponse {
  RestaurantesResponse({
    required this.restaurantes,
  });

  List<Restaurante> restaurantes;

  factory RestaurantesResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantesResponse(
        restaurantes: List<Restaurante>.from(
            json["restaurantes"].map((x) => Restaurante.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "restaurantes": List<dynamic>.from(restaurantes.map((x) => x.toJson())),
      };
}

class Restaurante {
  Restaurante({
    required this.restauranteid,
    required this.nombre,
    required this.categoria,
    required this.direccion,
    required this.ciudad,
    required this.horario,
    required this.imagen,
  });

  String restauranteid;
  String nombre;
  String categoria;
  String direccion;
  String ciudad;
  Horario horario;
  String imagen;

  factory Restaurante.fromJson(Map<String, dynamic> json) => Restaurante(
        restauranteid: json["_id"],
        nombre: json["nombre"],
        categoria: json["categoria"],
        direccion: json["direccion"],
        ciudad: json["ciudad"],
        horario: Horario.fromJson(json["horario"]),
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "_id": restauranteid,
        "nombre": nombre,
        "categoria": categoria,
        "direccion": direccion,
        "ciudad": ciudad,
        "horario": horario.toJson(),
        "imagen": imagen,
      };
}
