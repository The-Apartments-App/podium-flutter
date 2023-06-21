import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class MaintenanceModal extends StatelessWidget {
  const MaintenanceModal({super.key});

  @override
  Widget build(BuildContext context) {
    final chartData = [
      TaskChartData('Fixing a lightbulb', 5, 7),
      TaskChartData('Repairing the elevator', 7, 14),
      // Add more data
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 800, maxWidth: 800),
            child: SfCartesianChart(
              legend: Legend(isVisible: true),
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(interval: 1),
              series: [
                RangeColumnSeries<TaskChartData, String>(
                  name: 'Maintenance and Repairs',
                  dataSource: chartData,
                  xValueMapper: (TaskChartData data, _) => data.task,
                  lowValueMapper: (TaskChartData data, _) => data.low,
                  highValueMapper: (TaskChartData data, _) => data.high,
                  pointColorMapper: (TaskChartData data, _) =>
                      data.high > 10 ? Colors.red : Colors.green,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TaskChartData {
  TaskChartData(this.task, this.low, this.high);

  final String task;
  final double low;
  final double high;
}
