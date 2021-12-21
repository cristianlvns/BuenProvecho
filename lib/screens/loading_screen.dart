import 'package:buen_provecho/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: checkLoginState(context),
          builder: (context, sapshot) {
            return CircularProgressIndicator(
              value: null,
              strokeWidth: 8,
            );
          },
        ),
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final loginService = Provider.of<LoginService>(context, listen: false);
    final autenticando = await loginService.isLoggedIn();
    if (autenticando) {
      Navigator.pushReplacementNamed(context, 'dashboard');
    } else {
      Navigator.pushReplacementNamed(context, 'signin');
    }
  }
}
