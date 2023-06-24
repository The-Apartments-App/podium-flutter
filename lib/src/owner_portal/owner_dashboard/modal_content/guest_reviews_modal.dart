import 'package:flutter/material.dart';
import 'package:podium/src/owner_portal/owner_dashboard/modal_content/modal_content_subcomponents/guest_reviews_building_comments.dart';
import 'package:podium/src/owner_portal/owner_dashboard/modal_content/modal_content_subcomponents/guest_reviews_building_ratings.dart';

class GuestReviewsModal extends StatelessWidget {
  const GuestReviewsModal({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: const Row(
              children: [
                GuestReviewBuildingRatings(),
                GuestReviewBuildingComments(),
              ],
            ),
          ),
        );
      },
    );
  }
}
