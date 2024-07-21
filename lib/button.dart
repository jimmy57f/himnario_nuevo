import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed; // Cambia el tipo de onPressed a VoidCallback

  const Button({
    super.key,
    required this.text,
    required this.onPressed, // Usa la función onPressed pasada como parámetro
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: text, // Añade una etiqueta para el lector de pantalla
      button: true, // Indica que este widget es un botón
      child: ElevatedButton(
        onPressed: onPressed, // Asigna la función onPressed correcta
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, // Cambiar color de fondo del botón
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255), // Color del texto
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
