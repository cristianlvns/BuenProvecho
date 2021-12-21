import 'dart:convert';
import 'package:buen_provecho/models/usuario.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));
String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.ok,
    required this.usuario,
    required this.token,
  });

  bool ok;
  Usuario usuario;
  String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        usuario: Usuario.fromJson(json["usuario"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": usuario.toJson(),
        "token": token,
      };
}

NoLoginResponse noLoginResponseFromJson(String str) =>
    NoLoginResponse.fromJson(json.decode(str));
String noLoginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class NoLoginResponse {
  NoLoginResponse({
    required this.ok,
    required this.msg,
  });

  bool ok;
  String msg;

  factory NoLoginResponse.fromJson(Map<String, dynamic> json) =>
      NoLoginResponse(
        ok: json["ok"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
      };
}
