import 'package:flutter/material.dart';
import 'package:proyemexa_inventario_web/presentation/utils/custom_drawer.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        drawer: buildDrawer(context),
        appBar: AppBar(
          title: const Text('Fichas Medicas'),
          backgroundColor: Colors.orange[800],
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.update))
          ],
        ),
        body: const Center(
          child: Text('data'),
        ));
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
