import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vidhya_app/widgets/custom_text.dart';

class LineChartSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Adjust height based on your UI needs
      padding: EdgeInsets.all(13),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 1:
                      return CText(
                        text: 'Jan',
                        fontSize: 13,
                        color: Colors.green,
                      );
                    case 2:
                      return CText(
                        text: 'Feb',
                        fontSize: 13,
                        color: Colors.green,
                      );
                    case 3:
                      return CText(
                        text: 'Mar',
                        fontSize: 13,
                        color: Colors.green,
                      );
                    case 4:
                      return CText(
                        text: 'Apr',
                        fontSize: 13,
                        color: Colors.green,
                      );
                    case 5:
                      return CText(
                        text: 'May',
                        fontSize: 13,
                        color: Colors.green,
                      );
                    case 6:
                      return CText(
                        text: 'Jun',
                        fontSize: 13,
                        color: Colors.green,
                      );
                    default:
                      return Text('');
                  }
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(value.toInt().toString());
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.green, width: 1),
          ),
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 6,
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(1, 1),
                FlSpot(2, 1.5),
                FlSpot(3, 1.4),
                FlSpot(4, 3.4),
                FlSpot(5, 2),
                FlSpot(6, 2.2),
              ],
              isCurved: true,
              color: Colors.blue,
              barWidth: 4,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
