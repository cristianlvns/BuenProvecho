import 'dart:convert';

PedidosResponse pedidosResponseFromJson(String str) =>
    PedidosResponse.fromJson(json.decode(str));

String pedidosResponseToJson(PedidosResponse data) =>
    json.encode(data.toJson());

class PedidosResponse {
  PedidosResponse({
    required this.pedidos,
  });

  List<Pedido> pedidos;

  factory PedidosResponse.fromJson(Map<String, dynamic> json) =>
      PedidosResponse(
        pedidos:
            List<Pedido>.from(json["pedidos"].map((x) => Pedido.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pedidos": List<dynamic>.from(pedidos.map((x) => x.toJson())),
      };
}

Pedido pedidoFromJson(String str) => Pedido.fromJson(json.decode(str));

String pedidoToJson(Pedido data) => json.encode(data.toJson());

class Pedido {
  Pedido({
    required this.uid,
    required this.items,
    required this.total,
    required this.estatus,
    this.createdAt,
    this.updatedAt,
  });

  String uid;
  List<Item> items;
  double total;
  String estatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
        uid: json["uid"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        total: json["total"] * 1.0,
        estatus: json["estatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "total": total,
        "estatus": estatus,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}

class Item {
  Item({
    required this.nombre,
    required this.precio,
    required this.cantidad,
  });

  String nombre;
  double precio;
  int cantidad;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        nombre: json["nombre"],
        precio: json["precio"] * 1.0,
        cantidad: json["cantidad"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "precio": precio,
        "cantidad": cantidad,
      };
}
