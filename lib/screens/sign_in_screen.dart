import 'package:buen_provecho/models/usuario.dart';
import 'package:buen_provecho/services/login_service.dart';
import 'package:buen_provecho/widgets/custom_alert.dart';
import 'package:buen_provecho/widgets/custom_button.dart';
import 'package:buen_provecho/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    final authService = Provider.of<LoginService>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Image(image: AssetImage('assets/logo.png')),
                const SizedBox(height: 24),
                CustomInput(
                  texto: 'Email',
                  icono: Icons.email_sharp,
                  controller: emailCtrl,
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
                CustomButton(
                  texto: 'Ingresar',
                  extendido: true,
                  onPressed: () async {
                    //FocusScope.of(context).unfocus();
                    final loginRes =
                        await authService.login(emailCtrl.text, passCtrl.text);
                    print(loginRes);
                    if (loginRes.ok) {
                      Navigator.pushReplacementNamed(context, 'dashboard');
                    } else {
                      String msg = '';
                      msg = loginRes.data.toString();
                      showDialog(
                        context: context,
                        builder: (_) => CustomAlert(
                          titulo: 'Error en el Login',
                          subtitulo: msg,
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                CustomButton(
                  texto: 'Registrarse',
                  extendido: true,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'signup');
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
