import 'package:flutter/material.dart';

class FeatureBox extends StatefulWidget {
  const FeatureBox({
    super.key,
    required this.icon,
    required this.headline,
    required this.details,
  });

  final IconData icon;
  final String headline;
  final String details;

  @override
  State<FeatureBox> createState() => _FeatureBoxState();
}

class _FeatureBoxState extends State<FeatureBox> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 350),
      child: SizedBox(
        width: MediaQuery.of(context).size.width < 850
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * .25,
        child: Column(
          crossAxisAlignment: MediaQuery.of(context).size.width < 850
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
              child: Icon(widget.icon, size: 36),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
              child: Text(
                widget.headline,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                softWrap: true,
              ),
            ),
            Text(
              widget.details,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.1,
              ),
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
