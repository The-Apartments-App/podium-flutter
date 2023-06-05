import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoveInsModal extends StatelessWidget {
  const MoveInsModal({super.key});

  // A simple method to generate fake move-ins data
  List<Map<String, dynamic>> _generateFakeData() {
    final data = <Map<String, dynamic>>[];
    final random = Random();

    for (var i = 0; i < 10; i++) {
      final daysBefore = random.nextInt(60); // a random number of days up to 60
      final moveInDate = DateTime.now().subtract(Duration(days: daysBefore));

      data.add({
        'name': 'Tenant ${i + 1}',
        'moveInDate': DateFormat('yMMMd').format(moveInDate),
      });
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    final moveInsData = _generateFakeData();

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Name', style: TextStyle(fontSize: 20))),
                DataColumn(
                  label: Text('Move-in Date', style: TextStyle(fontSize: 20)),
                ),
              ],
              rows: moveInsData.map((entry) {
                return DataRow(
                  cells: [
                    DataCell(Text(entry['name'] as String)),
                    DataCell(Text(entry['moveInDate'] as String)),
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
