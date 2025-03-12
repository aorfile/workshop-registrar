import 'package:flutter/material.dart';
import 'package:frontend/common/demo.dart';
import 'package:frontend/user/home/model/workshop.dart';


class RegistrationList extends StatelessWidget {
  const RegistrationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final demoWorkshops = DemoData.workshops;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Registrations',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: demoWorkshops.take(3).length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final workshop = demoWorkshops[index];
            return RegistrationCard(workshop: workshop);
          },
        ),
      ],
    );
  }
}

class RegistrationCard extends StatelessWidget {
  final Workshop workshop;

  const RegistrationCard({
    Key? key,
    required this.workshop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    workshop.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    // Add to calendar
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.event,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(workshop.date),
                const SizedBox(width: 16),
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(workshop.time),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(workshop.location),
              ],
            ),
          ],
        ),
      ),
    );
  }
}