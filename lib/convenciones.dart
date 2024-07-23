// ignore_for_file: deprecated_member_use

import 'package:HimnarioID/femenil/femenil_list_screen.dart';
import 'package:HimnarioID/juvenil/juvenil_list_screen.dart';
import 'package:HimnarioID/widgets/Header_Convenciones.dart';
import 'package:flutter/material.dart';

class Convenciones extends StatelessWidget {
  const Convenciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Himnos Lema',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const Column(children: <Widget>[
                HeaderConvenciones(),
              ]),
              Column(children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.black, // Cambiar color de fondo del botón
                  ),
                  child: const Text(" JUVENIL",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 247, 247),
                          fontSize: 16)),
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return JuvenilListScreen();
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
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.black, // Cambiar color de fondo del botón
                  ),
                  child: const Text(" FEMENIL",
                      style: TextStyle(
                          color: Color.fromARGB(255, 250, 250, 250),
                          fontSize: 16)),
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FemenilListScreen();
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
                const SizedBox(
                  height: 25,
                ),
              ])
            ],
          ),
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.red, // Cambiar color de fondo del botón
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
            ],
          ),
        ),
      );
    },
  );
}
