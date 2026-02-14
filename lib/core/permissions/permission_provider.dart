import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionProvider = FutureProvider<bool>((ref) async {
  final location = await Permission.location.request();
  final camera = await Permission.camera.request();

  return location.isGranted && camera.isGranted;
});
