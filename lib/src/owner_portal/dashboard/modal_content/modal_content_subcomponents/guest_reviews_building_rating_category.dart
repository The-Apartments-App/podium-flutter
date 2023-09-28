import 'package:flutter/material.dart';

class GuestReviewsBuildingRatingCategory extends StatelessWidget {
  const GuestReviewsBuildingRatingCategory({
    super.key,
    required this.reviewName,
    required this.reviewRating,
  });

  final String reviewName;
  final double reviewRating;

  @override
  Widget build(BuildContext context) {
    final rating = 5 - (1 - reviewRating);

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 150),
            child: Text(
              reviewName,
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 100),
            child: LinearProgressIndicator(
              minHeight: 4,
              value: reviewRating,
              backgroundColor: Colors.grey.shade400,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.black,
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 50),
            child: Text(
              rating == 5 ? '5.0' : '$rating',
              style: const TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
