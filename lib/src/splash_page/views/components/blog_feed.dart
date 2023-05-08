import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:podium/src/splash_page/views/components/blog_link.dart';

class BlogFeed extends StatefulWidget {
  const BlogFeed({super.key});

  @override
  State<BlogFeed> createState() => _BlogFeedState();
}

class _BlogFeedState extends State<BlogFeed> {
  final blogCarouselController = CarouselController();

  bool? isMobile;
  @override
  Widget build(BuildContext context) {
    final mobileBlogFeed = Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 500, maxWidth: 400),
          child: CarouselSlider(
            carouselController: blogCarouselController,
            options: CarouselOptions(enableInfiniteScroll: false),
            items: const [
              BlogLink(
                blogId: 'blog1',
                imageUrl:
                    'https://images.unsplash.com/photo-1659621222272-f65c27b6f182?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTd8fHBvZGl1bSUyMGFwYXJ0bWVudHN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                headline:
                    '''Introducing Podium: Revolutionizing Apartment Living and Leaving the Old Ways Behind''',
              )
            ],
          ),
        ),
      ],
    );
    const desktopBlogFeed = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlogLink(
          blogId: 'blog1',
          imageUrl:
              'https://images.unsplash.com/photo-1659621222272-f65c27b6f182?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTd8fHBvZGl1bSUyMGFwYXJ0bWVudHN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
          headline:
              '''Introducing Podium: Revolutionizing Apartment Living and Leaving the Old Ways Behind''',
        ),
      ],
    );
    isMobile = MediaQuery.of(context).size.width < 700;
    return Wrap(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Text(
                'Blogs',
                style: TextStyle(
                  fontSize: isMobile! == false ? 32 : 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 20),
            //   child: Text(
            //     'These blogs are getting lots of attention on Podium.',
            //     style: TextStyle(
            //       fontSize: isMobile! == false ? 18 : 14,
            //       fontWeight: FontWeight.w300,
            //     ),
            //   ),
            // ),
            if (isMobile! != false) mobileBlogFeed else desktopBlogFeed
          ],
        ),
        // if (MediaQuery.of(context).size.width < 700)
        //   Padding(
        //     padding: const EdgeInsets.only(top: 8),
        //     child: Wrap(
        //       children: <Widget>[
        //         ElevatedButton(
        //           onPressed: blogCarouselController.previousPage,
        //           style: ButtonStyle(
        //             shape: const MaterialStatePropertyAll(
        //               RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.all(Radius.circular(100)),
        //               ),
        //             ),
        //             foregroundColor:
        //                 const MaterialStatePropertyAll(Colors.black87),
        //             shadowColor:
        //                 const MaterialStatePropertyAll(Colors.transparent),
        //             side: MaterialStatePropertyAll(
        //               BorderSide(color: Colors.grey.shade300),
        //             ),
        //             backgroundColor:
        //                 const MaterialStatePropertyAll(Colors.transparent),
        //           ),
        //           child: const Text('<'),
        //         ),
        //         ElevatedButton(
        //           onPressed: blogCarouselController.nextPage,
        //           style: const ButtonStyle(
        //             shape: MaterialStatePropertyAll(
        //               RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.all(Radius.circular(100)),
        //               ),
        //             ),
        //             foregroundColor: MaterialStatePropertyAll(Colors.black),
        //             shadowColor: MaterialStatePropertyAll(Colors.transparent),
        //             side: MaterialStatePropertyAll(
        //               BorderSide(color: Colors.grey),
        //             ),
        //             backgroundColor:
        //                 MaterialStatePropertyAll(Colors.transparent),
        //           ),
        //           child: const Text('>'),
        //         ),
        //       ],
        //     ),
        //   )
      ],
    );
  }
}
