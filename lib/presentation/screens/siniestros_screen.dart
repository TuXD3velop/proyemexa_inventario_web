import 'package:flutter/material.dart';

import '../utils/custom_drawer.dart';

class Siniestros extends StatefulWidget {
  Siniestros({Key? key}) : super(key: key);

  @override
  State<Siniestros> createState() => _SiniestrosState();
}

class _SiniestrosState extends State<Siniestros> {
  //Manejador de estados

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: const Text('Siniestros'),
          actions: [
            IconButton(
                onPressed: (() {
                  Navigator.pushNamed(context, '/home');
                }),
                icon: const Icon(Icons.logout))
          ],
        ),
        backgroundColor: Colors.grey.shade300,
        drawer: buildDrawer(context),
        body: const Center(
          child: Text('data'),
        ));
  }
}
