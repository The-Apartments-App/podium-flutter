import 'dart:math';

import 'package:flutter/material.dart';

class RentalIncomeModal extends StatelessWidget {
  const RentalIncomeModal({super.key});

  // A simple method to generate fake rental income data
  List<Map<String, dynamic>> _generateFakeData() {
    final data = <Map<String, dynamic>>[];
    final random = Random();
    final fakePropertyNames = [
      'Maple Grove Apartments',
      'Willowbrook Heights',
      'Pinecrest Residences',
      'Oakwood Place',
      'Cedar Ridge Estates',
      'Birchwood Apartments',
      'Aspen Meadows',
      'Sycamore Terrace',
      'Juniper Park Apartments',
      'Cypress Gardens',
    ];

    for (var i = 0; i < 10; i++) {
      final rentalIncome =
          random.nextInt(5000) + 1000; // random income between $1000 and $6000

      data.add({
        'property': fakePropertyNames[i],
        'income': rentalIncome,
      });
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    final rentalIncomeData = _generateFakeData();

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              columns: const [
                DataColumn(
                  label: Text('Property', style: TextStyle(fontSize: 20)),
                ),
                DataColumn(
                  label: Text('Income', style: TextStyle(fontSize: 20)),
                ),
              ],
              rows: rentalIncomeData.map((entry) {
                return DataRow(
                  cells: [
                    DataCell(Text(entry['property'] as String)),
                    DataCell(
                      Text(
                        '\$${entry['income'] as int}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
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
