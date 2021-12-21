import 'dart:convert';
import 'package:buen_provecho/global/environment.dart';
import 'package:buen_provecho/global/request_result.dart';
import 'package:buen_provecho/models/platillo.dart';
import 'package:buen_provecho/models/restaurante.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlatilloService with ChangeNotifier {
  Restaurante? restauranteSeleccionado;
  Platillo? platilloSeleccionado;

  Future<List<Platillo>> enlistarPlatillos(String id) async {
    final data = {'restauranteId': id};
    final uri = Uri.parse('${Environment.apiUrl}/platillo/all');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    if (resp.statusCode == 200) {
      final platillosResponse = platillosResponseFromJson(resp.body);
      return platillosResponse.platillos;
    } else {
      return [];
    }
  }

  Future<Platillo> obtenerPlatillo(String id) async {
    final data = {'id': id};
    final uri = Uri.parse('${Environment.apiUrl}/platillo/');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    final platilloResponse = platilloFromJson(resp.body);
    return platilloResponse;
  }
}
