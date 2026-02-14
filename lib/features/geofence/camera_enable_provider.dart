import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'location_provider.dart';
import 'distance_provider.dart';

final cameraEnabledProvider = Provider<bool>((ref) {
  final position = ref.watch(locationStreamProvider).value;
  final distance = ref.watch(distanceProvider);

  if (position == null) return false;

  return distance < 5 && position.accuracy <= 5;
});
