import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Center(
        child: Semantics(
          label: "Logo de bautizos",
          child: Image.asset(
            "assets/BAUTIZOS.png",
            width: 350,
          ),
        ),
      ),
    );
  }
}
