import 'package:buen_provecho/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerfilTab extends StatelessWidget {
  const PerfilTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginService = Provider.of<LoginService>(context);
    final infoUsuario = loginService.usuario;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              ListTile(
                title: Text(infoUsuario.nombre),
                subtitle: Text(infoUsuario.email),
                leading: CircleAvatar(
                  child: Text(infoUsuario.nombre.substring(0, 2)),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
              ListTile(
                title: Text('Cerrar Sesión'),
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'signin');
                  LoginService.deleteToken();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
