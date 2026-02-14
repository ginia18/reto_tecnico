import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  ObjectDetector? _objectDetector;

  String _detectedObject = "Buscando objeto...";
  double _confidence = 0.0;

  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
    _initDetector();
  }

  void _initDetector() {
    final options = ObjectDetectorOptions(
      mode: DetectionMode.stream,
      classifyObjects: true,
      multipleObjects: false,
    );

    _objectDetector = ObjectDetector(options: options);
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    _cameraController = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _cameraController!.initialize();

    if (!mounted) return;

    setState(() {});

    _startDetectionLoop();
  }

  void _startDetectionLoop() {
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (!_cameraController!.value.isInitialized) return;
      if (_isProcessing) return;
      if (!mounted) return;

      _isProcessing = true;

      try {
        final file = await _cameraController!.takePicture();
        final inputImage = InputImage.fromFilePath(file.path);

        final objects = await _objectDetector!.processImage(inputImage);

        if (objects.isNotEmpty &&
            objects.first.labels.isNotEmpty) {
          final label = objects.first.labels.first;

          setState(() {
            _detectedObject = label.text;
            _confidence = label.confidence;
          });
        }
      } catch (e) {
        print("Error ML: $e");
      }

      _isProcessing = false;
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _objectDetector?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null ||
        !_cameraController!.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final canIntervene = _confidence > 0.8;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CameraPreview(_cameraController!),

          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _detectedObject,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Confianza: ${(_confidence * 100).toStringAsFixed(1)}%",
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: canIntervene
                        ? () {
                            Navigator.pushNamed(context, '/ar');
                          }
                        : null,
                    child: const Text("Intervenir"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
