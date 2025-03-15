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
  final String _currentDateTime = '2025-03-15 11:51:40';
  final String _currentUser = 'aorfile';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: HomeAppBar(userLogin: _currentUser),
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
                  WelcomeHeader(dateTime: _currentDateTime),
                  const SizedBox(height: 24),
                  _buildFeaturedWorkshop(),
                  const SizedBox(height: 32),
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
        elevation: 4,
        highlightElevation: 8,
        icon: const Icon(Icons.add_rounded),
        label: Text(
          'New Workshop',
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedWorkshop() {
    return FeaturedWorkshopCard(
      workshop: Workshop(
        workshopId: 'featured-1',
        title: 'Advanced Flutter Development',
        description: 'Master state management, animations, and advanced UI patterns',
        workshopDate: DateTime.now().add(const Duration(days: 1)),
        endTime: DateTime.now().add(const Duration(days: 1, hours: 3)),
        location: 'Virtual Classroom',
        locationType: 'virtual',
        capacity: 30,
        currentRegistrations: 22,
        createdBy: _currentUser,
        createdAt: DateTime.parse(_currentDateTime),
        updatedAt: DateTime.parse(_currentDateTime),
        category: 'Development',
        meetingLink: 'https://meet.google.com/featured-workshop',
        prerequisites: 'Basic Flutter knowledge',
        materialsUrl: 'https://workshop-materials.com/flutter-advanced',
        minParticipants: 5,
        status: 'scheduled',
      ),
      onTap: () => _navigateToWorkshopDetails(context),
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
                color: theme.colorScheme.onBackground,
              ),
            ),
            TextButton.icon(
              onPressed: () => _viewAllWorkshops(context),
              icon: const Icon(Icons.arrow_forward_rounded),
              label: const Text('View All'),
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.primary,
                textStyle: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
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
              title: _getWorkshopTitle(index),
              description: _getWorkshopDescription(index),
              workshopDate: DateTime.now().add(Duration(days: index + 2)),
              endTime: DateTime.now().add(Duration(days: index + 2, hours: 2)),
              location: _getWorkshopLocation(index),
              locationType: index % 2 == 0 ? 'virtual' : 'physical',
              capacity: 20,
              currentRegistrations: 15 - index,
              createdBy: _currentUser,
              createdAt: DateTime.parse(_currentDateTime),
              updatedAt: DateTime.parse(_currentDateTime),
              category: _getWorkshopCategory(index),
              meetingLink: index % 2 == 0 ? 'https://meet.google.com/workshop-$index' : null,
              prerequisites: 'Required prerequisites for Workshop ${index + 1}',
              materialsUrl: 'https://materials.com/workshop-$index',
              minParticipants: 3,
              status: 'scheduled',
            );

            return WorkshopCard(
              workshop: workshop,
              onTap: () => _navigateToWorkshopDetails(context, workshop: workshop),
              onRegister: () => _registerForWorkshop(context, workshop),
            );
          },
        ),
      ],
    );
  }

  String _getWorkshopTitle(int index) {
    final titles = [
      'UI/UX Design Fundamentals',
      'Mobile App Marketing',
      'Business Strategy Workshop',
      'Web Development Basics',
      'Digital Marketing Essentials',
    ];
    return titles[index % titles.length];
  }

  String _getWorkshopDescription(int index) {
    final descriptions = [
      'Learn the principles of modern UI/UX design',
      'Master app marketing strategies and user acquisition',
      'Develop effective business strategies for growth',
      'Get started with web development',
      'Understanding digital marketing channels',
    ];
    return descriptions[index % descriptions.length];
  }

  String _getWorkshopLocation(int index) {
    return index % 2 == 0 ? 'Virtual Classroom' : 'Innovation Hub, Floor ${index + 1}';
  }

  String _getWorkshopCategory(int index) {
    final categories = ['Design', 'Marketing', 'Business', 'Development', 'Marketing'];
    return categories[index % categories.length];
  }

  void _navigateToWorkshopDetails(BuildContext context, {Workshop? workshop}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkshopDetailsScreen(
          workshop: workshop ?? Workshop(
            workshopId: 'featured-1',
            title: 'Advanced Flutter Development',
            description: 'Master state management, animations, and advanced UI patterns',
            workshopDate: DateTime.now().add(const Duration(days: 1)),
            endTime: DateTime.now().add(const Duration(days: 1, hours: 3)),
            location: 'Virtual Classroom',
            locationType: 'virtual',
            capacity: 30,
            currentRegistrations: 22,
            createdBy: _currentUser,
            createdAt: DateTime.parse(_currentDateTime),
            updatedAt: DateTime.parse(_currentDateTime),
            category: 'Development',
            meetingLink: 'https://meet.google.com/featured-workshop',
            prerequisites: 'Basic Flutter knowledge',
            materialsUrl: 'https://workshop-materials.com/flutter-advanced',
            minParticipants: 5,
            status: 'scheduled',
          ),
        ),
      ),
    );
  }

  void _createNewWorkshop(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
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
    _navigateToWorkshopDetails(context, workshop: workshop);
  }
}