import 'package:flutter/material.dart';

class BlogStoryImage extends StatelessWidget {
  const BlogStoryImage({
    super.key,
    required this.blogImageName,
  });

  final String blogImageName;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.3,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Image.asset(
          'lib/src/assets/images/$blogImageName.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
