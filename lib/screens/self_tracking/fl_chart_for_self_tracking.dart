import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vidhya_app/screens/self_tracking/self_tracking_model.dart';
import 'package:vidhya_app/widgets/custom_text.dart';

class FlChartForSelfTracking extends StatelessWidget {
  final List<SelfTrackingModel> trackingData;

  FlChartForSelfTracking({required this.trackingData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Adjust height based on your UI needs
      padding: const EdgeInsets.all(13),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(

            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 1 && value.toInt() <= trackingData.length) {
                    final date = trackingData[value.toInt() - 1].date;
                    return CText(
                      text: '${date.day}/${date.month}', // Show day and month
                      fontSize: 13,
                      color: Colors.green,
                    );
                  } else {
                    return const Text('');
                  }
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(_mapValueToEmoji(value.toInt())); // Display emoji
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.green, width: 1),
          ),
          minX: 1,
          maxX: trackingData.length.toDouble(),
          minY: 1,
          maxY: 6, // There are 6 different emojis/moods
          lineBarsData: [
            LineChartBarData(
              spots: _generateSpots(trackingData),
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

  // Method to generate FlSpot list from the trackingData
  List<FlSpot> _generateSpots(List<SelfTrackingModel> trackingData) {
    List<FlSpot> spots = [];
    for (int i = 0; i < trackingData.length; i++) {
      final item = trackingData[i];

      double x = i + 1;
      double y = _mapFeelingToValue(item.feeling); // Map feeling to numeric value
      spots.add(FlSpot(x, y));
    }
    return spots;
  }

  // Helper method to map feelings to numeric values
  double _mapFeelingToValue(String feeling) {
    switch (feeling.toLowerCase()) {
      case "happy":
        return 1.0;
      case "sad":
        return 2.0;
      case "angry":
        return 3.0;
      case "stressed":
        return 4.0;
      case "nervous":
        return 5.0;
      case "anxious":
        return 6.0;
      default:
        return 0.0; // Return 0 for any unexpected feelings
    }
  }

  // Helper method to map numeric values back to emojis for display
  String _mapValueToEmoji(int value) {
    switch (value) {
      case 1:
        return '😊'; // Happy
      case 2:
        return '😢'; // Sad
      case 3:
        return '😡'; // Angry
      case 4:
        return '😓'; // Stressed
      case 5:
        return '😬'; // Nervous
      case 6:
        return '😰'; // Anxious
      default:
        return '😶'; // Default/Neutral
    }
  }
}
