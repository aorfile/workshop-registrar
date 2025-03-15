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
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        image: DecorationImage(
          image: AssetImage(workshop.backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Gradient overlay
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
          // Status and type indicators
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

  Widget _buildStatusChip(BuildContext context) {
    final theme = Theme.of(context);
    Color statusColor;
    String statusText;

    switch (workshop.status) {
      case 'scheduled':
        statusColor = theme.colorScheme.primary;
        statusText = 'Upcoming';
        break;
      case 'in-progress':
        statusColor = theme.colorScheme.secondary;
        statusText = 'In Progress';
        break;
      case 'completed':
        statusColor = Colors.grey;
        statusText = 'Completed';
        break;
      case 'cancelled':
        statusColor = theme.colorScheme.error;
        statusText = 'Cancelled';
        break;
      default:
        statusColor = Colors.grey;
        statusText = 'Unknown';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statusText,
        style: theme.textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
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
        typeIcon = Icons.video_camera_front;
        typeColor = theme.colorScheme.primary;
        typeText = 'Virtual';
        break;
      case 'physical':
        typeIcon = Icons.location_on;
        typeColor = theme.colorScheme.secondary;
        typeText = 'In-Person';
        break;
      case 'hybrid':
        typeIcon = Icons.devices;
        typeColor = theme.colorScheme.tertiary;
        typeText = 'Hybrid';
        break;
      default:
        typeIcon = Icons.help_outline;
        typeColor = Colors.grey;
        typeText = 'Unknown';
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
              blurRadius: 4,
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
        InfoChip(
          icon: Icons.calendar_today,
          text: DateFormat('MMM d, y').format(workshop.workshopDate),
        ),
        InfoChip(
          icon: Icons.access_time,
          text: workshop.durationFormatted,
        ),
        if (workshop.minParticipants! > 1)
          InfoChip(
            icon: Icons.group,
            text: 'Min. ${workshop.minParticipants} participants',
          ),
      ],
    );
  }

  Widget _buildFooter(ThemeData theme) {
    final isAvailable = workshop.spotsLeft > 0 && workshop.isScheduled;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${workshop.spotsLeft} spots left',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isAvailable ? theme.colorScheme.primary : theme.colorScheme.error,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${workshop.currentRegistrations}/${workshop.capacity} registered',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
        FilledButton(
          onPressed: isAvailable ? onRegister : null,
          child: Text(isAvailable ? 'Register' : 'Full'),
        ),
      ],
    );
  }
}