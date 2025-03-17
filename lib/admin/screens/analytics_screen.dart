import 'package:flutter/material.dart';
import 'package:frontend/admin/widgets/analytics_chart.dart';
import 'package:frontend/admin/widgets/stat_card.dart';


class AnalyticsView extends StatelessWidget {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Workshop Analytics',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),
          const _MetricsGrid(),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Registration Trends',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        const AnalyticsChart(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricsGrid extends StatelessWidget {
  const _MetricsGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children:  [
        StatCard(
          title: 'Total Attendees',
          value: '1,245',
          trend: '+89',
          trendUp: true,
          icon: Icons.people,
        ),
        StatCard(
          title: 'Avg. Workshop Size',
          value: '52',
          trend: '+3',
          trendUp: true,
          icon: Icons.groups,
        ),
        StatCard(
          title: 'Waitlist Rate',
          value: '15%',
          trend: '-2%',
          trendUp: true,
          icon: Icons.pending,
        ),
        StatCard(
          title: 'Feedback Score',
          value: '4.6',
          trend: '+0.2',
          trendUp: true,
          icon: Icons.thumb_up,
        ),
      ],
    );
  }
}