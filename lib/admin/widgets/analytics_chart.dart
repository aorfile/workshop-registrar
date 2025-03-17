import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsChart extends StatelessWidget {
  const AnalyticsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    'Week ${value.toInt()}',
                    style: const TextStyle(fontSize: 12),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 12),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                8,
                (index) => FlSpot(
                  index.toDouble(),
                  (index * 2 + 5).toDouble(),
                ),
              ),
              isCurved: true,
              color: Theme.of(context).primaryColor,
              barWidth: 3,
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}