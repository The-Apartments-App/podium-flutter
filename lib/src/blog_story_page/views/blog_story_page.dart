import 'package:flutter/material.dart';
import 'package:podium/shared/shared.dart';
import 'package:podium/src/podium_logo_with_title/podium_logo_with_title.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogStoryPage extends StatefulWidget {
  const BlogStoryPage({super.key, required this.blogId});

  final String blogId;

  @override
  State<BlogStoryPage> createState() => _BlogStoryPageState();
}

class _BlogStoryPageState extends State<BlogStoryPage> {
  Widget readBlog() {
    //display the correct blog based on the given blogId
    return const Placeholder();
  }

  final desktopPagePadding = const EdgeInsets.only(left: 64, right: 64);
  final mobilePagePadding = const EdgeInsets.only(left: 16, right: 16);

  final mobileTitleTextStyle =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.w500);

  final desktopTitleTextStyle =
      const TextStyle(fontSize: 36, fontWeight: FontWeight.w600);

  final mainTextStyle = const TextStyle(
    letterSpacing: 1,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
    height: 1.5,
  );

  final mobileHeadlineTextStyle =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  final desktopHeadlineTextStyle =
      const TextStyle(fontSize: 28, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Padding(
              padding:
                  isMobile(context) ? mobilePagePadding : desktopPagePadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [PodiumLogoWithTitle(height: 150)],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      '''Introducing Podium: Revolutionizing Apartment Living and Leaving the Old Ways Behind''',
                      style: isMobile(context)
                          ? mobileTitleTextStyle
                          : desktopTitleTextStyle,
                    ),
                  ),
                  const BlogAuthor(),
                  Text(
                    '''
Imagine a world where you walk into your favorite coffee shop, and no matter which city you're in, you know exactly what to expect. Trusting the brand and the experience is second nature. But when it comes to residential living, there's no such nationwide trusted brand to ensure a consistent experience. 

That's where Podium steps in, ready to revolutionize the way we live and rent. Drawing inspiration from personal apartment hunting experiences, we've seen the struggles firsthand - third-party websites, outdated communication methods, and endless phone calls. Social distancing measures have only exacerbated these issues, with self-guided tours and little interaction with leasing agents.

We knew there had to be a better way, and so the idea for Podium was born. By recognizing the misallocation of resources in traditional management companies, we decided to shift the focus to what really matters - the tenant experience and landlord efficiency.

Our tech-driven approach streamlines the entire rental process, bringing it into the modern era and making it more enjoyable for both parties. Podium is all about offering world-class designed apartments with a consistent feel from city to city. Our tech platform and management operations enable residents to know what to expect, no matter where they live.

This consistency is key to building trust and ensuring a seamless experience. At the heart of Podium's mission is a desire to understand and tackle the fragmentation and outdated practices in the apartment rental market.

We're here to shake things up, make a real difference, and disrupt the legacy real estate industry. By doing so, we aim to create a new era of residential living that benefits everyone. Addressing the housing affordability crisis is also on our agenda.

By promoting an efficient building style, we plan to expand our Podium network from city to city, making a lasting impact on the lives of renters. Through our innovative approach, we're on a mission to redefine the renter-landlord relationship. Podium is here to save tenants from the old ways and create a new standard in residential living that's long overdue.

Join us on this journey as we disrupt the status quo and bring you the apartment living experience you truly deserve.''',
                    style: mainTextStyle,
                    softWrap: true,
                  ),
                  const SizedBox(height: 32),
                  const BlogSection(
                    headline: 'The Need for Disruption',
                    body: '''
The rental market has long been plagued by inefficiencies, miscommunications, and a lack of transparency. Tenants often feel powerless, and landlords struggle to keep up with rapidly changing tenant expectations. In this environment, the need for disruption becomes clear.
                        
Podium aims to be the catalyst for change, introducing a new standard that promotes a higher quality of life for tenants while ensuring landlords can effectively manage their properties. By embracing technology and cutting-edge design, we're on the path to create a nationwide network of exceptional living spaces that cater to the needs of modern renters.''',
                  ),
                  const BlogSection(
                    headline: 'Innovation at Every Step',
                    body:
                        '''At Podium, we believe that innovation is key to driving positive change in the rental market. We've developed a suite of tools and services that streamline the entire renting process, from searching for an apartment to signing a lease and beyond.''',
                  ),
                  const BlogSection(
                    headline: 'The Power of Consistency',
                    body:
                        '''Consistency is at the core of the Podium experience. We believe that by providing a uniform experience across our properties, we can build trust with tenants and create a sense of familiarity no matter where they choose to live. This consistency extends to the design of our apartments, the amenities offered, and the overall living environment.''',
                  ),
                  const BlogSection(
                    headline:
                        'Introducing the 5-over-1 Podium Building Concept',
                    body: '''
A key element of Podium's innovative approach to apartment living lies in the adoption of the 5-over-1 building concept. This modern architectural style combines the best of both worlds – the efficient use of space and the creation of high-quality living environments for tenants.

The 5-over-1 building concept, also known as "podium buildings," features a ground floor made of concrete or steel, designed for commercial or retail spaces, with five floors of wood-framed residential units above. This design maximizes the use of available space and allows for the integration of essential amenities within the building itself. 

The benefits of the 5-over-1 building concept extend beyond efficient space utilization. By combining commercial and residential spaces in the same building, we foster a sense of community and encourage local businesses to thrive. This integration of mixed-use spaces contributes to the creation of vibrant, walkable neighborhoods that benefit both renters and the surrounding community.

Furthermore, the 5-over-1 design enables Podium to offer a more affordable living experience without sacrificing quality. The use of wood framing for the residential floors is not only more cost-effective but also environmentally friendly, as it has a lower carbon footprint than traditional concrete or steel construction.''',
                  ),
                  const BlogSection(
                    headline: 'A New Renter-Landlord Relationship',
                    body: '''
Podium is committed to transforming the renter-landlord relationship by fostering open communication and promoting transparency. Our platform facilitates seamless interactions between tenants and landlords, ensuring that both parties feel supported and informed throughout the rental process.

By streamlining communication and providing easy access to essential information, we aim to create a rental experience that is free from the frustrations and uncertainties often associated with traditional property management methods.''',
                  ),
                  const BlogSection(
                    headline: 'The Future of Apartment Living',
                    body: '''
At Podium, we're passionate about disrupting the status quo and ushering in a new era of apartment living. We believe that by combining cutting-edge technology, innovative design, and a focus on the needs of modern renters, we can create a nationwide network of exceptional living spaces that redefine the rental experience.

Our vision for the future is one where renters can trust in the consistency and quality of the Podium brand, knowing that no matter where they choose to live, they'll be met with the same exceptional standard of living. As we continue to grow and expand our reach, we remain committed to our core values of innovation, transparency, and tenant satisfaction. By staying true to these principles, we're confident that we can disrupt the old ways of the rental market and deliver the apartment living experience you deserve.

Join us on this journey as we challenge the status quo and work towards creating a better, brighter future for renters and landlords alike. Together, we can redefine the world of apartment living and create a new standard that truly benefits everyone.''',
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      PodiumLogoWithTitle(height: 80),
                      LinkedInLink(),
                      Text('© 2023 Podium Apartments Inc.')
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BlogAuthor extends StatelessWidget {
  const BlogAuthor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Row(
        children: [
          const Text('By'),
          const SizedBox(width: 2),
          InkWell(
            onTap: () {
              launchUrl(Uri.parse('podiumapartments.com'));
            },
            child: const DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(),
                ),
              ),
              child: Text(
                'Podium',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 4),
          const Text('May 2nd, 2023')
        ],
      ),
    );
  }
}

class BlogSection extends StatelessWidget {
  const BlogSection({
    super.key,
    required this.headline,
    required this.body,
  });
  final String headline;
  final String body;

  @override
  Widget build(BuildContext context) {
    const mainTextStyle = TextStyle(
      letterSpacing: 1,
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.black87,
      height: 1.5,
    );

    const mobileHeadlineTextStyle =
        TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
    const desktopHeadlineTextStyle =
        TextStyle(fontSize: 28, fontWeight: FontWeight.w500);

    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              headline,
              style: isMobile(context)
                  ? mobileHeadlineTextStyle
                  : desktopHeadlineTextStyle,
            ),
          ),
          Text(
            body,
            style: mainTextStyle,
          ),
        ],
      ),
    );
  }
}
