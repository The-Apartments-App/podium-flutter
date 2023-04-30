import 'package:flutter/material.dart';

class HomePageIcon extends StatelessWidget {
  const HomePageIcon({
    super.key,
    required this.icon,
    this.size = 20,
    this.color = Colors.black,
  });

  final IconData icon;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}
