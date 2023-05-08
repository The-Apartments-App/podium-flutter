import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
        Navigator.of(context).pushNamed('/blogs', arguments: widget.blogId),
        // launchUrl(Uri.parse(widget.url)),
        debugPrint('blog link clicked'),
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 500, maxWidth: 500),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: widget.imageUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
    );
  }
}
