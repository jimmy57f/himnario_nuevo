import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'alabanza.dart';
import 'alabanza_detail_screen.dart';
import 'data.dart';
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
  bool showMessage = false;

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

  void showAddDialog(BuildContext context, Alabanza alabanza) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 600),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: const Text(
                            'Agregado Correctamente',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Cierra el diálogo
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          'Cerrar',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    // Mostrar el mensaje con animación después de 500ms
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        showMessage = true;
      });
    });
  }

  void addAlabanzaElegida(Alabanza alabanza) {
    setState(() {
      if (!alabanzasElegidas.contains(alabanza)) {
        alabanzasElegidas.add(alabanza);
        saveAlabanzasElegidas();
        showAddDialog(context, alabanza);
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
        title: const Text(
          'Himnario Iglesia De Dios',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Buscar alabanza...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: alabanzasFiltradas.isEmpty
                ? const Center(child: Text('No se encontraron alabanzas'))
                : ListView.builder(
                    itemCount: alabanzasFiltradas.length,
                    itemBuilder: (context, index) {
                      Alabanza alabanza = alabanzasFiltradas[index];
                      return ListTile(
                        title: Text(
                          '${alabanza.numero}. ${alabanza.titulo}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            addAlabanzaElegida(alabanza);
                          },
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
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.list,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AlabanzasElegidasScreen(alabanzasElegidas,
                    removeAlabanzaElegida, clearAlabanzasElegidas)),
          );
        },
      ),
    );
  }
}
