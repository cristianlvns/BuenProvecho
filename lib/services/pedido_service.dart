import 'dart:convert';
import 'package:buen_provecho/global/environment.dart';
import 'package:buen_provecho/models/pedido.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PedidoService with ChangeNotifier {
  List<Pedido> listaPedidos = [];
  List<Item> listaItems = [];

  Future<List<Pedido>> enlistarPedidos(String uid) async {
    final data = {'uid': uid};
    final uri = Uri.parse('${Environment.apiUrl}/pedido/all');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    if (resp.statusCode == 200) {
      final pedidosResponse = pedidosResponseFromJson(resp.body);
      print(pedidosResponse.pedidos);
      return pedidosResponse.pedidos;
    } else {
      return [];
    }
  }

  Future<bool> crearPedido(Pedido pedido) async {
    final data = {
      'uid': pedido.uid,
      'items': pedido.items,
      'total': pedido.total,
      'estatus': pedido.estatus,
    };
    final uri = Uri.parse('${Environment.apiUrl}/pedido/new');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
