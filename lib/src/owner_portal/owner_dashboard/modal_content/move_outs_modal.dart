import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoveOutsModal extends StatelessWidget {
  const MoveOutsModal({super.key});

  // A simple method to generate fake move-outs data
  List<Map<String, dynamic>> _generateFakeData() {
    final data = <Map<String, dynamic>>[];
    final random = Random();

    for (var i = 0; i < 10; i++) {
      final daysAhead = random.nextInt(30); // a random number of days up to 30
      final moveOutDate = DateTime.now().add(Duration(days: daysAhead));

      data.add({
        'name': 'Tenant ${i + 1}',
        'moveOutDate': DateFormat('yMMMd').format(moveOutDate),
      });
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    final moveOutsData = _generateFakeData();

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
                  label: Text('Move-out Date', style: TextStyle(fontSize: 20)),
                ),
              ],
              rows: moveOutsData.map((entry) {
                return DataRow(
                  cells: [
                    DataCell(Text(entry['name'] as String)),
                    DataCell(Text(entry['moveOutDate'] as String)),
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
