import 'package:buen_provecho/screens/dashboard_screen.dart';
import 'package:buen_provecho/screens/loading_screen.dart';
import 'package:buen_provecho/screens/mi_pedido_screen.dart';
import 'package:buen_provecho/screens/platillo_screen.dart';
import 'package:buen_provecho/screens/restaurante_screen.dart';
import 'package:buen_provecho/screens/sign_in_screen.dart';
import 'package:buen_provecho/screens/sign_up_screen.dart';
import 'package:buen_provecho/services/login_service.dart';
import 'package:buen_provecho/services/pedido_service.dart';
import 'package:buen_provecho/services/platillo_service.dart';
import 'package:buen_provecho/services/restaurante_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginService()),
        ChangeNotifierProvider(create: (_) => RestauranteService()),
        ChangeNotifierProvider(create: (_) => PlatilloService()),
        ChangeNotifierProvider(create: (_) => PedidoService()),
      ],
      child: MaterialApp(
        title: 'Buen Provecho',
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.green,
        ),
        initialRoute: 'loading',
        routes: {
          'loading': (_) => LoadingScreen(),
          'signin': (_) => SignInScreen(),
          'signup': (_) => SignUpScreen(),
          'dashboard': (_) => DashboardScreen(),
          'restaurante': (_) => RestauranteScreen(),
          'platillo': (_) => PlatilloScreen(),
          'mipedido': (_) => MiPedidoScreen(),
        },
        home: const SignInScreen(),
      ),
    );
  }
}
