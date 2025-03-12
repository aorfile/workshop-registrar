import 'package:flutter/material.dart';
import 'package:frontend/user/home/model/workshop.dart';


class WorkshopCard extends StatelessWidget {
  final Workshop workshop;
  final VoidCallback? onRegister;
  static const String currentDateTime = '2025-03-12 15:30:16';
  static const String currentUser = 'aorfile';

  const WorkshopCard({
    Key? key,
    required this.workshop,
    this.onRegister,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      child: InkWell(
        onTap: () {
          // Navigate to workshop details
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Workshop Header with Category and Seats
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  // Category Tag
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      workshop.category,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Seats Counter
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: workshop.remainingSeats > 0
                          ? theme.colorScheme.secondary.withOpacity(0.1)
                          : theme.colorScheme.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 16,
                          color: workshop.remainingSeats > 0
                              ? theme.colorScheme.secondary
                              : theme.colorScheme.error,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${workshop.remainingSeats} seats left',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: workshop.remainingSeats > 0
                                ? theme.colorScheme.secondary
                                : theme.colorScheme.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Workshop Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    workshop.title,
                    style: theme.textTheme.titleLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    workshop.description,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  // Workshop Details
                  Row(
                    children: [
                      _buildDetailItem(
                        context,
                        Icons.calendar_today,
                        workshop.date,
                      ),
                      const SizedBox(width: 16),
                      _buildDetailItem(
                        context,
                        Icons.access_time,
                        workshop.time,
                      ),
                      const SizedBox(width: 16),
                      _buildDetailItem(
                        context,
                        Icons.location_on,
                        workshop.location,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Topics
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: workshop.topics.map((topic) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          topic,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  // Instructor and Registration
                  Row(
                    children: [
                      // Instructor Info
                      Expanded(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                              child: Text(
                                workshop.instructor[0].toUpperCase(),
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    workshop.instructor,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Instructor',
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Register Button
                      if (!workshop.isRegistered)
                        ElevatedButton(
                          onPressed: workshop.remainingSeats > 0 ? onRegister : null,
                          child: Text(
                            workshop.remainingSeats > 0 ? 'Register' : 'Full',
                          ),
                        )
                      else
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.check_circle),
                          label: const Text('Registered'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}