import 'package:buen_provecho/models/usuario.dart';
import 'package:buen_provecho/services/login_service.dart';
import 'package:buen_provecho/widgets/custom_alert.dart';
import 'package:buen_provecho/widgets/custom_button.dart';
import 'package:buen_provecho/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCtrl = TextEditingController();
    final nameCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    final confirmPassCtrl = TextEditingController();
    final authService = Provider.of<LoginService>(context, listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CustomInput(
                  texto: 'Nombre',
                  icono: Icons.person_sharp,
                  controller: nameCtrl,
                ),
                const SizedBox(height: 16),
                CustomInput(
                  texto: 'Email',
                  icono: Icons.email_sharp,
                  controller: userCtrl,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                CustomInput(
                  texto: 'Contraseña',
                  icono: Icons.lock_outline_sharp,
                  controller: passCtrl,
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 16),
                CustomInput(
                  texto: 'Confirmar Contraseña',
                  icono: Icons.lock_outline_sharp,
                  controller: confirmPassCtrl,
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  texto: 'Registrarse',
                  extendido: true,
                  onPressed: () async {
                    //FocusScope.of(context).unfocus();
                    final loginRes = await authService.nuevoUsuario(
                        nameCtrl.text, userCtrl.text, passCtrl.text);
                    print(loginRes);
                    if (loginRes.ok) {
                      Usuario usuario = loginRes.data;
                      Navigator.pushReplacementNamed(context, 'dashboard');
                    } else {
                      String msg = '';
                      msg = loginRes.data.toString();
                      CustomAlert(
                        titulo: 'Error al registrar',
                        subtitulo: msg,
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                CustomButton(
                  texto: 'Iniciar Sesión',
                  extendido: true,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'signin');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
