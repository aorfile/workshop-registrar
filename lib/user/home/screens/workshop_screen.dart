import 'package:flutter/material.dart';
import 'package:frontend/models/workshop_model.dart';
import 'package:frontend/user/home/screens/workshop_detail_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: _buildAppBar(theme),
      body: _buildBody(theme),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: theme.colorScheme.primary,
        icon: const Icon(Icons.add),
        label: Text('New Workshop', style: theme.textTheme.labelLarge),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      elevation: 0,
      backgroundColor: theme.cardTheme.color,
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: theme.colorScheme.primary,
            child: Text(
              'A',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'aorfile',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {},
          color: theme.colorScheme.onSurface,
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
          color: theme.colorScheme.onSurface,
        ),
      ],
    );
  }

  Widget _buildBody(ThemeData theme) {
    return Column(
      children: [
        _buildSearchBar(theme),
        _buildCategories(theme),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildHeader(theme),
              const SizedBox(height: 24),
              _buildFeaturedWorkshop(theme),
              const SizedBox(height: 24),
              _buildUpcomingWorkshops(theme),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
    return Container(
      color: theme.cardTheme.color,
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search workshops...',
          hintStyle: theme.textTheme.bodyMedium,
          prefixIcon: Icon(
            Icons.search,
            color: theme.colorScheme.onSurface.withOpacity(0.5),
          ),
          filled: true,
          fillColor: theme.colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildCategories(ThemeData theme) {
    final categories = [
      'All',
      'Development',
      'Design',
      'Marketing',
      'Business',
    ];

    return Container(
      height: 60,
      color: theme.cardTheme.color,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == 0;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Text(categories[index]),
              onSelected: (_) {},
              backgroundColor: theme.cardTheme.color,
              selectedColor: theme.colorScheme.primary.withOpacity(0.1),
              labelStyle: theme.textTheme.bodyMedium?.copyWith(
                color:
                    isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
              side: BorderSide(
                color:
                    isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface.withOpacity(0.2),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back!',
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '2025-03-14 18:57:48 UTC',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedWorkshop(ThemeData theme) {
    final workshop = Workshop(
      workshopId: 'featured-1',
      title: 'Advanced Flutter Workshop',
      description: 'Master state management and animations',
      workshopDate: DateTime.now().add(const Duration(days: 1)),
      endTime: DateTime.now().add(const Duration(days: 1, hours: 2)),
      location: 'Online',
      locationType: 'virtual',
      capacity: 20,
      currentRegistrations: 15,
      createdBy: 'aorfile',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      category: 'Development',
      meetingLink: 'https://meet.google.com',
    );

    return GestureDetector(
      onTap: () {},
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
              Container(
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
              ),
              const SizedBox(height: 16),
              Text(
                workshop.title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                workshop.description ?? '',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  _buildFeaturedInfoChip(
                    theme,
                    Icons.calendar_today,
                    DateFormat('MMM d').format(workshop.workshopDate),
                  ),
                  const SizedBox(width: 12),
                  _buildFeaturedInfoChip(
                    theme,
                    Icons.access_time,
                    '${workshop.duration.inHours}h ${workshop.duration.inMinutes % 60}m',
                  ),
                  const SizedBox(width: 12),
                  _buildFeaturedInfoChip(
                    theme,
                    Icons.people,
                    '${workshop.spotsLeft} spots left',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedInfoChip(ThemeData theme, IconData icon, String text, ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingWorkshops(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming Workshops',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(onPressed: () {}, child: const Text('View All')),
          ],
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return _buildWorkshopCard(
              theme,
              
              Workshop(
                workshopId: 'workshop-$index',
                title: 'Workshop ${index + 1}',
                description: 'This is a sample workshop description',
                workshopDate: DateTime.now().add(Duration(days: index + 2)),
                endTime: DateTime.now().add(
                  Duration(days: index + 2, hours: 2),
                ),
                location: index % 2 == 0 ? 'Online' : 'Office',
                capacity: 20,
                currentRegistrations: 15 - index,
                createdBy: 'aorfile',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                category: 'Development',
              )
              context,
            );
          },
        ),
      ],
    );
  }

  Widget _buildWorkshopCard(ThemeData theme, Workshop workshop ,BuildContext context) {
    final isOnline = workshop.locationType == 'virtual';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.7,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
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
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildWorkshopInfoChip(
                    theme,
                    Icons.calendar_today,
                    DateFormat('MMM d, y').format(workshop.workshopDate),
                  ),
                  const SizedBox(width: 16),
                  _buildWorkshopInfoChip(
                    theme,
                    Icons.access_time,
                    DateFormat('HH:mm').format(workshop.workshopDate),
                  ),
                  const SizedBox(width: 16),
                  _buildWorkshopInfoChip(
                    theme,
                    Icons.location_on,
                    workshop.location,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
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
                    onPressed:
                        workshop.spotsLeft > 0
                            ? () {
                              // In your workshop card onTap or anywhere you want to show the details
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => WorkshopDetailsScreen(
                                        workshop: workshop,
                                      ),
                                ),
                              );
                            }
                            : null,
                    child: const Text('Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkshopInfoChip(ThemeData theme, IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: theme.colorScheme.onSurface.withOpacity(0.7),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
