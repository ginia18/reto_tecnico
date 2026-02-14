import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'distance_provider.dart';

class ProximityIndicator extends ConsumerWidget {
  const ProximityIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final distance = ref.watch(distanceProvider);

    double size = 200;
    Color color = Colors.red;

    if (distance < 20) {
      color = Colors.orange;
      size = 150;
    }
    if (distance < 10) {
      color = Colors.yellow;
      size = 120;
    }
    if (distance < 5) {
      color = Colors.green;
      size = 80;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
    );
  }
}
