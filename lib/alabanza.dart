// alabanza.dart

class Alabanza {
  final int numero;
  final String titulo;
  final String letra;

  Alabanza({required this.numero, required this.titulo, required this.letra});

  factory Alabanza.fromJson(Map<String, dynamic> json) {
    return Alabanza(
      numero: json['numero'],
      titulo: json['titulo'],
      letra: json['letra'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'numero': numero,
      'titulo': titulo,
      'letra': letra,
    };
  }
}
