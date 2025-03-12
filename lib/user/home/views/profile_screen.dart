import 'package:flutter/material.dart';
import 'package:frontend/user/home/widgets/profile_header.dart';
import 'package:frontend/user/home/widgets/registration_list.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          ProfileHeader(),
          SizedBox(height: 24),
          RegistrationList(),
        ],
      ),
    );
  }
}