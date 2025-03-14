import 'package:flutter/material.dart';
import 'package:frontend/models/workshop_model.dart';
import 'package:frontend/user/home/widgets/home_widget/workshop_card.dart';

import 'package:intl/intl.dart';

class MyWorkshopsScreen extends StatefulWidget {
  const MyWorkshopsScreen({super.key});

  @override
  State<MyWorkshopsScreen> createState() => _MyWorkshopsScreenState();
}

class _MyWorkshopsScreenState extends State<MyWorkshopsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Upcoming', 'Past', 'Created'];

  // Fixed current date and user
  final currentDateTime = DateTime.utc(2025, 3, 14, 19, 47, 15);
  final currentUserLogin = 'aorfile';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Workshops'),
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _WorkshopsList(
            workshops: _getUpcomingWorkshops(),
            emptyMessage: 'No upcoming workshops',
            currentDateTime: currentDateTime,
          ),
          _WorkshopsList(
            workshops: _getPastWorkshops(),
            emptyMessage: 'No past workshops',
            currentDateTime: currentDateTime,
          ),
          _WorkshopsList(
            workshops: _getCreatedWorkshops(),
            emptyMessage: 'No created workshops',
            currentDateTime: currentDateTime,
          ),
        ],
      ),
    );
  }

  List<Workshop> _getUpcomingWorkshops() {
    return List.generate(
      3,
      (index) => Workshop(
        workshopId: 'upcoming-$index',
        title: 'Upcoming Workshop ${index + 1}',
        description: 'This is an upcoming workshop you have registered for',
        workshopDate: currentDateTime.add(Duration(days: index + 1)),
        endTime: currentDateTime.add(Duration(days: index + 1, hours: 2)),
        location: index % 2 == 0 ? 'Online' : 'Conference Room A',
        locationType: index % 2 == 0 ? 'virtual' : 'physical',
        capacity: 20,
        currentRegistrations: 15,
        createdBy: 'instructor${index + 1}',
        createdAt: currentDateTime,
        updatedAt: currentDateTime,
        category: 'Development',
        meetingLink: index % 2 == 0 ? 'https://meet.google.com' : null,
      ),
    );
  }

  List<Workshop> _getPastWorkshops() {
    return List.generate(
      5,
      (index) => Workshop(
        workshopId: 'past-$index',
        title: 'Past Workshop ${index + 1}',
        description: 'This is a completed workshop you attended',
        workshopDate: currentDateTime.subtract(Duration(days: index + 1)),
        endTime: currentDateTime
            .subtract(Duration(days: index + 1))
            .add(const Duration(hours: 2)),
        location: index % 2 == 0 ? 'Online' : 'Training Room B',
        locationType: index % 2 == 0 ? 'virtual' : 'physical',
        capacity: 20,
        currentRegistrations: 20,
        createdBy: 'instructor${index + 1}',
        createdAt: currentDateTime.subtract(Duration(days: index + 10)),
        updatedAt: currentDateTime.subtract(Duration(days: index + 1)),
        category: 'Design',
        meetingLink: index % 2 == 0 ? 'https://meet.google.com' : null,
      ),
    );
  }

  List<Workshop> _getCreatedWorkshops() {
    return List.generate(
      2,
      (index) => Workshop(
        workshopId: 'created-$index',
        title: 'My Workshop ${index + 1}',
        description: 'This is a workshop you created',
        workshopDate: currentDateTime.add(Duration(days: index + 5)),
        endTime: currentDateTime.add(Duration(days: index + 5, hours: 2)),
        location: 'Conference Room C',
        locationType: 'physical',
        capacity: 25,
        currentRegistrations: 10,
        createdBy: currentUserLogin,
        createdAt: currentDateTime.subtract(const Duration(days: 5)),
        updatedAt: currentDateTime,
        category: 'Business',
      ),
    );
  }
}

class _WorkshopsList extends StatelessWidget {
  final List<Workshop> workshops;
  final String emptyMessage;
  final DateTime currentDateTime;

  const _WorkshopsList({
    required this.workshops,
    required this.emptyMessage,
    required this.currentDateTime,
  });

  @override
  Widget build(BuildContext context) {
    if (workshops.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        // Implement refresh functionality
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: workshops.length,
        itemBuilder: (context, index) {
          final workshop = workshops[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == 0 || !_isSameDay(workshops[index - 1], workshop))
                _buildDateHeader(context, workshop),
              WorkshopCard(
                workshop: workshop,
                onTap: () => _navigateToWorkshopDetails(context, workshop),
                onRegister: () => _handleWorkshopAction(context, workshop),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            emptyMessage,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildDateHeader(BuildContext context, Workshop workshop) {
    final theme = Theme.of(context);
    final now = currentDateTime;
    final workshopDate = workshop.workshopDate;
    String dateText;

    if (workshopDate.year == now.year &&
        workshopDate.month == now.month &&
        workshopDate.day == now.day) {
      dateText = 'Today';
    } else if (workshopDate.year == now.year &&
        workshopDate.month == now.month &&
        workshopDate.day == now.day + 1) {
      dateText = 'Tomorrow';
    } else {
      dateText = DateFormat('EEEE, MMMM d').format(workshopDate);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        dateText,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  bool _isSameDay(Workshop w1, Workshop w2) {
    return w1.workshopDate.year == w2.workshopDate.year &&
        w1.workshopDate.month == w2.workshopDate.month &&
        w1.workshopDate.day == w2.workshopDate.day;
  }

  void _navigateToWorkshopDetails(BuildContext context, Workshop workshop) {
    Navigator.pushNamed(context, '/workshop-details', arguments: workshop);
  }

  void _handleWorkshopAction(BuildContext context, Workshop workshop) {
    if (workshop.workshopDate.isBefore(currentDateTime)) {
      _showWorkshopCompletionDialog(context, workshop);
    } else {
      _showWorkshopOptionsDialog(context, workshop);
    }
  }

  void _showWorkshopCompletionDialog(BuildContext context, Workshop workshop) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Workshop Completed'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.card_membership),
                  title: const Text('View Certificate'),
                  onTap: () {
                    Navigator.pop(context);
                    // Implement certificate view
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.feedback),
                  title: const Text('Provide Feedback'),
                  onTap: () {
                    Navigator.pop(context);
                    // Implement feedback form
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _showWorkshopOptionsDialog(BuildContext context, Workshop workshop) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Workshop Options'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Add to Calendar'),
                  onTap: () {
                    Navigator.pop(context);
                    // Implement calendar integration
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.cancel),
                  title: const Text('Cancel Registration'),
                  onTap: () {
                    Navigator.pop(context);
                    // Implement registration cancellation
                  },
                ),
              ],
            ),
          ),
    );
  }
}
