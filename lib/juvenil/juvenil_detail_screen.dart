import 'package:flutter/material.dart';
import 'alabanza_juvenil.dart'; // Importa la clase Alabanza

class JuvenilDetailScreen extends StatelessWidget {
  final Juvenil alabanza;

  const JuvenilDetailScreen({Key? key, required this.alabanza})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Semantics(
          header: true,
          child: Text(
            alabanza.titulo,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            semanticsLabel: 'Título de la alabanza: ${alabanza.titulo}',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Número de convención
            Semantics(
              label: 'Número de convención ${alabanza.numero}',
              child: Text(
                'Número: ${alabanza.numero}',
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                semanticsLabel: 'Número de convención: ${alabanza.numero}',
              ),
            ),
            const SizedBox(height: 10),
            // Letra de la alabanza
            Semantics(
              label: 'Letra de la alabanza ${alabanza.titulo}',
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  alabanza.letra,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                  semanticsLabel: 'Letra de la alabanza: ${alabanza.letra}',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
