import 'package:flutter/material.dart';

class ListingsPage extends StatelessWidget {
  const ListingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Image.network(
          'https://firebasestorage.googleapis.com/v0/b/podium-78b4e.appspot.com/o/coming-soon-image.png?alt=media&token=e6607041-9bb7-4b9b-9255-bbefd5faf86e'),
    );
  }
}
