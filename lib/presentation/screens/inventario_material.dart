import 'package:dynamic_table/dynamic_table.dart';
import 'package:flutter/material.dart';
import 'package:proyemexa_inventario_web/presentation/utils/custom_drawer.dart';

class InventarioMateriales extends StatefulWidget {
  const InventarioMateriales({super.key});

  @override
  State<InventarioMateriales> createState() => _InventarioMaterialesState();
}

class _InventarioMaterialesState extends State<InventarioMateriales> {
  var tableKey = GlobalKey<DynamicTableState>();
  List<String> genderDropdown = ["Male", "Female"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      drawer: buildDrawer(context),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.shade700,
        title: const Text('Inventario Materiales'),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/home'),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: DynamicTable(
          key: tableKey,
          header: const Text("Person Table"),
          rowsPerPage: 5,
          showFirstLastButtons: true,
          availableRowsPerPage: const [5, 10, 15, 20], // rowsPerPage
          columnSpacing: 60,
          showCheckboxColumn: true,
          onRowsPerPageChanged: (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Rows Per Page Changed to $value"),
              ),
            );
          },
          columns: [
            DynamicTableDataColumn(
                label: const Text("Name"),
                onSort: (columnIndex, ascending) {},
                dynamicTableInputType: DynamicTableTextInput()),
            // dynamicTableInputType: DynamicTableInputType.text()),
            DynamicTableDataColumn(
                label: const Text("Unique ID"),
                onSort: (columnIndex, ascending) {},
                isEditable: false,
                dynamicTableInputType: DynamicTableTextInput()),
            // dynamicTableInputType: DynamicTableInputType.text()),
            DynamicTableDataColumn(
              label: const Text("Birth Date"),
              onSort: (columnIndex, ascending) {},
              // dynamicTableInputType: DynamicTableDateInput()
              dynamicTableInputType: DynamicTableInputType.date(
                context: context,
                decoration: const InputDecoration(
                    hintText: "Select Birth Date",
                    suffixIcon: Icon(Icons.date_range),
                    border: OutlineInputBorder()),
                initialDate: DateTime(1900),
                lastDate: DateTime.now().add(
                  const Duration(days: 365),
                ),
              ),
            ),
            DynamicTableDataColumn(
              label: const Text("Gender"),
              dynamicTableInputType: DynamicTableInputType.dropDown<String>(
                items: genderDropdown
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(growable: false),
                selectedItemBuilder: (context) {
                  return genderDropdown
                      .map((e) => Text(e))
                      .toList(growable: false);
                },
                decoration: const InputDecoration(
                    hintText: "Select Gender", border: OutlineInputBorder()),
                displayBuilder: (value) =>
                    value ??
                    "", // How the string will be displayed in non editing mode
              ),
            ),
            DynamicTableDataColumn(
                label: const Text("Other Info"),
                onSort: (columnIndex, ascending) {},
                dynamicTableInputType: DynamicTableInputType.text(
                  decoration: const InputDecoration(
                    hintText: "Enter Other Info",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 100,
                )),
          ],
          rows: [
            DynamicTableDataRow(
              index: 0,
              onSelectChanged: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: value ?? false
                        ? Text("Row Selected index:")
                        : Text("Row Unselected index:"),
                  ),
                );
              },
              cells: [
                DynamicTableDataCell(value: "Name"),
                DynamicTableDataCell(value: "101"),
                DynamicTableDataCell(value: DateTime(2000, 2, 11)),
                DynamicTableDataCell(value: "Male"),
                DynamicTableDataCell(value: "Some other info about Aakash"),
              ],
            ),
            DynamicTableDataRow(
              index: 1,
              onSelectChanged: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: value ?? false
                        ? Text("Row Selected index:")
                        : Text("Row Unselected index:"),
                  ),
                );
              },
              cells: [
                DynamicTableDataCell(value: "Enquique"),
                DynamicTableDataCell(value: "101"),
                DynamicTableDataCell(value: DateTime(2000, 2, 11)),
                DynamicTableDataCell(value: "Male"),
                DynamicTableDataCell(value: "Some other info about Aakash"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*
/*
 ____ ____ ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____
||C |||r |||e |||a |||c |||i |||o |||n |||       |||t |||a |||b |||l |||a ||
||__|||__|||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__||
|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|
*/
  PlutoGrid _createTable() {
    return PlutoGrid(
      columns: _createColumns(),
      rows: _createRows(),
      onChanged: (event) {
        print(event);

        var columnID = getColumnID(event.columnIdx);
        buffer['Material'][event.rowIdx][columnID] = event.value.toString();

        FirebaseFirestore.instance
            .collection('Inventario')
            .doc('material')
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
      },
      onLoaded: (event) {
        stateManager = event.stateManager;
        event.stateManager.setSelectingMode(PlutoGridSelectingMode.cell);
        _isStateManagerInit = true;
        event.stateManager.setShowColumnFilter(true);
      },
    );
  }

  List<PlutoColumn> _createColumns() {
    return [
      PlutoColumn(
        backgroundColor: Colors.grey,
        frozen: PlutoColumnFrozen.left,
        title: 'id',
        field: 'id',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        width: 70,
      ),
      PlutoColumn(
        backgroundColor: Colors.grey,
        frozen: PlutoColumnFrozen.left,
        title: 'Material',
        field: 'material',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        width: 300,
      ),
      PlutoColumn(
        backgroundColor: Colors.grey,
        frozen: PlutoColumnFrozen.left,
        title: 'Modelo',
        field: 'modelo',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        width: 250,
      ),
      PlutoColumn(
        backgroundColor: Colors.grey,
        frozen: PlutoColumnFrozen.left,
        title: 'Descripcion',
        field: 'descripcion',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        width: 250,
      ),
      PlutoColumn(
        backgroundColor: Colors.grey,
        frozen: PlutoColumnFrozen.left,
        title: 'Stock',
        field: 'stock',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100,
      ),
      PlutoColumn(
        backgroundColor: Colors.grey,
        frozen: PlutoColumnFrozen.left,
        title: 'Tipo De Envace',
        field: 'tipo_envace',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        width: 150,
      ),
      PlutoColumn(
        backgroundColor: Colors.grey,
        frozen: PlutoColumnFrozen.left,
        title: 'Unidad Por Envace',
        field: 'unidad_envace',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        width: 150,
      ),
      PlutoColumn(
        backgroundColor: Colors.grey,
        frozen: PlutoColumnFrozen.left,
        title: 'Cantidad',
        field: 'cantidad',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        width: 100,
      ),
    ];
  }

  List<PlutoRow> _createRows() {
    List<PlutoRow> rows = [];

    final testMap = data.asMap();

    testMap.forEach((index, value) {
      rows.add(PlutoRow(cells: {
        'id': PlutoCell(value: testMap[index]!['id'].toString()),
        'material': PlutoCell(value: testMap[index]!['material'].toString()),
        'modelo': PlutoCell(value: testMap[index]!['modelo'].toString()),
        'descripcion':
            PlutoCell(value: testMap[index]!['descripcion'].toString()),
        'stock': PlutoCell(value: testMap[index]!['stock'].toString()),
        'tipo_envace':
            PlutoCell(value: testMap[index]!['tipo_envace'].toString()),
        'unidad_envace':
            PlutoCell(value: testMap[index]!['unidad_envace'].toString()),
        'cantidad': PlutoCell(value: testMap[index]!['cantidad'].toString()),
      }));
    });
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
      case 1:
        return 'material';
        break;
      case 2:
        return 'modelo';
        break;
      case 3:
        return 'descripcion';
        break;
      case 4:
        return 'stock';
        break;
      case 5:
        return 'tipo_envace';
        break;
      case 6:
        return 'unidad_envace';
        break;
      case 7:
        return 'cantidad';
        break;
      default:
    }
  }

  //Analiza el stock bajo
  // y stock en cero
  void _checkStock() {
    final testMap = data.asMap();
    //Limpiamos la lista
    stockCero.clear();
    stockBajo.clear();

    testMap.forEach((index, value) {
      // Buscamos el stock en cero
      int _stockCero = int.parse(testMap[index]!['stock']);
      if (_stockCero == 0) {
        //debugPrint('[DEBUG] Stock en cero Index: $index');
        stockCero.add(testMap[index]!['material']);
      }

      // Buscamos stock bajo
      if (_stockCero < 5 && _stockCero > 0) {
        //debugPrint('[DEBUG] Stock bajo Index: $index');
        stockBajo.add(testMap[index]!['material']);
      }
    });
  }
}

/*
██╗  ██╗███████╗ █████╗ ██████╗ ███████╗██████╗
██║  ██║██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗
███████║█████╗  ███████║██║  ██║█████╗  ██████╔╝
██╔══██║██╔══╝  ██╔══██║██║  ██║██╔══╝  ██╔══██╗
██║  ██║███████╗██║  ██║██████╔╝███████╗██║  ██║
╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝

*/
class Header extends StatelessWidget {
  const Header({Key? key, required this.stockCero, required this.stockBajo})
      : super(key: key);
  final List<String> stockCero;
  final List<String> stockBajo;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
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
              CardSiniestro(
                titulo: 'Stock en cero',
                chipColor: Colors.red,
                chipText: stockCero,
              ),
              CardSiniestro(
                titulo: 'Stock Bajo',
                chipColor: Colors.yellow.shade800,
                chipText: stockBajo,
              ),
            ],
          ),
          //Tabla
        ],
      ),
    );
  }
}

/*
 ██████╗ █████╗ ██████╗ ██████╗
██╔════╝██╔══██╗██╔══██╗██╔══██╗
██║     ███████║██████╔╝██║  ██║
██║     ██╔══██║██╔══██╗██║  ██║
╚██████╗██║  ██║██║  ██║██████╔╝
 ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝

*/
class CardSiniestro extends StatelessWidget {
  const CardSiniestro({
    Key? key,
    this.titulo,
    this.chipColor,
    this.chipText,
  }) : super(key: key);

  final String? titulo;
  final Color? chipColor;
  final List<String>? chipText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 280,
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
                  children: _createChips(),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  _createChips() {
    List<Widget> chips = [];
    chipText?.forEach((element) {
      chips.add(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Chip(
            elevation: 10.0,
            backgroundColor: chipColor,
            shadowColor: Colors.grey,
            label: Text(
              element,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    });
    return chips;
  }
}
*/