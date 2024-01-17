class Empleados {
  final String id;
  final String nombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String seguroSocial;
  final String puesto;
  final String cuadrilla;
  final String tipoSangre;
  final String foto;

  const Empleados({
    required this.id,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.seguroSocial,
    required this.puesto,
    required this.cuadrilla,
    required this.tipoSangre,
    required this.foto,
  });

  factory Empleados.fromJson(Map<String, dynamic> json) {
    return Empleados(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      apellidoPaterno: json['apellidoPaterno'] as String,
      apellidoMaterno: json['apellidoMaterno'] as String,
      seguroSocial: json['seguroSocial'] as String,
      puesto: json['puesto'] as String,
      cuadrilla: json['nombreCuadrilla'] as String,
      tipoSangre: json['tipoSanguinio'] as String,
      foto: json['foto'] as String,
    );
  }
}
