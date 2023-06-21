import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';

class BlogStoryImage extends StatelessWidget {
  const BlogStoryImage({
    super.key,
    required this.blogImageName,
  });

  final String blogImageName;

  @override
  Widget build(BuildContext context) {
    String? url;

    Future<String> getBlogImage(String assetName) async {
      final storage = FirebaseStorage.instance;
      final ref =
          storage.ref().child('gs://podium-78b4e.appspot.com/$assetName.jpg');
      return url = await ref.getDownloadURL();
    }

    getBlogImage(blogImageName);
    debugPrint('url: $url');

    return FractionallySizedBox(
      widthFactor: 1.3,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: ProgressiveImage(
          placeholder: Image.asset(
            'lib/src/assets/images/podium_logo_round.png',
            fit: BoxFit.cover,
          ).image,
          thumbnail: Image.asset(
            'lib/src/assets/images/$blogImageName.jpg',
            fit: BoxFit.cover,
          ).image,
          image: url != null
              ? NetworkImage(url!)
              : Image.asset(
                  'lib/src/assets/images/podium_logo_round.png',
                  fit: BoxFit.cover,
                ).image,
          width: MediaQuery.of(context).size.width,
          height: 700,
        ),
      ),
    );
  }
}
