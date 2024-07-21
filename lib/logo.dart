import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Semantics(
        label: 'Logo de la aplicación, imagen de iglesia de Dios',
        child: Center(
          child: Image.asset(
            "assets/BAUTIZOS.png",
            width: 350,
            semanticLabel: 'Logo de la aplicación mostrando Iglesia de Dios',
          ),
        ),
      ),
    );
  }
}
