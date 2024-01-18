//Clase,consumo de servicios http

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:proyemexa_inventario_web/services/http_model.dart';

class HttpServices {
  //Get personal
  final String getEmpleadosUrl =
      'https://www.proyemexa.com.mx/inventario/public/nombres/all';

  final String urlBase = 'https://www.proyemexa.com.mx/inventario/public/';

  Future<List<Empleados>> getEmpleados() async {
    final Response response = await get(Uri.parse(getEmpleadosUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Empleados> empleados =
          body.map((dynamic item) => Empleados.fromJson(item)).toList();
      return empleados;
    } else {
      throw Exception('Faile to load resouce');
    }
  }

  Future<int> deleteEmpleado(int id) async {
    const String path = "personal/delete/";
    final url = Uri.parse('$urlBase$path$id');
    debugPrint('URL delete = $url');
    final Response response = await delete(url);

    if (response.statusCode == 200) {
      debugPrint('Delete Response code = 200');
      debugPrint(response.body);
      return response.statusCode;
    } else {
      throw Exception(response.body);
    }
  }
}
