import 'package:flutter/material.dart';
import 'package:frontend/user/home/widgets/workshop_filter.dart';
import 'package:frontend/user/home/widgets/workshop_list.dart';


class WorkshopsScreen extends StatelessWidget {
  const WorkshopsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        WorkshopFilter(),
        Expanded(
          child: WorkshopList(),
        ),
      ],
    );
  }
}