import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ServiceRequestImage extends StatelessWidget {
  const ServiceRequestImage({super.key, required this.bytes});
  final Uint8List bytes;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.memory(
        fit: BoxFit.cover,
        bytes,
      ),
    );
  }
}
