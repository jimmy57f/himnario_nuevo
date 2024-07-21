// alabanzas_elegidas_screen.dart

import 'package:HimnarioID/alabanza_detail_screen.dart';
import 'package:flutter/material.dart';
import 'alabanza.dart';

class AlabanzasElegidasScreen extends StatefulWidget {
  final List<Alabanza> alabanzasElegidas;
  final Function(Alabanza) removeAlabanzaElegida;
  final Function() clearAlabanzasElegidas;

  const AlabanzasElegidasScreen(this.alabanzasElegidas,
      this.removeAlabanzaElegida, this.clearAlabanzasElegidas,
      {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AlabanzasElegidasScreenState createState() =>
      _AlabanzasElegidasScreenState();
}

class _AlabanzasElegidasScreenState extends State<AlabanzasElegidasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Semantics(
          label: 'Alabanzas Elegidas',
          child: const Text('Alabanzas Elegidas',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        actions: [
          Semantics(
            label: 'Eliminar todas las alabanzas elegidas',
            child: IconButton(
              icon: const Icon(Icons.delete_forever, color: Colors.red),
              onPressed: () {
                widget.clearAlabanzasElegidas();
                setState(() {});
              },
            ),
          ),
        ],
      ),
      body: widget.alabanzasElegidas.isEmpty
          ? Center(
              child: Semantics(
                label: 'No hay alabanzas elegidas',
                child: const Text('No hay alabanzas elegidas',
                    style: TextStyle(color: Colors.black)),
              ),
            )
          : ListView.builder(
              itemCount: widget.alabanzasElegidas.length,
              itemBuilder: (context, index) {
                Alabanza alabanza = widget.alabanzasElegidas[index];
                return Semantics(
                  label:
                      'Alabanza número ${alabanza.numero}, ${alabanza.titulo}',
                  child: ListTile(
                    title: Text('${alabanza.numero}. ${alabanza.titulo}',
                        style: const TextStyle(fontSize: 16.0)),
                    trailing: Semantics(
                      label:
                          'Eliminar alabanza número ${alabanza.numero}, ${alabanza.titulo}',
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          widget.removeAlabanzaElegida(alabanza);
                          setState(() {});
                        },
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AlabanzaDetailScreen(alabanza: alabanza),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
