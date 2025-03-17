import 'package:flutter/material.dart';
import 'package:frontend/admin/widgets/registration_table.dart';
import 'package:frontend/utils/responsive_helper.dart';


class RegistrationList extends StatelessWidget {
  const RegistrationList({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, deviceType) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context, deviceType),
                if (deviceType == DeviceType.mobile)
                  _buildMobileList(context)
                else
                  const Expanded(
                    child: RegistrationTable(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, DeviceType deviceType) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Workshop Registrations',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    if (deviceType != DeviceType.mobile) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Manage your workshop participants',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (deviceType != DeviceType.mobile)
                _buildActions(context),
            ],
          ),
          if (deviceType == DeviceType.mobile) ...[
            const SizedBox(height: 16),
            _buildActions(context),
          ],
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.filter_list),
          label: const Text('Filter'),
        ),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.download),
          label: const Text('Export'),
        ),
      ],
    );
  }

  Widget _buildMobileList(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('Student ${index + 1}'),
              subtitle: Text(
                'Workshop: Flutter Basics\nRegistered: ${DateTime.parse('2025-03-17 14:40:22').subtract(Duration(days: index)).toString().substring(0, 10)}',
              ),
              trailing: _buildStatusChip(_getStatus(index)),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: 20,
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    final colors = {
      'registered': Colors.blue,
      'attended': Colors.green,
      'no-show': Colors.red,
      'cancelled': Colors.grey,
    };

    return Chip(
      label: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      backgroundColor: colors[status],
      visualDensity: VisualDensity.compact,
    );
  }

  String _getStatus(int index) {
    final statuses = ['registered', 'attended', 'no-show', 'cancelled'];
    return statuses[index % statuses.length];
  }
}