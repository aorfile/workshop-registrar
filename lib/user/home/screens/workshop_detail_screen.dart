import 'package:flutter/material.dart';
import 'package:frontend/models/workshop_model.dart';
import 'package:frontend/admin/widgets/reponsive_container.dart';
import 'package:frontend/utils/responsive_helper.dart';
import 'package:frontend/user/home/widgets/details_screen.dart/gallery_section.dart';
import 'package:frontend/user/home/widgets/details_screen.dart/info_section.dart';
import 'package:frontend/user/home/widgets/details_screen.dart/participant_section.dart';
import 'package:frontend/user/home/widgets/details_screen.dart/workshop_actions.dart';
import 'package:frontend/user/home/widgets/details_screen.dart/workshop_header.dart';
 final DateTime currentTime = DateTime.now();
  final String currentUser = 'aorfile'; 
class WorkshopDetailScreen extends StatelessWidget {
  final Workshop workshop;
  // Current Date and Time (UTC): 2025-03-17 15:31:01
 // Current User's Login

  const WorkshopDetailScreen({
    super.key,
    required this.workshop,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, deviceType) {
          return CustomScrollView(
            slivers: [
              _buildAppBar(context, deviceType),
              SliverToBoxAdapter(
                child: ResponsiveContainer(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: deviceType == DeviceType.desktop
                        ? _buildDesktopLayout(context)
                        : _buildMobileLayout(context),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: ResponsiveBuilder(
        builder: (context, deviceType) {
          if (deviceType == DeviceType.desktop) {
            return const SizedBox.shrink(); // Desktop uses side panel instead
          }
          return _buildBottomBar(context);
        },
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WorkshopInfoSection(workshop: workshop),
              const SizedBox(height: 24),
              ParticipantSection(workshop: workshop),
              if (workshop.galleryImages?.isNotEmpty ?? false) ...[
                const SizedBox(height: 24),
                GallerySection(images: workshop.galleryImages!),
              ],
              const SizedBox(height: 32),
            ],
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WorkshopActions(workshop: workshop),
                  const SizedBox(height: 24),
                  _buildRegistrationPanel(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WorkshopInfoSection(workshop: workshop),
        const SizedBox(height: 24),
        WorkshopActions(workshop: workshop),
        const SizedBox(height: 24),
        ParticipantSection(workshop: workshop),
        if (workshop.galleryImages?.isNotEmpty ?? false) ...[
          const SizedBox(height: 24),
          GallerySection(images: workshop.galleryImages!),
        ],
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context, DeviceType deviceType) {
    return SliverAppBar(
      expandedHeight: deviceType == DeviceType.desktop ? 320 : 240,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: WorkshopHeader(workshop: workshop),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        if (workshop.createdBy == currentUser)
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit workshop screen
            },
          ),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {
            // Implement share functionality
          },
        ),
      ],
    );
  }

  Widget _buildRegistrationPanel(BuildContext context) {
    final theme = Theme.of(context);
    final isAvailable = workshop.spotsLeft > 0 && workshop.isScheduled;
    final isRegistered = false; // TODO: Implement registration check

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Registration',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        _buildRegistrationStats(context),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: isAvailable && !isRegistered ? () {} : null,
            icon: Icon(
              isRegistered ? Icons.check : Icons.add_rounded,
              size: 18,
            ),
            label: Text(
              isRegistered ? 'Registered' : isAvailable ? 'Register Now' : 'Full',
            ),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegistrationStats(BuildContext context) {
    final theme = Theme.of(context);
    final isAvailable = workshop.spotsLeft > 0 && workshop.isScheduled;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${workshop.currentRegistrations}',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Registered',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(width: 32),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${workshop.spotsLeft}',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: isAvailable ? theme.colorScheme.primary : theme.colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Spots Left',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    if (!workshop.isScheduled) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final isAvailable = workshop.spotsLeft > 0 && workshop.isScheduled;
    final isRegistered = false; // TODO: Implement registration check

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isAvailable ? '${workshop.spotsLeft} spots left' : 'Workshop is full',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: isAvailable ? theme.colorScheme.primary : theme.colorScheme.error,
                      fontWeight: FontWeight.bold,
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
            ),
            FilledButton.icon(
              onPressed: isAvailable && !isRegistered ? () {} : null,
              icon: Icon(
                isRegistered ? Icons.check : Icons.add_rounded,
                size: 18,
              ),
              label: Text(
                isRegistered ? 'Registered' : isAvailable ? 'Register Now' : 'Full',
              ),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}