import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // Définir la durée de l'animation ici
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);
    _controller.forward();

    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/note');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Transform.scale(
            scale: 0.5, // Ajuster l'échelle selon vos besoins
            child: Image.asset(
              'assets/images/img.jpeg',
              // Remplacez par le chemin de votre image réelle
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
