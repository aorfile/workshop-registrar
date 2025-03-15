import 'package:flutter/material.dart';
import 'package:frontend/models/workshop_model.dart';
import 'package:intl/intl.dart';

class WorkshopInfoSection extends StatelessWidget {
  final Workshop workshop;

  const WorkshopInfoSection({
    super.key,
    required this.workshop,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (workshop.description != null) ...[
          Text(
            'About',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            workshop.description!,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 24),
        ],
        Text(
          'Details',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildDetailItem(
          context,
          Icons.event_rounded,
          'Date',
          DateFormat('EEEE, MMMM d, y').format(workshop.workshopDate),
        ),
        const SizedBox(height: 12),
        _buildDetailItem(
          context,
          Icons.access_time_rounded,
          'Time',
          '${DateFormat('HH:mm').format(workshop.workshopDate)} - ${DateFormat('HH:mm').format(workshop.endTime)}',
        ),
        const SizedBox(height: 12),
        _buildDetailItem(
          context,
          Icons.timelapse_rounded,
          'Duration',
          workshop.durationFormatted,
        ),
        const SizedBox(height: 12),
        _buildDetailItem(
          context,
          workshop.isVirtual ? Icons.videocam_rounded : Icons.location_on_rounded,
          'Location',
          workshop.location,
        ),
        if (workshop.meetingLink != null) ...[
          const SizedBox(height: 12),
          _buildDetailItem(
            context,
            Icons.link_rounded,
            'Meeting Link',
            workshop.meetingLink!,
            isLink: true,
          ),
        ],
        if (workshop.prerequisites != null) ...[
          const SizedBox(height: 12),
          _buildDetailItem(
            context,
            Icons.list_alt_rounded,
            'Prerequisites',
            workshop.prerequisites!,
          ),
        ],
      ],
    );
  }

  Widget _buildDetailItem(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    bool isLink = false,
  }) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withOpacity(0.7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 2),
              isLink
                  ? GestureDetector(
                      onTap: () {
                        // Handle link tap
                      },
                      child: Text(
                        value,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  : Text(
                      value,
                      style: theme.textTheme.bodyMedium,
                    ),
            ],
          ),
        ),
      ],
    );
  }
}