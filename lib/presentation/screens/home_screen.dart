import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Wrap(
          children: [
            Tarjeta(
              titulo: 'Inventario Seguridad',
              imagen: 'assets/images/icono_seguridad.png',
              color: Colors.blueAccent,
              callback: () =>
                  Navigator.pushNamed(context, '/inventario_seguridad'),
            ),
            Tarjeta(
              titulo: 'Inventario Materiales',
              imagen: 'assets/images/icono_materiales.png',
              color: Colors.lightGreen,
              callback: () =>
                  Navigator.pushNamed(context, '/inventario_material'),
            ),
            Tarjeta(
              titulo: 'Inventario Herramientas',
              imagen: 'assets/images/icono_herramientas.png',
              color: Colors.yellow[800],
              callback: () =>
                  Navigator.pushNamed(context, '/inventario_herramienta'),
            ),
            Tarjeta(
              titulo: 'Fichas Medicas',
              imagen: 'assets/images/registros_medicos.png',
              color: Colors.pinkAccent[100],
              callback: () => Navigator.pushNamed(context, '/fichas_medicas'),
            ),
            Tarjeta(
              titulo: 'Siniestros',
              imagen: 'assets/images/icono_siniestros.png',
              color: Colors.redAccent,
              callback: () => Navigator.pushNamed(context, '/siniestros'),
            ),
            Tarjeta(
              titulo: 'Personal',
              imagen: 'assets/images/icono_personal.png',
              color: Colors.orange[800],
              callback: () => Navigator.pushNamed(context, '/personal'),
            ),
          ],
        ),
      ),
    );
  }
}

class Tarjeta extends StatelessWidget {
  const Tarjeta({
    Key? key,
    this.titulo,
    this.color,
    this.imagen,
    @required this.callback,
  }) : super(key: key);

  final String? titulo;
  final String? imagen;
  final Color? color;
  final Function? callback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: InkWell(
        hoverColor: Colors.grey[400],
        borderRadius: BorderRadius.circular(10.0),
        splashColor: Colors.orange,
        onTap: () => callback!(),
        child: Card(
          color: color,
          elevation: 20.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 38.0,
                  child: Image(
                    fit: BoxFit.contain,
                    height: 60,
                    image: AssetImage(imagen!),
                  ),
                ),
                Text(
                  titulo!,
                  style: const TextStyle(color: Colors.white, fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
