import 'package:flutter/material.dart';

class PermissionErrorScreen extends StatelessWidget {
  const PermissionErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: const Center(
        child: Text(
          "Se requieren permisos de cámara y ubicación",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
