import 'package:flutter/material.dart';

class FichasMedicas extends StatelessWidget {
  const FichasMedicas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fichas Medicas')),
      body: const Center(child: Text('Fichas Medicas')),
    );
  }
}
