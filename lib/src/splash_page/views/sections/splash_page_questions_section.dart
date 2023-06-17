import 'package:flutter/material.dart';
import 'package:podium/src/shared/variables/shared_variables.dart';
import 'package:podium/src/splash_page/views/components/splash_page_faq.dart';

class SplashPageQuestionsSection extends StatelessWidget {
  const SplashPageQuestionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(isMobile(context) ? 24 : 48),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.center,
        spacing: 200,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 125),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Text(
                'Common Questions, Clear Answers',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile(context) ? 30 : 36,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 400,
              maxWidth: 500,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Column(
                children: [
                  FAQ(
                    question:
                        '''What makes Podium different from other apartment rental platforms?''',
                    answer:
                        '''Podium offers a comprehensive platform that integrates every aspect of property management, unlike traditional management companies that rely on third-party payment and listing services.''',
                  ),
                  FAQ(
                    question:
                        '''How does Podium ensure a consistent and high-quality living experience for its residents?''',
                    answer:
                        '''Distinguishing itself from other digital rental platforms, Podium directly manages the buildings, ensuring on-site managers are available to provide support and assistance.''',
                  ),
                  FAQ(
                    question:
                        '''Can I list my property on Podium? What are the requirements for property owners to join the platform?''',
                    answer:
                        '''Our platform is currently not open to general property submissions as we focus on partnering with premium-level properties. If you're interested in discussing a potential partnership, please contact us at info@podiumapartments.com for more information.''',
                  ),
                  FAQ(
                    question:
                        '''How does Podium's platform help property owners manage their apartments more effectively?''',
                    answer:
                        '''Utilizing cutting-edge technology, Podium delivers an advanced and efficient property management experience for both tenants and property owners.''',
                  ),
                  FAQ(
                    question:
                        '''Are there any additional benefits or amenities for residents living in Podium-managed properties?''',
                    answer:
                        '''At Podium, our managed properties feature exclusive amenities such as complimentary cold brew and thoughtfully designed community spaces, guaranteeing a consistently high-quality living experience that fosters comfort and engagement for our residents.''',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
