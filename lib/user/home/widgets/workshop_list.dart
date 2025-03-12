import 'package:flutter/material.dart';
import 'package:frontend/common/demo.dart';
import 'package:frontend/user/home/model/workshop.dart';
import 'package:frontend/user/home/widgets/workshop_card.dart';



class WorkshopList extends StatelessWidget {
  const WorkshopList({Key? key}) : super(key: key);
      

  @override
  Widget build(BuildContext context) {
    final workshops = DemoData.workshops;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return _buildWideLayout(workshops);
        }
        return _buildNarrowLayout(workshops);
      },
    );
  }

  Widget _buildWideLayout(List<Workshop> workshops) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: workshops.length,
      itemBuilder: (context, index) {
        return WorkshopCard(workshop: workshops[index]);
      },
    );
  }

  Widget _buildNarrowLayout(List<Workshop> workshops) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: workshops.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return WorkshopCard(workshop: workshops[index]);
      },
    );
  }
}