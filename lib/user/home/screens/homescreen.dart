import 'package:flutter/material.dart';
import 'package:frontend/user/home/models/workshop.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Workshops!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Upcoming Workshops',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _buildUpcomingWorkshops(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingWorkshops() {
    // TODO: Replace with actual data
    final workshops = [
      Workshop(
        id: '1',
        title: 'Flutter Basics',
        description: 'Learn the basics of Flutter development',
        dateTime: DateTime.now().add(const Duration(days: 2)),
        duration: 120,
        capacity: 20,
      ),
      Workshop(
        id: '2',
        title: 'Advanced State Management',
        description: 'Deep dive into state management solutions',
        dateTime: DateTime.now().add(const Duration(days: 5)),
        duration: 180,
        capacity: 15,
      ),
    ];

    return ListView.builder(
      itemCount: workshops.length,
      itemBuilder: (context, index) {
        final workshop = workshops[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(workshop.title),
            subtitle: Text(
              '${workshop.dateTime.toString().split('.')[0]}\n'
              'Duration: ${workshop.duration} minutes',
            ),
            isThreeLine: true,
            trailing: ElevatedButton(
              onPressed: () {
                // TODO: Implement workshop details navigation
              },
              child: const Text('Details'),
            ),
          ),
        );
      },
    );
  }
}