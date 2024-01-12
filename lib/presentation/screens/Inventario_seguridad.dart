import 'package:flutter/material.dart';
import '../utils/custom_drawer.dart';

class InventarioSeguridad extends StatefulWidget {
  const InventarioSeguridad({Key? key}) : super(key: key);

  @override
  State<InventarioSeguridad> createState() => _InventarioSeguridadState();
}

class _InventarioSeguridadState extends State<InventarioSeguridad> {
  //Manejador de estados

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        drawer: buildDrawer(context),
        appBar: AppBar(
          title: const Text('Inventario Seguridad'),
          actions: [
            IconButton(
                onPressed: (() {
                  Navigator.pushNamed(context, '/home');
                }),
                icon: const Icon(Icons.logout))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.get_app),
          onPressed: () {},
        ),
        body: const Center(
          child: Text('data'),
        ));
  }
}


/*
/*                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
##========================================================================================
##                                                                                      ##
##                            Seccion de la creacion de tabla                           ##
##                                                                                      ##
##========================================================================================
*/
  PlutoGrid _createTable() {
    return PlutoGrid(
      columns: _createColumns(),
      rows: _createRows(),
      //Evento
      onChanged: ((event) {
        print(event);

        var columnID = getColumnID(event.columnIdx);
        buffer['seguridad'][event.rowIdx][columnID] = event.value.toString();

        FirebaseFirestore.instance
            .collection('Inventario')
            .doc('seguridad')
            .update(buffer)
            .then((value) {
          toastSuccess('Sincornizacion OK...');
          setState(() {
            stateManager.notifyListeners();
          });
        }).catchError(
          (e) {
            print(e);
            toastError('Fallo la sincronizacion');
            setState(() {
              handleRenderGrid();
            });
          },
        );
      }),
      onLoaded: (event) {
        stateManager = event.stateManager;
        event.stateManager.setSelectingMode(PlutoGridSelectingMode.cell);
        _isStateManagerInit = true;
        event.stateManager.setShowColumnFilter(true);
      },
    );
  }

//##──── creacion de celdas ────────────────────────────────────────────────────────────────

  List<PlutoColumn> _createColumns() {
    return [
      PlutoColumn(
        backgroundColor: Colors.grey,
        frozen: PlutoColumnFrozen.left,
        title: 'Producto',
        field: 'producto',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
      ),
      PlutoColumn(
        backgroundColor: Colors.grey,
        frozen: PlutoColumnFrozen.left,
        title: 'Modelo',
        field: 'modelo',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
      ),
      PlutoColumn(
        backgroundColor: Colors.grey,
        frozen: PlutoColumnFrozen.left,
        title: 'Descripcion',
        field: 'descripcion',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
      ),
      PlutoColumn(
        backgroundColor: Colors.grey,
        frozen: PlutoColumnFrozen.left,
        title: 'Talla',
        field: 'talla',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
      ),
      PlutoColumn(
        backgroundColor: Colors.grey,
        frozen: PlutoColumnFrozen.left,
        title: 'Stock',
        field: 'stock',
        type: PlutoColumnType.text(),
        enableEditingMode: true,
      ),
      PlutoColumn(
        backgroundColor: Colors.grey,
        frozen: PlutoColumnFrozen.left,
        title: 'Unidad',
        field: 'unidad',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
      ),
    ];
  }

  List<PlutoRow> _createRows() {
    List<PlutoRow> rows = [];

    final testMap = data.asMap();

    testMap.forEach(
      (index, value) {
        rows.add(PlutoRow(cells: {
          'producto': PlutoCell(value: testMap[index]!['producto'].toString()),
          'modelo': PlutoCell(value: testMap[index]!['modelo'].toString()),
          'descripcion':
              PlutoCell(value: testMap[index]!['descripcion'].toString()),
          'talla': PlutoCell(value: testMap[index]!['talla'].toString()),
          'stock': PlutoCell(value: testMap[index]!['stock'].toString()),
          'unidad': PlutoCell(value: testMap[index]!['unidad'].toString()),
        }));
      },
    );

    return rows;
  }

/*
 +-+-+-+-+-+-+-+-+ +-+-+ +-+-+ +-+-+ +-+-+ +-+-+-+-+-+
 |R|e|f|r|e|s|c|a| |l|a| |U|I| |d|e| |l|a| |T|a|b|l|a|
 +-+-+-+-+-+-+-+-+ +-+-+ +-+-+ +-+-+ +-+-+ +-+-+-+-+-+
*/

  void handleRenderGrid() {
    stateManager.removeRows(stateManager.rows);
    stateManager.appendRows(_createRows());
  }

  getColumnID(int? columnIdx) {
    switch (columnIdx) {
      case 0:
        return 'producto';
        break;
      case 1:
        return 'modelo';
        break;
      case 2:
        return 'descripcion';
        break;
      case 3:
        return 'talla';
        break;
      case 4:
        return 'stock';
        break;
      case 5:
        return 'unidad';
        break;
      default:
    }
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar',
                      label: Text('Buscar Material'),
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                MaterialButton(
                  onPressed: () {},
                  height: 50.0,
                  color: Colors.blue,
                  child: const Text(
                    '+ Agregar Material',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Wrap(
            children: [
              const CardSiniestro(
                titulo: 'Stock Bajo ',
                chipColor: Colors.redAccent,
                chipText1: 'Bota Industrial',
                chipText2: 'Guantes de carnaza',
              ),
              CardSiniestro(
                titulo: 'Stock en 0',
                chipColor: Colors.yellow.shade800,
                chipText1: '',
                chipText2: '',
              ),
            ],
          ),
          //Tabla
        ],
      ),
    );
  }
}

class CardSiniestro extends StatelessWidget {
  const CardSiniestro({
    Key? key,
    this.titulo,
    this.chipColor,
    this.chipText1,
    this.chipText2,
  }) : super(key: key);

  final String? titulo;
  final Color? chipColor;
  final String? chipText1;
  final String? chipText2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 200,
      child: InkWell(
        hoverColor: Colors.grey.shade400,
        splashColor: Colors.red,
        borderRadius: BorderRadius.circular(15.0),
        onTap: (() {}),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 20.0,
          color: Colors.blue.shade700,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  titulo!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const Divider(
                color: Colors.grey,
                height: 6.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Chip(
                        elevation: 10.0,
                        backgroundColor: chipColor,
                        shadowColor: Colors.grey,
                        label: Text(
                          chipText1!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Chip(
                        elevation: 10.0,
                        backgroundColor: chipColor,
                        shadowColor: Colors.grey,
                        label: Text(
                          chipText2!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
*/