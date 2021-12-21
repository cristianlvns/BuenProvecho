import 'dart:convert';
import 'package:buen_provecho/global/environment.dart';
import 'package:buen_provecho/global/request_result.dart';
import 'package:buen_provecho/models/restaurante.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RestauranteService with ChangeNotifier {
  Restaurante? restaurante;

  Future<Restaurante> obtenerRestaurante(String id) async {
    final data = {'id': id};
    final uri = Uri.parse('${Environment.apiUrl}/restaurante/');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    final restauranteResponse = restauranteFromJson(resp.body);
    return restauranteResponse;
  }

  Future<List<Restaurante>> enlistarRestaurantes() async {
    final uri = Uri.parse('${Environment.apiUrl}/restaurante/all');
    final resp = await http.post(uri);
    if (resp.statusCode == 200) {
      final restaurantesResponse = restaurantesResponseFromJson(resp.body);
      return restaurantesResponse.restaurantes;
    } else {
      return [];
    }
  }
}
