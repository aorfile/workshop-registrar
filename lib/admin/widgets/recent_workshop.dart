import 'package:flutter/material.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return ListView(
      shrinkWrap: true,
      children: [
        _ActivityItem(
          icon: Icons.how_to_reg,
          color: Colors.green,
          title: 'New Registration',
          description: 'John Doe registered for Flutter Animation Workshop',
          timestamp: now.subtract(const Duration(minutes: 5)),
        ),
        const SizedBox(height: 16),
        _ActivityItem(
          icon: Icons.check_circle,
          color: Colors.blue,
          title: 'Workshop Completed',
          description: 'React Fundamentals workshop marked as completed',
          timestamp: now.subtract(const Duration(hours: 2)),
        ),
        const SizedBox(height: 16),
        _ActivityItem(
          icon: Icons.star,
          color: Colors.amber,
          title: 'New Feedback',
          description: 'Received 5-star feedback for UI/UX Workshop',
          timestamp: now.subtract(const Duration(hours: 3)),
        ),
        const SizedBox(height: 16),
        _ActivityItem(
          icon: Icons.edit_calendar,
          color: Colors.purple,
          title: 'Workshop Updated',
          description: 'Updated details for State Management workshop',
          timestamp: now.subtract(const Duration(hours: 4)),
        ),
        const SizedBox(height: 16),
        _ActivityItem(
          icon: Icons.person_add,
          color: Colors.orange,
          title: 'Waitlist Addition',
          description: 'Sarah Smith added to Testing workshop waitlist',
          timestamp: now.subtract(const Duration(hours: 5)),
        ),
      ],
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String description;
  final DateTime timestamp;

  const _ActivityItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    _formatTimeAgo(timestamp),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${timestamp.month}/${timestamp.day}/${timestamp.year}';
    }
  }
}
