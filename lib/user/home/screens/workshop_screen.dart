import 'package:flutter/material.dart';
import '../models/workshop.dart';

class WorkshopsScreen extends StatelessWidget {
  const WorkshopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workshops'),
      ),
      body: _buildWorkshopsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement workshop registration
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Workshop registration coming soon!')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildWorkshopsList() {
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
      padding: const EdgeInsets.all(16),
      itemCount: workshops.length,
      itemBuilder: (context, index) {
        final workshop = workshops[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workshop.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(workshop.description),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 8),
                    Text(workshop.dateTime.toString().split('.')[0]),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16),
                    const SizedBox(width: 8),
                    Text('${workshop.duration} minutes'),
                    const Spacer(),
                    Text('${workshop.enrolledCount}/${workshop.capacity} enrolled'),
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement enrollment
                  },
                  child: const Text('Enroll Now'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}