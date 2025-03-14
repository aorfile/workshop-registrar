import 'package:flutter/material.dart';

class WorkshopsScreen extends StatelessWidget {
  const WorkshopsScreen({super.key});

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
            child: Text('A', style: theme.textTheme.labelLarge),
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
        Text('Welcome Back!', style: theme.textTheme.displayMedium),
        const SizedBox(height: 8),
        Text('2025-03-12 20:39:40 UTC', style: theme.textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildFeaturedWorkshop(ThemeData theme) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Advanced Flutter Workshop',
              style: theme.textTheme.displayMedium?.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Master state management and animations',
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
            ),
            const Spacer(),
            Row(
              children: [
                _buildFeaturedInfoChip(theme, Icons.calendar_today, 'Mar 15'),
                const SizedBox(width: 12),
                _buildFeaturedInfoChip(theme, Icons.access_time, '2h 30m'),
                const SizedBox(width: 12),
                _buildFeaturedInfoChip(theme, Icons.people, '5 spots left'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedInfoChip(ThemeData theme, IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        // color: Colors.white.withOpacity(0.2),
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
        Text(
          'Upcoming Workshops',
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        _buildWorkshopCard(
          theme: theme,
          title: 'UI/UX Design Basics',
          date: 'Mar 16',
          duration: '1h 30m',
        ),
      ],
    );
  }

  Widget _buildWorkshopCard({
    required ThemeData theme,
    required String title,
    required String date,
    required String duration,
  }) {
    return Card(
      child: ListTile(
        title: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('$date • $duration', style: theme.textTheme.bodyMedium),
      ),
    );
  }
}
