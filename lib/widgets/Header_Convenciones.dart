// ignore_for_file: file_names

import 'package:flutter/material.dart';

class HeaderConvenciones extends StatelessWidget {
  const HeaderConvenciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Semantics(
            header: true,
            label: "Encabezado: Convenciones",
            child: const Text(
              "Convenciones",
              style: TextStyle(
                fontSize: 40,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 35),
        ],
      ),
    );
  }
}
