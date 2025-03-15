import 'package:flutter/material.dart';
import 'package:frontend/models/workshop_model.dart';
import 'package:frontend/user/home/widgets/home_widget/info_chip.dart';
import 'package:intl/intl.dart';

class FeaturedWorkshopCard extends StatelessWidget {
  final Workshop workshop;
  final VoidCallback? onTap;

  const FeaturedWorkshopCard({
    super.key,
    required this.workshop,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          image: DecorationImage(
            image: AssetImage(workshop.backgroundImage),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.8),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTypeChip(theme),
                const Spacer(),
                _buildCategory(theme),
                const SizedBox(height: 12),
                _buildTitle(theme),
                const SizedBox(height: 8),
                _buildDescription(theme),
                const SizedBox(height: 16),
                _buildInfoRow(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeChip(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            workshop.isVirtual ? Icons.video_camera_front : Icons.location_on,
            size: 16,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 4),
          Text(
            workshop.isVirtual ? 'Virtual' : 'In-Person',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        workshop.category.toUpperCase(),
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
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
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
        if (workshop.isScheduled && workshop.spotsLeft > 0) ...[
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_forward_rounded,
                  color: theme.colorScheme.onPrimary,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  'Join Now',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}