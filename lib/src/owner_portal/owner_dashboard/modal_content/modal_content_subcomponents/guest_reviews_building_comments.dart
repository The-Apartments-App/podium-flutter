import 'package:flutter/material.dart';
import 'package:podium/src/owner_portal/owner_dashboard/modal_content/modal_content_subcomponents/guest_reviews_building_comment.dart';

class GuestReviewBuildingComments extends StatelessWidget {
  const GuestReviewBuildingComments({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GuestReviewsBuildingComment(
            username: 'Name',
            commentDate: DateTime.now(),
            commentText:
                '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.''',
          ),
          GuestReviewsBuildingComment(
            username: 'Name',
            commentDate: DateTime.now(),
            commentText:
                '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.''',
          ),
          GuestReviewsBuildingComment(
            username: 'Name',
            commentDate: DateTime.now(),
            commentText:
                '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.''',
          ),
          GuestReviewsBuildingComment(
            username: 'Name',
            commentDate: DateTime.now(),
            commentText:
                '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.''',
          ),
          GuestReviewsBuildingComment(
            username: 'Name',
            commentDate: DateTime.now(),
            commentText:
                '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.''',
          ),
        ],
      ),
    );
  }
}
