import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:frontend/models/workshop_model.dart';
import 'package:frontend/user/home/widgets/home_widget/info_chip.dart';
import 'package:frontend/constants/assets.dart';
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

    return Card(
      elevation: 8,
      shadowColor: theme.colorScheme.primary.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageHeader(context),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(theme),
                  if (workshop.description != null) ...[
                    const SizedBox(height: 8),
                    _buildDescription(theme),
                  ],
                  const SizedBox(height: 16),
                  _buildInfoRow(theme),
                  const SizedBox(height: 16),
                  _buildFooter(theme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageHeader(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: CachedNetworkImage(
              imageUrl: workshop.imageUrl ?? AppAssets.getCategoryImage(workshop.category),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholder: (context, url) => Container(
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Icon(
                  Icons.image_not_supported_rounded,
                  size: 32,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: _buildCategoryChip(context),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: _buildStatusChip(context),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: _buildTypeIcon(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context) {
    final theme = Theme.of(context);
    IconData categoryIcon;

    switch (workshop.category.toLowerCase()) {
      case 'development':
        categoryIcon = Icons.code_rounded;
        break;
      case 'design':
        categoryIcon = Icons.palette_rounded;
        break;
      case 'marketing':
        categoryIcon = Icons.trending_up_rounded;
        break;
      case 'business':
        categoryIcon = Icons.business_center_rounded;
        break;
      case 'technology':
        categoryIcon = Icons.computer_rounded;
        break;
      case 'data':
        categoryIcon = Icons.data_usage_rounded;
        break;
      case 'product':
        categoryIcon = Icons.inventory_2_rounded;
        break;
      case 'leadership':
        categoryIcon = Icons.psychology_rounded;
        break;
      default:
        categoryIcon = Icons.category_rounded;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            categoryIcon,
            size: 16,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 6),
          Text(
            workshop.category,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    final theme = Theme.of(context);
    IconData statusIcon;
    Color statusColor;
    String statusText;

    switch (workshop.status) {
      case 'scheduled':
        statusIcon = Icons.event_available_rounded;
        statusColor = theme.colorScheme.primary;
        statusText = 'Upcoming';
        break;
      case 'in-progress':
        statusIcon = Icons.play_circle_outline_rounded;
        statusColor = theme.colorScheme.secondary;
        statusText = 'In Progress';
        break;
      case 'completed':
        statusIcon = Icons.check_circle_outline_rounded;
        statusColor = Colors.grey;
        statusText = 'Completed';
        break;
      case 'cancelled':
        statusIcon = Icons.cancel_outlined;
        statusColor = theme.colorScheme.error;
        statusText = 'Cancelled';
        break;
      default:
        statusIcon = Icons.help_outline_rounded;
        statusColor = Colors.grey;
        statusText = 'Unknown';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            statusIcon,
            size: 16,
            color: Colors.white,
          ),
          const SizedBox(width: 6),
          Text(
            statusText,
            style: theme.textTheme.labelSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeIcon(BuildContext context) {
    final theme = Theme.of(context);
    IconData typeIcon;
    Color typeColor;
    String typeText;

    switch (workshop.locationType) {
      case 'virtual':
        typeIcon = Icons.videocam_rounded;
        typeColor = theme.colorScheme.primary;
        typeText = 'Virtual Workshop';
        break;
      case 'physical':
        typeIcon = Icons.meeting_room_rounded;
        typeColor = theme.colorScheme.secondary;
        typeText = 'In-Person Workshop';
        break;
      case 'hybrid':
        typeIcon = Icons.devices_rounded;
        typeColor = theme.colorScheme.tertiary;
        typeText = 'Hybrid Workshop';
        break;
      default:
        typeIcon = Icons.help_outline_rounded;
        typeColor = Colors.grey;
        typeText = 'Unknown Format';
    }

    return Tooltip(
      message: typeText,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(typeIcon, color: typeColor, size: 20),
      ),
    );
  }

  Widget _buildTitle(ThemeData theme) {
    return Text(
      workshop.title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDescription(ThemeData theme) {
    return Text(
      workshop.description!,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurface.withOpacity(0.7),
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildInfoRow(ThemeData theme) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.1),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.event_rounded,
                size: 16,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 6),
              Text(
                DateFormat('MMM d, HH:mm').format(workshop.workshopDate),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondaryContainer.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.secondary.withOpacity(0.1),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.timelapse_rounded,
                size: 16,
                color: theme.colorScheme.secondary,
              ),
              const SizedBox(width: 6),
              Text(
                workshop.durationFormatted,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (workshop.minParticipants! > 1)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colorScheme.tertiaryContainer.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: theme.colorScheme.tertiary.withOpacity(0.1),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.group_rounded,
                  size: 16,
                  color: theme.colorScheme.tertiary,
                ),
                const SizedBox(width: 6),
                Text(
                  'Min. ${workshop.minParticipants}',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.tertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildFooter(ThemeData theme) {
    final isAvailable = workshop.spotsLeft > 0 && workshop.isScheduled;
    final isFilling = workshop.currentRegistrations > (workshop.capacity * 0.7);
    final isAlmostFull = workshop.currentRegistrations > (workshop.capacity * 0.9);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isAvailable
                      ? isAlmostFull
                          ? Icons.flash_on_rounded
                          : isFilling
                              ? Icons.directions_run_rounded
                              : Icons.how_to_reg_rounded
                      : Icons.no_accounts_rounded,
                  size: 18,
                  color: isAvailable
                      ? isAlmostFull
                          ? theme.colorScheme.error
                          : isFilling
                              ? theme.colorScheme.error.withOpacity(0.7)
                              : theme.colorScheme.primary
                      : theme.colorScheme.error,
                ),
                const SizedBox(width: 6),
                Text(
                  isAlmostFull
                      ? 'Almost full!'
                      : '${workshop.spotsLeft} spots left',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isAvailable
                        ? isAlmostFull
                            ? theme.colorScheme.error
                            : isFilling
                                ? theme.colorScheme.error.withOpacity(0.7)
                                : theme.colorScheme.primary
                        : theme.colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.group_outlined,
                  size: 16,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                const SizedBox(width: 4),
                Text(
                  '${workshop.currentRegistrations}/${workshop.capacity} registered',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
                FilledButton.icon(
          onPressed: isAvailable ? onRegister : null,
          icon: Icon(
            isAvailable
                ? isAlmostFull
                    ? Icons.bolt_rounded
                    : Icons.add_rounded
                : Icons.block_rounded,
            size: 18,
          ),
          label: Text(
            isAvailable
                ? isAlmostFull
                    ? 'Quick Join'
                    : 'Register'
                : 'Full',
          ),
          style: FilledButton.styleFrom(
            backgroundColor: isAvailable
                ? isAlmostFull
                    ? theme.colorScheme.error
                    : null
                : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
        ),
      ],
    );
  }
}