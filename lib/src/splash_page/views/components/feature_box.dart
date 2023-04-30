import 'package:flutter/material.dart';

class FeatureBox extends StatefulWidget {
  const FeatureBox({
    super.key,
    required this.icon,
    required this.headline,
    required this.details,
  });

  final Icon icon;
  final String headline;
  final String details;

  @override
  State<FeatureBox> createState() => _FeatureBoxState();
}

class _FeatureBoxState extends State<FeatureBox> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 300),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
              child: SizedBox(
                height: 18,
                width: 18,
                child: widget.icon,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
              child: Text(
                widget.headline,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
                softWrap: true,
              ),
            ),
            Text(
              widget.details,
              style: const TextStyle(
                fontSize: 16,
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
