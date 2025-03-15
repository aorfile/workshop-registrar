import 'package:flutter/material.dart';
import 'package:frontend/models/workshop_model.dart';

class WorkshopActions extends StatelessWidget {
  final Workshop workshop;

  const WorkshopActions({
    super.key,
    required this.workshop,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.parse('2025-03-15 12:38:11');
    final isCreator = workshop.createdBy == 'aorfile';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            if (isCreator && workshop.isScheduled) ...[
              _buildActionButton(
                context,
                'Edit Workshop',
                Icons.edit_rounded,
                onTap: () {
                  // Navigate to edit workshop
                },
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 12),
              _buildActionButton(
                context,
                'Cancel Workshop',
                Icons.cancel_rounded,
                onTap: () {
                  // Show cancel confirmation dialog
                },
                color: theme.colorScheme.error,
              ),
            ] else if (!isCreator && workshop.isScheduled) ...[
              _buildActionButton(
                context,
                'Add to Calendar',
                Icons.calendar_month_rounded,
                onTap: () {
                  // Add to calendar
                },
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 12),
              _buildActionButton(
                context,
                'Share Workshop',
                Icons.share_rounded,
                onTap: () {
                  // Share workshop
                },
                color: theme.colorScheme.secondary,
              ),
            ],
            if (workshop.materialsUrl != null &&
                (isCreator || workshop.isCompleted)) ...[
              if (!isCreator) const SizedBox(width: 12),
              _buildActionButton(
                context,
                'Materials',
                Icons.folder_rounded,
                onTap: () {
                  // Open materials
                },
                color: theme.colorScheme.tertiary,
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon, {
    required VoidCallback onTap,
    required Color color,
  }) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 20),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color.withOpacity(0.5)),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}