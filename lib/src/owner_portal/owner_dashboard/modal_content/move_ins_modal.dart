import 'package:flutter/material.dart';
import 'package:podium/src/owner_portal/owner_dashboard/modal_content/move_outs_modal.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MoveInsModal extends StatelessWidget {
  const MoveInsModal({super.key});

  @override
  Widget build(BuildContext context) {
    final groupedData1 = <String, double>{
      'Jan': 4,
      'Feb': 5,
      'Mar': 3,
      'Apr': 1,
      'May': 0,
    };
    final groupedData2 = <String, double>{
      'Jan': 0,
      'Feb': 1,
      'Mar': 2,
      'Apr': 4,
      'May': 7,
    };

    final chartData1 = groupedData1.entries
        .map((entry) => ChartData(entry.key, entry.value))
        .toList();
    final chartData2 = groupedData2.entries
        .map((entry) => ChartData(entry.key, entry.value))
        .toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 800, maxWidth: 800),
            child: Center(
              child: SfCartesianChart(
                legend: Legend(isVisible: true),
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(interval: 1),
                series: <ChartSeries<ChartData, String>>[
                  LineSeries<ChartData, String>(
                    dataSource: chartData1,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,

                    // Legend item text
                    legendItemText: 'Move-outs',

                    // Color of the line
                    color: Colors.redAccent,

                    // Width of the line
                    width: 2,

                    // Setting the style for data labels
                    // dataLabelSettings: const DataLabelSettings(
                    //   isVisible: true,
                    //   color: Colors.black,
                    //   labelAlignment: ChartDataLabelAlignment.top,
                    //   labelPosition: ChartDataLabelPosition.outside,
                    // ),

                    // Setting the style for marker
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 10,
                      width: 10,
                      shape: DataMarkerType.circle,
                      color: Colors.redAccent,
                    ),

                    // Enable Tooltip
                    enableTooltip: true,
                  ),
                  LineSeries<ChartData, String>(
                    dataSource: chartData2,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,

                    // Legend item text
                    legendItemText: 'Move-ins',

                    // Color of the line
                    color: Colors.greenAccent,

                    // Width of the line
                    width: 2,

                    // Setting the style for data labels
                    // dataLabelSettings: const DataLabelSettings(
                    //   isVisible: true,
                    //   color: Colors.black,
                    //   labelAlignment: ChartDataLabelAlignment.top,
                    //   labelPosition: ChartDataLabelPosition.outside,
                    // ),

                    // Setting the style for marker
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 10,
                      width: 10,
                      shape: DataMarkerType.circle,
                      color: Colors.greenAccent,
                    ),

                    // Enable Tooltip
                    enableTooltip: true,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
