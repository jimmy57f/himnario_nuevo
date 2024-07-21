import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PDFViewerScreen extends StatefulWidget {
  final String pdfAssetPath;

  const PDFViewerScreen(this.pdfAssetPath, {super.key});

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  String? localFilePath;
  int? _totalPages;
  int? _currentPage;
  late PDFViewController _pdfViewController;

  @override
  void initState() {
    super.initState();
    _preparePdf();
  }

  Future<void> _preparePdf() async {
    try {
      final ByteData bytes = await rootBundle.load(widget.pdfAssetPath);
      final Uint8List list = bytes.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/temp.pdf').create();
      file.writeAsBytesSync(list);
      setState(() {
        localFilePath = file.path;
      });
    } catch (e) {
      // Error handling
      print('Error loading PDF: $e');
    }
  }

  void _goToPage(int page) {
    if (_pdfViewController != null) {
      _pdfViewController.setPage(page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Visualizador de PDF'),
        actions: [
          if (_totalPages != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Semantics(
                label: 'Página actual',
                child: Center(child: Text('Página $_currentPage/$_totalPages')),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Página Anterior',
            onPressed: () {
              if (_currentPage != null && _currentPage! > 1) {
                _goToPage(_currentPage! - 1);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            tooltip: 'Página Siguiente',
            onPressed: () {
              if (_currentPage != null && _currentPage! < _totalPages!) {
                _goToPage(_currentPage! + 1);
              }
            },
          ),
        ],
      ),
      body: localFilePath != null
          ? PDFView(
              filePath: localFilePath!,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              pageSnap: false,
              pageFling: false,
              onRender: (pages) {
                setState(() {
                  _totalPages = pages;
                });
              },
              onViewCreated: (PDFViewController pdfViewController) {
                _pdfViewController = pdfViewController;
                pdfViewController.getCurrentPage().then((page) {
                  setState(() {
                    _currentPage = page;
                  });
                });
              },
              onPageChanged: (int? page, int? total) {
                setState(() {
                  _currentPage = page;
                });
              },
              onError: (error) {
                // Error handling
                print('PDF View Error: $error');
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
