import 'package:flutter/material.dart';
import 'package:podium/src/owner_portal/owner_dashboard/modal_content/modal_content_subcomponents/guest_reviews_building_rating_category.dart';

class GuestReviewBuildingRatings extends StatelessWidget {
  const GuestReviewBuildingRatings({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.star_rounded,
                size: 34,
              ),
              const Text(
                '4.89',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 34,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Container(
                  width: 6, // Adjust the size of the dot as needed
                  height: 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        Colors.black, // Adjust the color of the dot as needed
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 4),
                child: Text(
                  '7',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 34,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              const Text(
                'reviews',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const GuestReviewsBuildingRatingCategory(
            reviewName: 'Cleanliness',
            reviewRating: 1,
          ),
          const GuestReviewsBuildingRatingCategory(
            reviewName: 'Accuracy',
            reviewRating: 0.9,
          ),
          const GuestReviewsBuildingRatingCategory(
            reviewName: 'Communication',
            reviewRating: 1,
          ),
          const GuestReviewsBuildingRatingCategory(
            reviewName: 'Location',
            reviewRating: 0.9,
          ),
          const GuestReviewsBuildingRatingCategory(
            reviewName: 'Check-in',
            reviewRating: 0.9,
          ),
          const GuestReviewsBuildingRatingCategory(
            reviewName: 'Value',
            reviewRating: 1,
          ),
        ],
      ),
    );
  }
}
