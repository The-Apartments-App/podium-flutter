import 'package:flutter/material.dart';
import 'package:podium/src/blog_story_page/views/components/blog_story_image.dart';
import 'package:podium/src/shared/components/podium_footer.dart';
import 'package:podium/src/shared/shared_index.dart';
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
                  const Row(
                    children: [PodiumLogoWithTitle(height: 150)],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      '''The Future of Urban Living: How Podium Buildings are Reviving the Spirit of 'Main Street' ''',
                      style: isMobile(context)
                          ? mobileTitleTextStyle
                          : desktopTitleTextStyle,
                    ),
                  ),
                  Wrap(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                          right: 24,
                          left: isMobile(context) ? 4 : 0,
                        ),
                        child: const BlogAuthor(),
                      ),
                      const SocialMediaBar(),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const BlogStoryImage(blogImageName: 'blog_story1_image1'),
                  const SizedBox(height: 32),
                  Text(
                    '''
A cursory glance at the name 'Podium' might prompt questions about its connection with apartments. Yet, envisioning a thriving cityscape soon elucidates this relationship. Imagine towering buildings, their ground floors alive with retail activity, the stories above populated by residential apartments. This coexistence of commerce and residence, vital to the pulse of a city, is reflected in the very DNA of America's urbanization, coined famously as 'Main Street'.''',
                    style: mainTextStyle,
                    softWrap: true,
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      '''The Birth and Lifeblood of Main Street''',
                      style: isMobile(context)
                          ? mobileTitleTextStyle
                          : desktopTitleTextStyle,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const BlogStoryImage(blogImageName: 'blog_story1_image2'),
                  const SizedBox(height: 32),
                  Text(
                    '''
This ‘Main Street’ spirit, woven into every town across America, symbolized much more than geographical locations—it represented an ethos. It was the cradle where small businesses thrived, families grew, and the local community vibrated with life and activity.''',
                    style: mainTextStyle,
                    softWrap: true,
                  ),
                  const SizedBox(height: 32),
                  const BlogSection(
                    headline: 'The Downfall of Main Street',
                    body:
                        '''However, the decay of Main Street was a cascade effect triggered by the deterioration of residential units above the retail spaces. The diminishing population density led to decreased foot traffic, resulting in the gradual closure of small businesses.''',
                  ),
                  const SizedBox(height: 32),
                  const BlogStoryImage(blogImageName: 'blog_story1_image4'),
                  const SizedBox(height: 32),
                  const BlogSection(
                    headline: 'The Resilience of the Main Street Concept',
                    body:
                        '''The concept of combining residential living with retail accessibility, despite this decline, remains vibrant in urban landscapes. The future of Main Street lies in the revival of these mixed-use communities, and the key to this revival is an architectural innovation known as 'Podium' buildings.''',
                  ),
                  // const SizedBox(height: 32),
                  // const BlogStoryImage(blogImageName: 'blog_story1_image3'),
                  // const SizedBox(height: 32),
                  const BlogSection(
                    headline: 'The Rise of Podium Buildings',
                    body:
                        '''Typically featuring a retail concourse under five residential stories, these 'Podium' buildings have become a common sight in major American cities over the past decade. They evoke the spirit of a bygone era, recreating the buzz of community and commerce reminiscent of Main Street's heyday.''',
                  ),
                  const SizedBox(height: 32),
                  const BlogStoryImage(blogImageName: 'blog_story1_image5'),
                  const SizedBox(height: 32),
                  const BlogSection(
                    headline: 'Podium Buildings: Reviving Main Street',
                    body:
                        '''These modern edifices have begun to mirror the Main Street ethos, fostering an environment that cultivates a symbiotic relationship between residence and commerce. With the convenience of retail outlets nestled right below their homes, residents are participating in a vibrant community life—reminiscent of the early days of Main Street.''',
                  ),
                  const SizedBox(height: 32),
                  const BlogStoryImage(blogImageName: 'blog_story1_image6'),
                  const SizedBox(height: 32),
                  const BlogSection(
                    headline: 'Looking Ahead',
                    body: '''
The future lies in leveraging these lessons from Main Street to shape the future of urban living. We believe in more than just the construction of physical structures; we are keen on curating spaces that foster community, just as Main Street once did. This endeavor extends beyond traditional property management and aims to revive the Main Street ethos, one Podium building at a time.''',
                  ),
                  const SizedBox(height: 32),
                  const BlogStoryImage(blogImageName: 'blog_story1_image7'),
                  const SizedBox(height: 32),
                  const SizedBox(height: 32),
                  Text(
                    '''
By curating environments that encourage interaction and shared experiences, we're dedicated to recreating that sense of belonging and unity that once was the essence of Main Street. We see ourselves as architects of community, combining the traditions of Main Street with the promise of the Podium model.

Our vision reflects a future pulsating with the vibrant rhythm of community and commerce—a future echoing the bustling energy of Main Street while looking forward to the dynamic potential of Podium communities. We believe that by respecting the past and embracing the future, we can spark a renaissance of the Main Street spirit, creating thriving, sustainable urban communities that resonate with the vitality and warmth of the cities we love.''',
                    style: mainTextStyle,
                    softWrap: true,
                  ),
                  const SizedBox(height: 32),
                  const Divider(),
                  if (MediaQuery.of(context).size.width > 340)
                    const PodiumFooter(),
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
          const Text('June 14th, 2023')
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
