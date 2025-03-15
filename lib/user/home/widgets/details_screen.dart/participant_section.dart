import 'package:flutter/material.dart';
import 'package:frontend/models/workshop_model.dart';

class ParticipantSection extends StatelessWidget {
  final Workshop workshop;

  const ParticipantSection({
    super.key,
    required this.workshop,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = workshop.currentRegistrations / workshop.capacity;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Participants',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${workshop.currentRegistrations}/${workshop.capacity}',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(
              progress > 0.9
                  ? theme.colorScheme.error
                  : progress > 0.7
                      ? theme.colorScheme.error.withOpacity(0.7)
                      : theme.colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              workshop.spotsLeft > 0
                  ? '${workshop.spotsLeft} spots remaining'
                  : 'Workshop is full',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: workshop.spotsLeft > 0
                    ? theme.colorScheme.onSurface.withOpacity(0.6)
                    : theme.colorScheme.error,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (workshop.minParticipants! > 1)
              Text(
                'Min. ${workshop.minParticipants} required',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: workshop.currentRegistrations >= workshop.minParticipants!
                      ? theme.colorScheme.primary
                      : theme.colorScheme.error,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ],
    );
  }
}