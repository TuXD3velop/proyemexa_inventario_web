import 'package:flutter/material.dart';
import 'package:proyemexa_inventario_web/presentation/screens/Inventario_seguridad.dart';
import 'package:proyemexa_inventario_web/presentation/screens/fichas_medicas.dart';
import 'package:proyemexa_inventario_web/presentation/screens/home_screen.dart';
import 'package:proyemexa_inventario_web/presentation/screens/inventario_herramienta.dart';
import 'package:proyemexa_inventario_web/presentation/screens/inventario_material.dart';
import 'package:proyemexa_inventario_web/presentation/screens/login_screen.dart';
import 'package:proyemexa_inventario_web/presentation/screens/personal.dart';
import 'package:proyemexa_inventario_web/presentation/screens/siniestros_screen.dart';

class AppRoute {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case '/inventario_seguridad':
        return MaterialPageRoute(
            builder: (context) => const InventarioSeguridad());
      case '/inventario_material':
        return MaterialPageRoute(
            builder: (context) => const InventarioMateriales());
      case '/inventario_herramienta':
        return MaterialPageRoute(
            builder: (context) => const InventarioHerramienta());
      case '/fichas_medicas':
        return MaterialPageRoute(builder: (context) => const FichasMedicas());
      case '/personal':
        return MaterialPageRoute(builder: (context) => Personal());
      case '/siniestros':
        return MaterialPageRoute(builder: (context) => Siniestros());
      default:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
  }
}
