import 'package:flutter/material.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/models/workshop_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:frontend/user/home/widgets/details_screen.dart/gallery_section.dart';
import 'package:frontend/user/home/widgets/details_screen.dart/info_section.dart';
import 'package:frontend/user/home/widgets/details_screen.dart/participant_section.dart';
import 'package:frontend/user/home/widgets/details_screen.dart/workshop_actions.dart';
import 'package:frontend/user/home/widgets/details_screen.dart/workshop_header.dart';

class WorkshopDetailScreen extends StatelessWidget {
  final Workshop workshop;

  const WorkshopDetailScreen({
    super.key,
    required this.workshop,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
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
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: WorkshopHeader(workshop: workshop),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        if (workshop.createdBy == 'aorfile')
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

  Widget _buildBottomBar(BuildContext context) {
    final theme = Theme.of(context);
    final isAvailable = workshop.spotsLeft > 0 && workshop.isScheduled;
    final isRegistered = false; // TODO: Implement registration check

    if (!workshop.isScheduled) {
      return const SizedBox.shrink();
    }

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