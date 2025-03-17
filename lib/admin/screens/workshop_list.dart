import 'package:flutter/material.dart';
import 'package:frontend/admin/widgets/search_filter_bar.dart';
import 'package:frontend/admin/widgets/workshop_card.dart';
import 'package:frontend/utils/responsive_helper.dart';

class WorkshopList extends StatefulWidget {
  const WorkshopList({super.key});

  @override
  State<WorkshopList> createState() => _WorkshopListState();
}

class _WorkshopListState extends State<WorkshopList> {
  bool _isGridView = true;
  String _searchQuery = '';
  String _statusFilter = 'all';
  // Using the current timestamp
  final DateTime currentTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, deviceType) {
        return Column(
          children: [
            SearchFilterBar(
              onSearch: (query) => setState(() => _searchQuery = query),
              onStatusChanged: (status) => setState(() => _statusFilter = status),
              onViewToggle: deviceType != DeviceType.mobile 
                  ? (isGrid) => setState(() => _isGridView = isGrid)
                  : null,
              isGridView: _isGridView,
              deviceType: deviceType,
            ),
            Expanded(
              child: deviceType == DeviceType.mobile 
                  ? _buildList()
                  : _isGridView ? _buildGrid(deviceType) : _buildList(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildGrid(DeviceType deviceType) {
    final crossAxisCount = deviceType == DeviceType.desktop ? 3 : 2;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1.5,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return WorkshopCard(
          title: 'Flutter Workshop ${index + 1}',
          date: currentTime.add(Duration(days: index)),
          location: index % 2 == 0 ? 'Room 101' : 'Virtual',
          registrations: 30 + index,
          capacity: 50,
          status: _getStatus(index),
        );
      },
      itemCount: 10,
    );
  }

  Widget _buildList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return WorkshopCard(
          title: 'Flutter Workshop ${index + 1}',
          date: currentTime.add(Duration(days: index)),
          location: index % 2 == 0 ? 'Room 101' : 'Virtual',
          registrations: 30 + index,
          capacity: 50,
          status: _getStatus(index),
          isListView: true,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: 10,
    );
  }

  String _getStatus(int index) {
    final statuses = ['scheduled', 'in-progress', 'completed', 'cancelled'];
    return statuses[index % statuses.length];
  }
}