import 'package:flutter/material.dart';

class UpcomingWorkshops extends StatelessWidget {
  const UpcomingWorkshops({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _WorkshopTimelineItem(
          title: 'Flutter Animation Workshop',
          dateTime: DateTime.parse('2025-03-18 10:00:00'),
          location: 'Room 301',
          registrations: 42,
          capacity: 50,
          isNext: true,
        ),
        const SizedBox(height: 16),
        _WorkshopTimelineItem(
          title: 'State Management Deep Dive',
          dateTime: DateTime.parse('2025-03-19 14:30:00'),
          location: 'Virtual',
          registrations: 28,
          capacity: 100,
        ),
        const SizedBox(height: 16),
        _WorkshopTimelineItem(
          title: 'Testing Best Practices',
          dateTime: DateTime.parse('2025-03-20 09:00:00'),
          location: 'Room 205',
          registrations: 15,
          capacity: 30,
        ),
      ],
    );
  }
}

class _WorkshopTimelineItem extends StatelessWidget {
  final String title;
  final DateTime dateTime;
  final String location;
  final int registrations;
  final int capacity;
  final bool isNext;

  const _WorkshopTimelineItem({
    required this.title,
    required this.dateTime,
    required this.location,
    required this.registrations,
    required this.capacity,
    this.isNext = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isNext ? Theme.of(context).primaryColor : Colors.grey,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isNext 
                        ? Theme.of(context).primaryColor 
                        : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
              ),
              if (!isNext)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey.shade300,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Workshop details
          Expanded(
            child: Card(
              color: isNext ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
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
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (isNext)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'NEXT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _InfoChip(
                          icon: Icons.calendar_today,
                          label: _formatDateTime(dateTime),
                        ),
                        const SizedBox(width: 16),
                        _InfoChip(
                          icon: Icons.location_on,
                          label: location,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: registrations / capacity,
                      backgroundColor: Colors.grey.shade200,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$registrations/$capacity registered',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    
    return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year} '
           '$hour:${dateTime.minute.toString().padLeft(2, '0')} $period';
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}