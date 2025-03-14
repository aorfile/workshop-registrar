import 'package:flutter/material.dart';
import 'package:frontend/models/workshop_model.dart';
import 'package:frontend/user/home/screens/workshop_detail_screen.dart';
import 'package:frontend/user/home/widgets/home_app_bar.dart';
import 'package:frontend/user/home/widgets/home_widget/category_widget.dart';
import 'package:frontend/user/home/widgets/home_widget/featured_workshop_card.dart';
import 'package:frontend/user/home/widgets/home_widget/search_bar.dart';
import 'package:frontend/user/home/widgets/home_widget/welcome_header.dart';
import 'package:frontend/user/home/widgets/home_widget/workshop_card.dart';

import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  final _categories = ['All', 'Development', 'Design', 'Marketing', 'Business'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: HomeAppBar(userLogin: DateTime.now().toString()),
      body: Column(
        children: [
          WorkshopSearchBar(
            onChanged: (query) {
              // Implement search functionality
            },
          ),
          CategoriesBar(
            categories: _categories,
            selectedIndex: _selectedCategoryIndex,
            onCategorySelected: (index) {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // Implement refresh functionality
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  WelcomeHeader(
                    dateTime: DateFormat(
                      'yyyy-MM-dd HH:mm:ss',
                    ).format(DateTime.now().toUtc()),
                  ),
                  const SizedBox(height: 24),
                  FeaturedWorkshopCard(
                    workshop: Workshop(
                      workshopId: 'featured-1',
                      title: 'Advanced Flutter Workshop',
                      description: 'Master state management and animations',
                      workshopDate: DateTime.now().add(const Duration(days: 1)),
                      endTime: DateTime.now().add(
                        const Duration(days: 1, hours: 2),
                      ),
                      location: 'Online',
                      locationType: 'virtual',
                      capacity: 20,
                      currentRegistrations: 15,
                      createdBy: 'hello',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                      category: 'Development',
                      meetingLink: 'https://meet.google.com',
                    ),
                    onTap: () => _navigateToWorkshopDetails(context),
                  ),
                  const SizedBox(height: 24),
                  _buildUpcomingWorkshops(theme),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createNewWorkshop(context),
        backgroundColor: theme.colorScheme.primary,
        icon: const Icon(Icons.add),
        label: Text('New Workshop', style: theme.textTheme.labelLarge),
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
            TextButton(
              onPressed: () => _viewAllWorkshops(context),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            final workshop = Workshop(
              workshopId: 'workshop-$index',
              title: 'Workshop ${index + 1}',
              description: 'This is a sample workshop description',
              workshopDate: DateTime.now().add(Duration(days: index + 2)),
              endTime: DateTime.now().add(Duration(days: index + 2, hours: 2)),
              location: index % 2 == 0 ? 'Online' : 'Office',
              locationType: index % 2 == 0 ? 'virtual' : 'physical',
              capacity: 20,
              currentRegistrations: 15 - index,
              createdBy: DateTime.now().toString(),
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              category: 'Development',
            );

            return WorkshopCard(
              workshop: workshop,
              onTap:
                  () => _navigateToWorkshopDetails(context, workshop: workshop),
              onRegister: () => _registerForWorkshop(context, workshop),
            );
          },
        ),
      ],
    );
  }

  void _navigateToWorkshopDetails(BuildContext context, {Workshop? workshop}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => WorkshopDetailsScreen(
              workshop:
                  workshop ??
                  Workshop(
                    workshopId: 'featured-1',
                    title: 'Advanced Flutter Workshop',
                    description: 'Master state management and animations',
                    workshopDate: DateTime.now().add(const Duration(days: 1)),
                    endTime: DateTime.now().add(
                      const Duration(days: 1, hours: 2),
                    ),
                    location: 'Online',
                    locationType: 'virtual',
                    capacity: 20,
                    currentRegistrations: 15,
                    createdBy: DateTime.now().toString(),
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                    category: 'Development',
                    meetingLink: 'https://meet.google.com',
                  ),
            ),
      ),
    );
  }

  void _createNewWorkshop(BuildContext context) {
    // Implement workshop creation
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Coming Soon'),
            content: const Text('Workshop creation will be available soon!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _viewAllWorkshops(BuildContext context) {
    // Implement view all workshops
  }

  void _registerForWorkshop(BuildContext context, Workshop workshop) {
    // Implement workshop registration
    _navigateToWorkshopDetails(context, workshop: workshop);
  }
}
