import 'dart:convert';

PlatillosResponse platillosResponseFromJson(String str) =>
    PlatillosResponse.fromJson(json.decode(str));
String platillosResponseToJson(PlatillosResponse data) =>
    json.encode(data.toJson());

Platillo platilloFromJson(String str) => Platillo.fromJson(json.decode(str));
String platilloToJson(Platillo data) => json.encode(data.toJson());

class PlatillosResponse {
  PlatillosResponse({
    required this.platillos,
  });

  List<Platillo> platillos;

  factory PlatillosResponse.fromJson(Map<String, dynamic> json) =>
      PlatillosResponse(
        platillos: List<Platillo>.from(
            json["platillos"].map((x) => Platillo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "platillo": List<dynamic>.from(platillos.map((x) => x.toJson())),
      };
}

class Platillo {
  Platillo({
    required this.platilloid,
    required this.nombre,
    required this.descripcion,
    required this.restauranteid,
    required this.precio,
    required this.imagen,
  });

  String platilloid;
  String nombre;
  String descripcion;
  String restauranteid;
  double precio;
  String imagen;

  factory Platillo.fromJson(Map<String, dynamic> json) => Platillo(
        platilloid: json["_id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        restauranteid: json["restauranteid"],
        precio: json["precio"] * 1.0,
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "_pid": platilloid,
        "nombre": nombre,
        "descripcion": descripcion,
        "restaurante": restauranteid,
        "precio": precio,
        "imagen": imagen,
      };
}
