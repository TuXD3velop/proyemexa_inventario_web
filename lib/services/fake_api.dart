import 'package:proyemexa_inventario_web/services/http_model.dart';

List<Empleados> fakeEmpleados = [
  const Empleados(
    id: '1',
    nombre: 'Enrique',
    apellidoPaterno: 'Barradas',
    apellidoMaterno: 'Macias',
    seguroSocial: '8945621458',
    puesto: 'Chaleco',
    cuadrilla: 'Los genios',
    tipoSangre: '0+',
    foto: 'Sin foto',
  ),
  const Empleados(
    id: '2',
    nombre: 'Augurio',
    apellidoPaterno: 'Barradas',
    apellidoMaterno: 'Martinez',
    seguroSocial: '8945624621',
    puesto: 'Chofer',
    cuadrilla: 'Los genios',
    tipoSangre: '0+',
    foto: 'Sin foto',
  ),
  const Empleados(
    id: '3',
    nombre: 'Pedro',
    apellidoPaterno: 'Fernandez',
    apellidoMaterno: 'Martinez',
    seguroSocial: '8945627892',
    puesto: 'Chaleco',
    cuadrilla: 'Los genios',
    tipoSangre: '0+',
    foto: 'Sin foto',
  ),
  const Empleados(
    id: '4',
    nombre: 'Hello',
    apellidoPaterno: 'Kitty',
    apellidoMaterno: 'Olivares',
    seguroSocial: '8945627892',
    puesto: 'Jefe',
    cuadrilla: 'Los genios',
    tipoSangre: 'A+',
    foto: 'Sin foto',
  ),
];

Future<List<Empleados>> fetchkFakeApi() async {
  await Future.delayed(const Duration(seconds: 3));
  return fakeEmpleados;
}
