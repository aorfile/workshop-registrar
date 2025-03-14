import 'package:flutter/material.dart';
import 'package:frontend/models/workshop_model.dart';
import 'package:frontend/user/home/widgets/home_widget/info_chip.dart';
import 'package:intl/intl.dart';

class WorkshopCard extends StatelessWidget {
  final Workshop workshop;
  final VoidCallback? onTap;
  final VoidCallback? onRegister;

  const WorkshopCard({
    super.key,
    required this.workshop,
    this.onTap,
    this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOnline = workshop.locationType == 'virtual';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(theme, isOnline),
              const SizedBox(height: 16),
              _buildInfoRow(theme),
              const SizedBox(height: 16),
              _buildFooter(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, bool isOnline) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                workshop.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (workshop.description != null) ...[
                const SizedBox(height: 4),
                Text(
                  workshop.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            isOnline ? 'ONLINE' : 'IN-PERSON',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(ThemeData theme) {
    return Row(
      children: [
        InfoChip(
          icon: Icons.calendar_today,
          text: DateFormat('MMM d, y').format(workshop.workshopDate),
        ),
        const SizedBox(width: 16),
        InfoChip(
          icon: Icons.access_time,
          text: DateFormat('HH:mm').format(workshop.workshopDate),
        ),
        const SizedBox(width: 16),
        InfoChip(icon: Icons.location_on, text: workshop.location),
      ],
    );
  }

  Widget _buildFooter(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${workshop.spotsLeft} spots left',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        FilledButton(
          onPressed: workshop.spotsLeft > 0 ? onRegister : null,
          child: const Text('Register'),
        ),
      ],
    );
  }
}
