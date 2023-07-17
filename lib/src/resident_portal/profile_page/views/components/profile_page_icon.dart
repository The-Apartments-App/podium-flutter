import 'package:flutter/material.dart';

class ProfilePageIcon extends StatelessWidget {
  const ProfilePageIcon({
    super.key,
    required this.icon,
    this.size = 32,
    this.color = Colors.black,
  });

  final IconData icon;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Icon(
        icon,
        size: size,
        color: color,
        weight: .1,
      ),
    );
  }
}
