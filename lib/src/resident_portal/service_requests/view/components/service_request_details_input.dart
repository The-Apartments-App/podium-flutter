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
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 20),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade300),
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
