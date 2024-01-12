import 'package:flutter/material.dart';
import 'package:proyemexa_inventario_web/presentation/utils/custom_drawer.dart';

class InventarioHerramienta extends StatefulWidget {
  const InventarioHerramienta({Key? key}) : super(key: key);

  @override
  State<InventarioHerramienta> createState() => _InventarioHerramientaState();
}

class _InventarioHerramientaState extends State<InventarioHerramienta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        drawer: buildDrawer(context),
        appBar: AppBar(
          backgroundColor: Colors.amber.shade800,
          title: const Text('Inventario Herramienta'),
          actions: [
            IconButton(
                onPressed: () => Navigator.pushNamed(context, '/home'),
                icon: const Icon(Icons.logout))
          ],
        ),
        body: const Center(
          child: Text('Change'),
        ));
  }
}
