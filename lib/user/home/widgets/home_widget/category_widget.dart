import 'package:flutter/material.dart';

class CategoriesBar extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final void Function(int)? onCategorySelected;

  const CategoriesBar({
    super.key,
    required this.categories,
    this.selectedIndex = 0,
    this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 60,
      color: theme.cardTheme.color,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Text(categories[index]),
              onSelected: (_) => onCategorySelected?.call(index),
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
}
