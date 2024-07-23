import 'package:flutter/material.dart';
import 'alabanza_femenil.dart'; // Importa la clase Alabanza

class FemenilDetailScreen extends StatelessWidget {
  final Femenil alabanza;

  const FemenilDetailScreen({super.key, required this.alabanza});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Semantics(
          header: true, // Indica que esto es un encabezado
          label: 'Título de la alabanza: ${alabanza.titulo}',
          child: Text(
            alabanza.titulo,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Semantics(
              label: 'Información de la convención',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExcludeSemantics(
                    child: Text(
                      'Convención:',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  Text(
                    '${alabanza.numero}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Semantics(
              label: 'Letra de la alabanza',
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  alabanza.letra,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
