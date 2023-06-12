import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlogLink extends StatefulWidget {
  const BlogLink({
    super.key,
    required this.blogId,
    required this.imageUrl,
    required this.headline,
  });

  final String blogId;
  final String imageUrl;
  final String headline;

  @override
  State<BlogLink> createState() => _BlogLinkState();
}

class _BlogLinkState extends State<BlogLink> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        context.go('/blogs/${widget.blogId}'),
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 500,
          minWidth: 500,
          maxHeight: 500,
          maxWidth: 500,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .25,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Image(
                  fit: BoxFit.fill,
                  image: NetworkImage(widget.imageUrl),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Text(
                  widget.headline,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
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
