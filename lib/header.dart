import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Semantics(
          label: 'Título principal de la aplicación: Himnario ID',
          child: const Text(
            "Himnario ID",
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 35,
        ),
        Semantics(
          label: 'Logo de la aplicación, imagen de bautizos',
          child: Center(
            child: Image.asset(
              "assets/BAUTIZOS.png",
              width: 350,
              semanticLabel: 'Logo de la aplicación mostrando bautizos',
            ),
          ),
        ),
      ],
    );
  }
}
