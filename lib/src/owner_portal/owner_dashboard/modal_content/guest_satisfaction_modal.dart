import 'dart:math';

import 'package:flutter/material.dart';

class GuestSatisfactionModal extends StatelessWidget {
  const GuestSatisfactionModal({super.key});

  // A simple method to generate fake guest satisfaction data
  List<Map<String, dynamic>> _generateFakeData() {
    final data = <Map<String, dynamic>>[];
    final random = Random();

    for (var i = 0; i < 10; i++) {
      final satisfactionRating =
          random.nextInt(5) + 1; // random rating between 1 and 5

      data.add({
        'guestName': 'Guest ${i + 1}',
        'satisfactionRating': satisfactionRating,
      });
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    final guestSatisfactionData = _generateFakeData();

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              columns: const [
                DataColumn(
                  label: Text('Guest Name', style: TextStyle(fontSize: 20)),
                ),
                DataColumn(
                  label: Text('Rating', style: TextStyle(fontSize: 20)),
                ),
              ],
              rows: guestSatisfactionData.map((entry) {
                return DataRow(
                  cells: [
                    DataCell(Text(entry['guestName'] as String)),
                    DataCell(
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            color: index < (entry['satisfactionRating'] as num)
                                ? Colors.amber
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
