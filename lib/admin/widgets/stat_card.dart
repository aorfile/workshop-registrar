import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String trend;
  final bool trendUp;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.trend,
    required this.trendUp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 160, // Fixed height to avoid unbounded constraints
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Important: Use min size
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  trendUp ? Icons.trending_up : Icons.trending_down,
                  color: trendUp ? Colors.green : Colors.red,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  trend,
                  style: TextStyle(
                    color: trendUp ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}