import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlogLink extends StatefulWidget {
  const BlogLink({
    super.key,
    required this.blogId,
    required this.imageUrl,
    required this.headline,
    required this.subtext,
  });

  final String blogId;
  final String imageUrl;
  final String headline;
  final String subtext;

  @override
  State<BlogLink> createState() => _BlogLinkState();
}

class _BlogLinkState extends State<BlogLink> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        context.push('/blogs/${widget.blogId}'),
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 400,
          minWidth: 320,
          maxHeight: 400,
          maxWidth: 550,
        ),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          elevation: 10,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.asset(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Text(
                  widget.headline,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: Text(
                  widget.subtext,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
