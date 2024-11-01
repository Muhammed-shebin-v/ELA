import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MoodGraph extends StatelessWidget {
  final Map<DateTime, String> moodData;

  MoodGraph({required this.moodData});

  List<FlSpot> getMoodSpots() {
    return moodData.entries.map((entry) {
      double x = entry.key.day.toDouble(); // X-axis: day of the month
      double y = _moodMapping(entry.value); // Y-axis: corresponding numerical value for mood
      return FlSpot(x, y);
    }).toList();
  }

  double _moodMapping(String mood) {
    switch (mood.toLowerCase()) {
      case 'happy':
        return 1.0;
      case 'sad':
        return 0.0;
      // Add more moods as needed
      default:
        return 0.5; // Neutral mood
    }
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: getMoodSpots(),
            isCurved: true,
            color: Colors.blue,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
