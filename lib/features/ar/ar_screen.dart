import 'package:flutter/material.dart';

class ARScreen extends StatelessWidget {
  const ARScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Intervención AR")),
      body: const Center(
        child: Text(
          "Objeto AR aparecerá aquí",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
