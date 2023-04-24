import 'package:flutter/material.dart';

class DetailsInput extends StatefulWidget {
  const DetailsInput({super.key});

  @override
  State<DetailsInput> createState() => _DetailsInputState();
}

class _DetailsInputState extends State<DetailsInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Details',
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 20),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: const TextField(
              minLines: 4,
              maxLines: 7,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                border: InputBorder.none,
                hintText: 'Provide details of service needed.',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
