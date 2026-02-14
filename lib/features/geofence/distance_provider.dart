import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'location_provider.dart';

const targetLat = -3.99313;
const targetLng = -79.20422;

final distanceProvider = Provider<double>((ref) {
  final position = ref.watch(locationStreamProvider).value;

  if (position == null) return 999;

  return Geolocator.distanceBetween(
    position.latitude,
    position.longitude,
    targetLat,
    targetLng,
  );
});
