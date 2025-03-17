import 'package:flutter/material.dart';
import 'package:frontend/utils/responsive_helper.dart';

class SearchFilterBar extends StatelessWidget {
  final Function(String) onSearch;
  final Function(String) onStatusChanged;
  final Function(bool)? onViewToggle;
  final bool isGridView;
  final DeviceType deviceType;

  const SearchFilterBar({
    super.key,
    required this.onSearch,
    required this.onStatusChanged,
    this.onViewToggle,
    required this.isGridView,
    required this.deviceType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search workshops...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: onSearch,
              ),
            ),
            const SizedBox(width: 16),
            DropdownButton<String>(
              value: 'all',
              items: [
                'all',
                'scheduled',
                'in-progress',
                'completed',
                'cancelled',
              ].map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) onStatusChanged(value);
              },
            ),
            if (deviceType != DeviceType.mobile && onViewToggle != null) ...[
              const SizedBox(width: 16),
              ToggleButtons(
                isSelected: [isGridView, !isGridView],
                onPressed: (index) => onViewToggle?.call(index == 0),
                children: const [
                  Icon(Icons.grid_view),
                  Icon(Icons.list),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}