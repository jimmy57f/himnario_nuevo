import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const Button({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: text,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, // Cambiar color de fondo del botón
        ),
        child: Text(
          text,
          style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), fontSize: 16),
        ),
      ),
    );
  }
}
