import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkshopCard extends StatelessWidget {
  final String title;
  final DateTime date;
  final String location;
  final int registrations;
  final int capacity;
  final String status;
  final bool isListView;

  const WorkshopCard({
    super.key,
    required this.title,
    required this.date,
    required this.location,
    required this.registrations,
    required this.capacity,
    required this.status,
    this.isListView = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isListView) {
      return _buildListItem(context);
    }
    return _buildGridItem(context);
  }

  Widget _buildGridItem(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          // Navigate to workshop details
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildStatusChip(status),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                DateFormat('MMM d, yyyy - h:mm a').format(date),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoChip(Icons.people, '$registrations/$capacity'),
                  _buildInfoChip(
                    Icons.pending, 
                    '${capacity - registrations}',
                  ),
                  _buildInfoChip(Icons.location_on, location),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          // Navigate to workshop details
        },
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            _buildStatusChip(status),
          ],
        ),
        subtitle: Text(
          DateFormat('MMM d, yyyy - h:mm a').format(date),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildInfoChip(Icons.people, '$registrations/$capacity'),
            const SizedBox(width: 8),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                _buildMenuItem('Edit', Icons.edit),
                _buildMenuItem('Duplicate', Icons.copy),
                _buildMenuItem('Archive', Icons.archive),
                const PopupMenuDivider(),
                _buildMenuItem(
                  'Delete',
                  Icons.delete,
                  isDestructive: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildMenuItem(
    String label,
    IconData icon, {
    bool isDestructive = false,
  }) {
    return PopupMenuItem<String>(
      value: label.toLowerCase(),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isDestructive ? Colors.red : null,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isDestructive ? Colors.red : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    final colors = {
      'scheduled': Colors.blue,
      'in-progress': Colors.green,
      'completed': Colors.grey,
      'cancelled': Colors.red,
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
      padding: const EdgeInsets.symmetric(horizontal: 8),
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}