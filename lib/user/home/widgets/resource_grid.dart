import 'package:flutter/material.dart';
import 'package:frontend/common/demo.dart';
import 'package:frontend/user/home/widgets/resource_card.dart';


class ResourceGrid extends StatelessWidget {
 
  const ResourceGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final resources = DemoData.resources;
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1200 
            ? 4 
            : constraints.maxWidth > 800 
                ? 3 
                : constraints.maxWidth > 600 
                    ? 2 
                    : 1;

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemCount: resources.length,
          itemBuilder: (context, index) {
            final resource = resources[index];
            return ResourceCard(resource: resource);
          },
        );
      },
    );
  }
}