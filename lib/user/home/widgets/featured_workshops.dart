import 'package:flutter/material.dart';
import 'package:frontend/common/demo.dart';
import 'package:frontend/user/home/model/workshop.dart';
import 'package:frontend/user/home/widgets/featured_workshop_card.dart';

class FeaturedWorkshops extends StatelessWidget {
  const FeaturedWorkshops({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workshops = DemoData.workshops;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return _buildWideLayout(workshops);
        }
        return _buildNarrowLayout(workshops);
      },
    );
  }

  Widget _buildWideLayout(List<Workshop> workshops) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: workshops.length,
      itemBuilder: (context, index) {
        return FeaturedWorkshopCard(
          workshop: workshops[index],
          onTap: () {
            // Handle workshop selection
          },
        );
      },
    );
  }

  Widget _buildNarrowLayout(List<Workshop> workshops) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: workshops.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return FeaturedWorkshopCard(
          workshop: workshops[index],
          onTap: () {
            // Handle workshop selection
          },
        );
      },
    );
  }
}

// Demo data
