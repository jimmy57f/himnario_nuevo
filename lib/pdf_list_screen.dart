import 'package:flutter/material.dart';
import 'pdf_screen.dart';

class PDFListScreen extends StatelessWidget {
  final List<Map<String, String>> pdfFiles = [
    {
      'name': 'Escuela General',
      'path': 'assets/escuelageneral032024.pdf',
      'image': 'assets/general.jpg'
    },
    {
      'name': 'Escuela Juvenil',
      'path': 'assets/escuelajuvenil032024.pdf',
      'image': 'assets/jovenes.jpg'
    },
    {
      'name': 'Escuela Infantil',
      'path': 'assets/escuelainfantil032024.pdf',
      'image': 'assets/niños.jpg'
    },
    {
      'name': 'Escuela Femenil',
      'path': 'assets/escuelafemenil032024.pdf',
      'image': 'assets/femenil2.jpg'
    },
  ];

  PDFListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Escuelas Sabáticas',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: pdfFiles.length,
              itemBuilder: (context, index) {
                return Semantics(
                  label:
                      'Botón para abrir el PDF de ${pdfFiles[index]['name']}',
                  child: Card(
                    color: Colors.white,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: Image.asset(
                        pdfFiles[index]['image']!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(pdfFiles[index]['name']!),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PDFViewerScreen(pdfFiles[index]['path']!),
                          ),
                        );
                      },
                    ),
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
