import 'dart:convert';
import 'package:buen_provecho/global/environment.dart';
import 'package:buen_provecho/global/request_result.dart';
import 'package:buen_provecho/models/login.dart';
import 'package:buen_provecho/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginService with ChangeNotifier {
  Usuario? _usuario;
  Usuario get usuario => this._usuario!;
  set usuario(Usuario valor) {
    this._usuario = valor;
    notifyListeners();
  }

  final _storage = new FlutterSecureStorage();

  bool _autenticando = false;
  bool get autenticando => this._autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<RequestResult> login(String email, String password) async {
    final data = {'email': email, 'password': password};
    final uri = Uri.parse('${Environment.apiUrl}/login/');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      await this._guardarToken(loginResponse.token);
      this.usuario = loginResponse.usuario;
      return RequestResult(true, this.usuario);
    } else {
      final loginResponse = noLoginResponseFromJson(resp.body);
      return RequestResult(false, loginResponse.msg);
    }
  }

  Future<RequestResult> nuevoUsuario(
      String nombre, String email, String password) async {
    final data = {'nombre': nombre, 'email': email, 'password': password};
    final uri = Uri.parse('${Environment.apiUrl}/login/new/');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      await this._guardarToken(loginResponse.token);
      this.usuario = loginResponse.usuario;
      return RequestResult(true, this.usuario);
    } else {
      final loginResponse = noLoginResponseFromJson(resp.body);
      return RequestResult(false, loginResponse.msg);
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');
    final uri = Uri.parse('${Environment.apiUrl}/login/renew');
    final resp = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token.toString()
      },
    );
    print(token.toString());
    print(resp.body);
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      await this._guardarToken(loginResponse.token);
      //Almacenamos el usuario autenticado
      this.usuario = loginResponse.usuario;
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
