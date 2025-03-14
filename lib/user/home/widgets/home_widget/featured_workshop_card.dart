import 'package:flutter/material.dart';
import 'package:frontend/models/workshop_model.dart';
import 'package:frontend/user/home/widgets/home_widget/info_chip.dart';
import 'package:intl/intl.dart';

class FeaturedWorkshopCard extends StatelessWidget {
  final Workshop workshop;
  final VoidCallback? onTap;

  const FeaturedWorkshopCard({super.key, required this.workshop, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCategoryChip(theme),
              const SizedBox(height: 16),
              _buildTitle(theme),
              const SizedBox(height: 8),
              _buildDescription(theme),
              const Spacer(),
              _buildInfoRow(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        workshop.category?.toUpperCase() ?? 'FEATURED',
        style: theme.textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTitle(ThemeData theme) {
    return Text(
      workshop.title,
      style: theme.textTheme.headlineSmall?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDescription(ThemeData theme) {
    return Text(
      workshop.description ?? '',
      style: theme.textTheme.bodyLarge?.copyWith(
        color: Colors.white.withOpacity(0.8),
      ),
    );
  }

  Widget _buildInfoRow(ThemeData theme) {
    return Row(
      children: [
        InfoChip(
          icon: Icons.calendar_today,
          text: DateFormat('MMM d').format(workshop.workshopDate),
          light: true,
        ),
        const SizedBox(width: 12),
        InfoChip(
          icon: Icons.access_time,
          text: workshop.durationFormatted,
          light: true,
        ),
        const SizedBox(width: 12),
        InfoChip(
          icon: Icons.people,
          text: '${workshop.spotsLeft} spots left',
          light: true,
        ),
      ],
    );
  }
}
