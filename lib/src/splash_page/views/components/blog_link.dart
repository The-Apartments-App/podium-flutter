import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogLink extends StatefulWidget {
  const BlogLink({
    super.key,
    required this.url,
    required this.imageUrl,
    required this.headline,
  });

  final String url;
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
        launchUrl(Uri.parse(widget.url)),
        debugPrint('blog link clicked'),
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 190,
          minWidth: 150,
          maxHeight: 350,
          maxWidth: 350,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .25,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: widget.imageUrl,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Text(
                widget.headline,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
