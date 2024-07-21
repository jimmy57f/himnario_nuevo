import 'package:HimnarioID/convenciones.dart';
import 'package:HimnarioID/pdf_list_screen.dart';
import 'package:flutter/material.dart';

import 'package:HimnarioID/alabanzas_list_screen.dart';

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(children: <Widget>[
            Semantics(
              label: 'Título de la aplicación: Himnario ID',
              child: const Text(
                "Himnario ID",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Semantics(
              label: 'Imagen de bautizos',
              child: Center(
                child: Image.asset(
                  "assets/BAUTIZOS.png",
                  width: 350,
                  semanticLabel: 'Logo de la aplicación mostrando bautizos',
                ),
              ),
            ),
          ]),
          Column(children: <Widget>[
            Semantics(
              label: 'Botón Himnario Seleccionado',
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.black, // Cambiar color de fondo del botón
                ),
                child: const Text("Himnario Seleccionado",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return AlabanzasListScreen();
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(1.0, 0.0);
                        var end = Offset.zero;
                        var curve = Curves.easeOut;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 500),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Semantics(
              label: 'Botón Himnos Lema',
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.black, // Cambiar color de fondo del botón
                ),
                child: const Text("Himnos Lema",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const Convenciones();
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(1.0, 0.0);
                        var end = Offset.zero;
                        var curve = Curves.easeOut;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 500),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Semantics(
              label: 'Botón Escuelas Sabáticas',
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.black, // Cambiar color de fondo del botón
                ),
                child: const Text("Escuelas Sabáticas",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return PDFListScreen();
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(1.0, 0.0);
                        var end = Offset.zero;
                        var curve = Curves.easeOut;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 500),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Semantics(
              label: 'Botón Pistas',
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.black, // Cambiar color de fondo del botón
                ),
                child: const Text("Pistas",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                onPressed: () {
                  showAvailableSoonDialog(context);
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ])
        ],
      ),
    );
  }
}

void showAvailableSoonDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 600),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: const Text(
                      'Disponible Pronto',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              Semantics(
                label: 'Botón para cerrar el diálogo',
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.black // Cambiar color de fondo del botón
                      ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cerrar',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
