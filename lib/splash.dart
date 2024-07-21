import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:HimnarioID/my_app.dart'; // Asegúrate de importar el widget 'Principal'

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Inicialización del controlador de animación
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds: 1000), // Ajusta la duración según necesites
    );

    // Animación de escala para el contenedor del logo
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Animación de opacidad para el texto
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Iniciar las animaciones
    _controller.forward().then((_) {
      // Navegar a la pantalla principal después de que la animación termine
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const Principal();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.easeOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });

    // Configurar el modo de interfaz de usuario
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    _controller.dispose(); // Liberar recursos del controlador de animación
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Semantics(
              label: 'Logo de la aplicación',
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: Image.asset(
                      "assets/BAUTIZOS.png",
                      width: 400,
                      height: 400,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
            Semantics(
              label: 'Texto de la aplicación: IGLESIA DE DIOS',
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: const Text(
                  "IGLESIA DE DIOS",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Semantics(
              label: 'Texto de la aplicación: El Salvador',
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: const Text(
                  "El Salvador",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
