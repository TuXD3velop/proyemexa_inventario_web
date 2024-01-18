import 'dart:convert';
import 'dart:math';
import 'package:dynamic_table/dynamic_table.dart';
import 'package:flutter/material.dart';
import 'package:proyemexa_inventario_web/presentation/utils/custom_drawer.dart';
//import 'package:proyemexa_inventario_web/services/fake_api.dart';
import 'package:proyemexa_inventario_web/services/http_model.dart';
import 'package:http/http.dart' as http;
import 'package:proyemexa_inventario_web/services/http_request.dart';

//Future Get empleados
Future<List<Empleados>> fetchEmpleados() async {
  final response = await http.get(
      Uri.parse('https://www.proyemexa.com.mx/inventario/public/nombres/all'));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    List<Empleados> empleados =
        body.map((dynamic item) => Empleados.fromJson(item)).toList();

    return empleados;
  } else {
    throw Exception('Failed to load empleados');
  }
}

Future<int> borrarEmpleado(int id) async {
  const String urlBase = 'https://www.proyemexa.com.mx/inventario/public/';
  const String path = "personal/delete/";
  final url = Uri.parse('$urlBase$path$id');
  debugPrint('URL delete = $url');
  final response = await http.delete(url);

  if (response.statusCode == 200) {
    debugPrint('Delete Response code = 200');
    debugPrint(response.body);
    return response.statusCode;
  } else {
    throw Exception(response.body);
  }
}

class Personal extends StatefulWidget {
  const Personal({Key? key}) : super(key: key);
  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  final separador = 5.0;
  final style = TextStyle(
      color: Colors.grey.shade900, fontWeight: FontWeight.w400, fontSize: 14.0);

  List<Map> fichas = [];
  Widget fichaMedicaCompleta = const Center(
    child: Text('NO seleccionado'),
  );

  late Future<List<Empleados>> futureEmpleados;
  var tableKey = GlobalKey<DynamicTableState>();
  late List<Empleados> empleados;

  final HttpServices httpServices = HttpServices();

  @override
  void initState() {
    super.initState();
    futureEmpleados = fetchEmpleados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      drawer: buildDrawer(context),
      appBar: AppBar(
        title: const Text('Fichas Medicas'),
        //backgroundColor: Colors.orange[800],
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.update))],
      ),
      body: Center(
        child: FutureBuilder(
            future: futureEmpleados,
            builder: (context, AsyncSnapshot<List<Empleados>> snapshot) {
              if (snapshot.hasData) {
                empleados = snapshot.data!;
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: DynamicTable(
                    key: tableKey,
                    header: const Text("Person Table"),
                    columns: _createColumns(),
                    rows: _creteRows(),
                    //Row edit
                    onRowEdit: (index, row) {
                      debugPrint('On row edit');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Row Edited index:$index row:$row"),
                        ),
                      );
                      empleados[index] = Empleados(
                        id: row[0],
                        nombre: row[1],
                        apellidoPaterno: row[2],
                        apellidoMaterno: row[3],
                        seguroSocial: row[4],
                        puesto: row[5],
                        cuadrilla: row[6],
                        tipoSangre: row[7],
                        foto: row[8],
                      );
                      return true;
                    },
                    // Row  delete
                    onRowDelete: (index, row) {
                      debugPrint('On row Delete');
                      final indexFix = index - 1;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Row Deleted index:$indexFix row:$row"),
                        ),
                      );
                      empleados.removeAt(indexFix);
                      //! Realizar la consulta al servidor
                      debugPrint(
                          'A punto de eliminar el empleado con ID ${empleados[indexFix].id}');
                      var idToDelete = int.parse(empleados[indexFix].id);
                      httpServices.deleteEmpleado(idToDelete);

                      return true;
                    },
                    onRowSave: (index, old, newValue) {
                      debugPrint('On row save');
                      if (newValue[0] == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Name cannot be null"),
                          ),
                        );
                        return null;
                      }
                      if (newValue[1] == null) {
                        //If newly added row then add unique ID
                        newValue[1] = Random()
                            .nextInt(500)
                            .toString(); // to add Unique ID because it is not editable
                      }
                      // Update data
                      empleados[index] = Empleados(
                        id: newValue[0],
                        nombre: newValue[1],
                        apellidoPaterno: newValue[2],
                        apellidoMaterno: newValue[3],
                        seguroSocial: newValue[4],
                        puesto: newValue[5],
                        cuadrilla: newValue[6],
                        tipoSangre: newValue[7],
                        foto: newValue[8],
                      );

                      //! Realizar la consulta al servidor
                      return newValue;
                    },
                    showActions: true,
                    showAddRowButton: true,
                    showDeleteAction: true,
                    rowsPerPage: 10,
                    showFirstLastButtons: true,
                    availableRowsPerPage: const [10, 20, 50, 100],
                    dataRowMinHeight: 60,
                    dataRowMaxHeight: 60,
                    columnSpacing: 60,
                    actionColumnTitle: "Acciones",
                    showCheckboxColumn: true,
                    onSelectAll: (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: value ?? false
                              ? const Text("All Rows Selected")
                              : const Text("All Rows Unselected"),
                        ),
                      );
                    },
                    onRowsPerPageChanged: (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Rows Per Page Changed to $value"),
                        ),
                      );
                    },
                    actions: [
                      IconButton(
                        onPressed: () {
                          for (var i = 0; i < empleados.length; i += 2) {
                            tableKey.currentState
                                ?.selectRow(i, isSelected: true);
                          }
                        },
                        icon: const Icon(Icons.select_all),
                        tooltip: "Select all odd Values",
                      ),
                      IconButton(
                        onPressed: () {
                          for (var i = 0; i < empleados.length; i += 2) {
                            tableKey.currentState
                                ?.selectRow(i, isSelected: false);
                          }
                        },
                        icon: const Icon(Icons.deselect_outlined),
                        tooltip: "Unselect all odd Values",
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('$snapshot.error');
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }

  List<DynamicTableDataColumn> _createColumns() {
    List<DynamicTableDataColumn> columns = [];

    columns.add(
      DynamicTableDataColumn(
        label: Container(
          child: const Text('ID'),
        ),
        onSort: (columnIndex, ascending) {},
        dynamicTableInputType: DynamicTableInputType.text(),
      ),
    );

    columns.add(
      DynamicTableDataColumn(
        label: Container(
          child: const Text('Nombre'),
        ),
        onSort: (columnIndex, ascending) {},
        dynamicTableInputType: DynamicTableInputType.text(),
      ),
    );

    columns.add(
      DynamicTableDataColumn(
        label: Container(
          child: const Text('Apellido P'),
        ),
        onSort: (columnIndex, ascending) {},
        dynamicTableInputType: DynamicTableInputType.text(),
      ),
    );

    columns.add(
      DynamicTableDataColumn(
        label: Container(
          child: const Text('Apellido M'),
        ),
        onSort: (columnIndex, ascending) {},
        dynamicTableInputType: DynamicTableInputType.text(),
      ),
    );

    columns.add(
      DynamicTableDataColumn(
        label: Container(
          child: const Text('Seguro Social'),
        ),
        onSort: (columnIndex, ascending) {},
        dynamicTableInputType: DynamicTableInputType.text(),
      ),
    );

    columns.add(
      DynamicTableDataColumn(
        label: Container(
          child: const Text('Puesto'),
        ),
        onSort: (columnIndex, ascending) {},
        dynamicTableInputType: DynamicTableInputType.text(),
      ),
    );

    columns.add(
      DynamicTableDataColumn(
        label: Container(
          child: const Text('Cuadrilla'),
        ),
        onSort: (columnIndex, ascending) {},
        dynamicTableInputType: DynamicTableInputType.text(),
      ),
    );

    columns.add(
      DynamicTableDataColumn(
        label: Container(
          child: const Text('Tipo Sangre'),
        ),
        onSort: (columnIndex, ascending) {},
        dynamicTableInputType: DynamicTableInputType.text(),
      ),
    );

    columns.add(
      DynamicTableDataColumn(
        label: Container(
          child: const Text('Foto'),
        ),
        onSort: (columnIndex, ascending) {},
        dynamicTableInputType: DynamicTableInputType.text(),
      ),
    );

    return columns;
  }

  List<DynamicTableDataRow> _creteRows() {
    var myData = empleados.asMap();
    List<DynamicTableDataCell> _getListCells(int index) {
      List<DynamicTableDataCell> celdas = [];

      celdas.add(DynamicTableDataCell(value: myData[index]!.id));
      celdas.add(DynamicTableDataCell(value: myData[index]!.nombre));
      celdas.add(DynamicTableDataCell(value: myData[index]!.apellidoPaterno));
      celdas.add(DynamicTableDataCell(value: myData[index]!.apellidoMaterno));
      celdas.add(DynamicTableDataCell(value: myData[index]!.seguroSocial));
      celdas.add(DynamicTableDataCell(value: myData[index]!.puesto));
      celdas.add(DynamicTableDataCell(value: myData[index]!.cuadrilla));
      celdas.add(DynamicTableDataCell(value: myData[index]!.tipoSangre));
      celdas.add(DynamicTableDataCell(value: myData[index]!.foto));

      return celdas;
    }

    return List.generate(
      myData.length,
      (index) => DynamicTableDataRow(
        onSelectChanged: (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: value ?? false
                  ? Text("Row Selected index:$index")
                  : Text("Row Unselected index:$index"),
            ),
          );
        },
        index: index,
        cells: _getListCells(index),
      ),
    );
  }

/*
 ██████╗██████╗ ███████╗ █████╗  ██████╗██╗ ██████╗ ███╗   ██╗    ██████╗ ███████╗
██╔════╝██╔══██╗██╔════╝██╔══██╗██╔════╝██║██╔═══██╗████╗  ██║    ██╔══██╗██╔════╝
██║     ██████╔╝█████╗  ███████║██║     ██║██║   ██║██╔██╗ ██║    ██║  ██║█████╗
██║     ██╔══██╗██╔══╝  ██╔══██║██║     ██║██║   ██║██║╚██╗██║    ██║  ██║██╔══╝
╚██████╗██║  ██║███████╗██║  ██║╚██████╗██║╚██████╔╝██║ ╚████║    ██████╔╝███████╗
 ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝    ╚═════╝ ╚══════╝

███████╗██╗ ██████╗██╗  ██╗ █████╗ ███████╗
██╔════╝██║██╔════╝██║  ██║██╔══██╗██╔════╝
█████╗  ██║██║     ███████║███████║███████╗
██╔══╝  ██║██║     ██╔══██║██╔══██║╚════██║
██║     ██║╚██████╗██║  ██║██║  ██║███████║
╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝

*/

  List<Widget> createFichas() {
    List<Widget> list = [];

    fichas.forEach((element) {
      list.add(createFicha(element));
    });
    return list;
  }

  Widget createFicha(Map<dynamic, dynamic> e) {
    return SizedBox(
      width: 380.0,
      child: InkWell(
        hoverColor: Colors.grey[400],
        borderRadius: BorderRadius.circular(10.0),
        splashColor: Colors.deepOrange,
        onTap: () => createFichaGeneral(e),
        child: Card(
          color: Colors.lightBlue.shade100,
          elevation: 20.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40.0,
                  backgroundImage: AssetImage(e['foto']),
                ),
                SizedBox(
                  width: 260,
                  child: Table(
                    border: TableBorder.symmetric(
                        inside: const BorderSide(color: Colors.grey)),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Nombre',
                              style:
                                  style.copyWith(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            e['nombre'],
                            style: style,
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Edad',
                            style: style.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            e['edad'],
                            style: style.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Telefono: ',
                            style: style.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            e['telefono'],
                            style: style,
                          ),
                        ),
                      ]),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Seguro Social',
                              style:
                                  style.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              e['seguro_social'],
                              style: style,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createFichaGeneral(Map<dynamic, dynamic> e) {
    //print(e['nombre']);
    setState(() {
      fichaMedicaCompleta = FichaGeneral(data: e);
    });
  }
}

/*
███████╗██╗ ██████╗██╗  ██╗ █████╗
██╔════╝██║██╔════╝██║  ██║██╔══██╗
█████╗  ██║██║     ███████║███████║
██╔══╝  ██║██║     ██╔══██║██╔══██║
██║     ██║╚██████╗██║  ██║██║  ██║
╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝

 ██████╗ ███████╗███╗   ██╗███████╗██████╗  █████╗ ██╗
██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔══██╗██║
██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝███████║██║
██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║██║
╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║  ██║███████╗
 ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝

*/

class FichaGeneral extends StatelessWidget {
  const FichaGeneral({Key? key, this.data}) : super(key: key);
  final Map<dynamic, dynamic>? data;

  final infoPersonalStyle = const TextStyle(color: Colors.white);
  @override
  Widget build(BuildContext context) {
    var contacto1 = data!['contacto_emergencia1'][0];
    var contacto2 = data!['contacto_emergencia2'][0];
    return Card(
      elevation: 20.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: Colors.blue.shade100,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Text(
                    'Informacion Personal',
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0),
                  ),
                  Container(
                    width: 350,
                    color: Colors.cyan.shade700,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                radius: 50.0,
                                backgroundImage: AssetImage(data!['foto']),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      data!['nombre'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Edad: ${data!['edad']} | Genero: ${data!['genero']} ',
                              style: infoPersonalStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Fecha de nacimiento: ${data!['fecha_nacimiento']}',
                              style: infoPersonalStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Estado civil: ${data!['estado_civil']}',
                              style: infoPersonalStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Puesto: ${data!['puesto']}',
                              style: infoPersonalStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Telefono: ${data!['telefono']}',
                              style: infoPersonalStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Seguro social: ${data!['seguro_social']}',
                              style: infoPersonalStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Domicilio: ${data!['domicilio']}',
                              style: infoPersonalStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Contacto 1
            Column(
              children: [
                Text(
                  'Contactos de emergencia',
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0),
                ),
                SizedBox(
                  width: 450,
                  child: Card(
                    elevation: 20.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Table(
                        border: TableBorder.symmetric(
                            inside: const BorderSide(color: Colors.grey)),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Nombre'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(contacto1['nombre'].toString()),
                            )
                          ]),
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Parentesco'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(contacto1['parentesco'].toString()),
                            ),
                          ]),
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Direccion'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(contacto1['direccion'].toString()),
                            )
                          ]),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Telefono'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(contacto1['telefono'].toString()),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //Contacto 2
                SizedBox(
                  width: 450,
                  child: Card(
                    elevation: 20.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Table(
                        border: TableBorder.symmetric(
                            inside: const BorderSide(color: Colors.grey)),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Nombre'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(contacto2['nombre'].toString()),
                            )
                          ]),
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Parentesco'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(contacto2['parentesco'].toString()),
                            ),
                          ]),
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Direccion'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(contacto2['direccion'].toString()),
                            )
                          ]),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Telefono'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(contacto2['telefono'].toString()),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //Informacion medica

            //Informacion medica
            Column(
              children: [
                Text(
                  'Informacion Medica',
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0),
                ),
                SizedBox(
                  width: 500,
                  child: Card(
                    elevation: 20.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Table(
                        border: TableBorder.symmetric(
                            inside: const BorderSide(color: Colors.grey)),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child:
                                  Text('Enfermedades que padece actualmente'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data!['enfermedades']),
                            )
                          ]),
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Tratamientos medicos actuales'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data!['tratamientos']),
                            ),
                          ]),
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Grupo sanguineo'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data!['grupo_sanguineo']),
                            )
                          ]),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Factor RH'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data!['factor_rh']),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Adicciones'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data!['adicciones']),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child:
                                    Text('Operaciones quirurjicas realizadas'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data!['operaciones_quirurjicas']),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Observaciones'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data!['observaciones']),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Ultima actualizacion'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data!['ultima_actualizacion']),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
