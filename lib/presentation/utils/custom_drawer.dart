import 'package:flutter/material.dart';

buildDrawer(BuildContext context) {
  buildListTile(
      int index, IconData icon, String name, String imagen, Function accion) {
    return Container(
      child: ListTile(
        title: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: Colors.grey.shade400,
          hoverColor: Colors.blue,
          onPressed: () {
            Navigator.maybePop(context);
            accion();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(backgroundImage: AssetImage(imagen)),
              ),
              const SizedBox(width: 35.0),
              Text(
                name,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  return Container(
    width: 300,
    child: Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 15.0,
      child: Container(
        color: Colors.grey,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 130,
                    decoration: const BoxDecoration(color: Colors.grey),
                    child: const Center(
                      child: CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.account_box_rounded),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Hugo Mendoza Ramos',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                buildListTile(
                  0,
                  Icons.home,
                  'Inventario Seguridad',
                  'assets/images/icono_seguridad.png',
                  () {
                    Navigator.pushNamed(context, '/inventario_seguridad');
                  },
                ),
                buildListTile(
                  1,
                  Icons.inbox,
                  'Inventario Material',
                  'assets/images/icono_materiales.png',
                  () => Navigator.pushNamed(context, '/inventario_material'),
                ),
                buildListTile(
                    2,
                    Icons.delete,
                    'Inventario Herramientas',
                    'assets/images/icono_herramientas.png',
                    () => Navigator.pushNamed(
                        context, '/inventario_herramienta')),
                buildListTile(
                  3,
                  Icons.info,
                  'Siniestros',
                  'assets/images/icono_siniestros.png',
                  () => Navigator.pushNamed(context, '/siniestros'),
                ),
                buildListTile(
                    4,
                    Icons.chat,
                    'Personal',
                    'assets/images/icono_personal.png',
                    () => Navigator.pushNamed(context, '/personal')),
                buildListTile(
                    5,
                    Icons.login,
                    'Personal',
                    'assets/images/logout.png',
                    () => Navigator.pushNamed(context, '/home')),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
