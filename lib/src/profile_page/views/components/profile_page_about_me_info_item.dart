import 'package:flutter/material.dart';
import 'package:podium/src/profile_page/views/components/profile_page_icon.dart';

class ProfilePageAboutMeInfoItem extends StatelessWidget {
  const ProfilePageAboutMeInfoItem({
    super.key,
    required this.fieldName,
    required this.fieldValue,
    required this.icon,
    required this.onTap,
    required this.modalHeadline,
    required this.modalSubtext,
  });

  final String fieldName;
  final String fieldValue;
  final String modalHeadline;
  final String modalSubtext;
  final IconData icon;
  final Future<void> Function(
    BuildContext,
    String,
    String,
    String,
    String,
  ) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(
        context,
        fieldName,
        fieldValue,
        modalHeadline,
        modalSubtext,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    ProfilePageIcon(icon: icon),
                    Flexible(
                      child: Text(
                        '$fieldName: $fieldValue',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded)
            ],
          ),
        ),
      ),
    );
  }
}
