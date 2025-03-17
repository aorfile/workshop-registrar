import 'package:flutter/material.dart';
import 'package:frontend/admin/widgets/recent_workshop.dart';
import 'package:frontend/admin/widgets/responsive_grid.dart';
import 'package:frontend/admin/widgets/stat_card.dart';
import 'package:frontend/admin/widgets/upcoming_workshop.dart';
import 'package:frontend/utils/responsive_helper.dart';

class DashboardOverview extends StatelessWidget {
  const DashboardOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, deviceType) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back, aorfile',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Here whats happening with your workshops',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              _buildStatisticsGrid(deviceType),
              const SizedBox(height: 24),
              _buildMainContent(deviceType),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatisticsGrid(DeviceType deviceType) {
    final statistics = [
      StatData(
        title: 'Total Workshops',
        value: '24',
        trend: '+3',
        trendUp: true,
        icon: Icons.event,
      ),
      StatData(
        title: 'Active Registrations',
        value: '156',
        trend: '+12',
        trendUp: true,
        icon: Icons.how_to_reg,
      ),
      StatData(
        title: 'Completion Rate',
        value: '94%',
        trend: '+2.5%',
        trendUp: true,
        icon: Icons.verified,
      ),
      StatData(
        title: 'Avg. Satisfaction',
        value: '4.8',
        trend: '-0.1',
        trendUp: false,
        icon: Icons.star,
      ),
    ];

    return ResponsiveGrid(
      spacing: 16,
      runSpacing: 16,
      minChildWidth: deviceType == DeviceType.mobile ? 160 : 240,
      children: statistics.map((stat) => StatCard(
        title: stat.title,
        value: stat.value,
        trend: stat.trend,
        trendUp: stat.trendUp,
        icon: stat.icon,
      )).toList(),
    );
  }

  Widget _buildMainContent(DeviceType deviceType) {
    if (deviceType == DeviceType.mobile) {
      return Column(
        children: const [
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: UpcomingWorkshops(),
            ),
          ),
          SizedBox(height: 16),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: RecentActivity(),
            ),
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upcoming Workshops',
                    style: TextStyle(
                      fontSize: deviceType == DeviceType.desktop ? 24 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const UpcomingWorkshops(),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Activity',
                    style: TextStyle(
                      fontSize: deviceType == DeviceType.desktop ? 24 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const RecentActivity(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StatData {
  final String title;
  final String value;
  final String trend;
  final bool trendUp;
  final IconData icon;

  const StatData({
    required this.title,
    required this.value,
    required this.trend,
    required this.trendUp,
    required this.icon,
  });
}