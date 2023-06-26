import 'dart:math';

import 'package:flutter/material.dart';

class OccupancyRateModal extends StatelessWidget {
  const OccupancyRateModal({super.key});

  // A simple method to generate fake tenancy rate data
  List<Map<String, dynamic>> _generateFakeData() {
    final data = <Map<String, dynamic>>[];
    final random = Random();

    for (var i = 0; i < 10; i++) {
      final isAvailable = random.nextBool();

      data.add({
        'unitNumber': 'Apt. ${i + 10}',
        'status': isAvailable ? 'Available to Rent' : 'Occupied',
      });
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    final tenancyRateData = _generateFakeData();

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              columns: const [
                DataColumn(
                  label: Text('Unit Number', style: TextStyle(fontSize: 20)),
                ),
                DataColumn(
                  label: Text('Status', style: TextStyle(fontSize: 20)),
                ),
              ],
              rows: tenancyRateData.map((entry) {
                return DataRow(
                  cells: [
                    DataCell(Text(entry['unitNumber'] as String)),
                    DataCell(
                      Text(
                        entry['status'] as String,
                        style: TextStyle(
                          color: entry['status'] == 'Available to Rent'
                              ? Colors.green
                              : Colors.black,
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
