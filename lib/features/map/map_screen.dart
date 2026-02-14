import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../geofence/proximity_inidicator.dart';
import '../camera_ml/camera_screen.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  static const LatLng crisisPoint = LatLng(-3.99313, -79.20422);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: crisisPoint,
              zoom: 18,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: {
              const Marker(
                markerId: MarkerId("crisis"),
                position: crisisPoint,
              ),
            },
          ),

          /// Radar visual
          const Center(child: ProximityIndicator()),

          /// Botón de escaneo siempre visible para la demo
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CameraScreen(),
                  ),
                );
              },
              child: const Text(
                "Escanear residuo",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
