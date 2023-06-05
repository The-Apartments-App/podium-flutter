import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TasksInProgressModal extends StatelessWidget {
  const TasksInProgressModal({super.key});

  // A simple method to generate fake tasks in progress data
  List<Map<String, dynamic>> _generateFakeData() {
    final data = <Map<String, dynamic>>[];
    final random = Random();

    for (var i = 0; i < 10; i++) {
      final daysBefore = random.nextInt(30); // a random number of days up to 30
      final dueDate = DateTime.now().add(Duration(days: daysBefore));

      data.add({
        'taskName': 'Task ${i + 1}',
        'dueDate': DateFormat('yMMMd').format(dueDate),
      });
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    final tasksData = _generateFakeData();

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              columns: const [
                DataColumn(
                  label: Text('Task Name', style: TextStyle(fontSize: 20)),
                ),
                DataColumn(
                  label: Text('Due Date', style: TextStyle(fontSize: 20)),
                ),
              ],
              rows: tasksData.map((entry) {
                return DataRow(
                  cells: [
                    DataCell(Text(entry['taskName'] as String)),
                    DataCell(Text(entry['dueDate'] as String)),
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
