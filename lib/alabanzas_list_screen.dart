import 'package:HimnarioID/data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'alabanza.dart';
import 'alabanza_detail_screen.dart';
import 'alabanzas_elegidas_screen.dart'; // Importa la pantalla de alabanzas elegidas

class AlabanzasListScreen extends StatefulWidget {
  @override
  _AlabanzasListScreenState createState() => _AlabanzasListScreenState();
}

class _AlabanzasListScreenState extends State<AlabanzasListScreen> {
  List<Alabanza> alabanzas = [];
  List<Alabanza> alabanzasFiltradas = [];
  List<Alabanza> alabanzasElegidas = [];

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadAlabanzas();
    loadAlabanzasElegidas();
    _controller.addListener(onSearchTextChanged);
  }

  Future<void> loadAlabanzas() async {
    List<Alabanza> loadedAlabanzas = await fetchAlabanzas();
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

  void showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alabanza Agregada'),
          content: const Text('La alabanza ha sido agregada a las elegidas.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void addAlabanzaElegida(Alabanza alabanza) {
    setState(() {
      if (!alabanzasElegidas.contains(alabanza)) {
        alabanzasElegidas.add(alabanza);
        saveAlabanzasElegidas();
        showAddDialog(context);
      }
    });
  }

  void removeAlabanzaElegida(Alabanza alabanza) {
    setState(() {
      alabanzasElegidas.remove(alabanza);
      saveAlabanzasElegidas();
    });
  }

  void clearAlabanzasElegidas() {
    setState(() {
      alabanzasElegidas.clear();
      saveAlabanzasElegidas();
    });
  }

  Future<void> saveAlabanzasElegidas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> alabanzas = alabanzasElegidas
        .map((alabanza) => json.encode(alabanza.toJson()))
        .toList();
    prefs.setStringList('alabanzasElegidas', alabanzas);
  }

  Future<void> loadAlabanzasElegidas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> alabanzas = prefs.getStringList('alabanzasElegidas') ?? [];
    setState(() {
      alabanzasElegidas = alabanzas
          .map((alabanza) => Alabanza.fromJson(json.decode(alabanza)))
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
          label: 'Himnario Iglesia De Dios',
          child: const Text(
            'Himnario Iglesia De Dios',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Semantics(
              label: 'Buscar alabanza',
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Buscar alabanza...',
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
                      Alabanza alabanza = alabanzasFiltradas[index];
                      return Semantics(
                        label:
                            'Alabanza número ${alabanza.numero}, ${alabanza.titulo}',
                        child: ListTile(
                          title: Text(
                            '${alabanza.numero}. ${alabanza.titulo}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          trailing: Semantics(
                            label:
                                'Agregar alabanza número ${alabanza.numero}, ${alabanza.titulo}',
                            child: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                addAlabanzaElegida(alabanza);
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
          ),
        ],
      ),
      floatingActionButton: Semantics(
        label: 'Ver alabanzas elegidas',
        child: FloatingActionButton(
          child: const Icon(
            Icons.list,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AlabanzasElegidasScreen(
                  alabanzasElegidas,
                  removeAlabanzaElegida,
                  clearAlabanzasElegidas,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
