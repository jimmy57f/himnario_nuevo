// alabanzas_list_screen.dart

// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields

import 'package:flutter/material.dart';
import 'alabanza_juvenil.dart'; // Importa la clase Alabanza
import 'juvenil_detail_screen.dart'; // Importa la pantalla de detalle de la alabanza
import 'data_juvenil.dart'; // Importa la función fetchAlabanzas

class JuvenilListScreen extends StatefulWidget {
  @override
  _JuvenilListScreenState createState() => _JuvenilListScreenState();
}

class _JuvenilListScreenState extends State<JuvenilListScreen> {
  List<Juvenil> alabanzas = [];
  List<Juvenil> alabanzasFiltradas = [];

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadAlabanzas();
    _controller.addListener(onSearchTextChanged);
  }

  Future<void> loadAlabanzas() async {
    List<Juvenil> loadedAlabanzas = await fetchAlabanzasJuveniles();
    setState(() {
      alabanzas = loadedAlabanzas;
      alabanzasFiltradas = loadedAlabanzas;
    });
  }

  void onSearchTextChanged() {
    setState(() {
      String searchText = _controller.text.toLowerCase();
      alabanzasFiltradas = alabanzas
          .where((alabanza) =>
              alabanza.numero.toString().contains(searchText) ||
              alabanza.titulo.toLowerCase().contains(searchText))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Semantics(
          header: true,
          label: 'Lista de himnos de las Convenciones Juveniles',
          child: const Text(
            'Convenciones Juveniles',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Semantics(
              label: 'Campo de búsqueda para encontrar himnos lema',
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Buscar himno lema...',
                  hintText: 'Ingrese el número o título del himno',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Expanded(
            child: alabanzasFiltradas.isEmpty
                ? Center(
                    child: Semantics(
                      label: 'No se encontraron alabanzas',
                      child: const Text('No se encontraron alabanzas'),
                    ),
                  )
                : ListView.builder(
                    itemCount: alabanzasFiltradas.length,
                    itemBuilder: (context, index) {
                      Juvenil alabanza = alabanzasFiltradas[index];
                      return Semantics(
                        button: true,
                        label:
                            'Alabanza número ${alabanza.numero}, ${alabanza.titulo}',
                        child: ListTile(
                          title: Text(
                            '${alabanza.numero}. ${alabanza.titulo}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    JuvenilDetailScreen(alabanza: alabanza),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
