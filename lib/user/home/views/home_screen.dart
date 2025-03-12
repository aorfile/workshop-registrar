import 'package:flutter/material.dart';
import 'package:frontend/user/home/widgets/featured_workshops.dart';
import 'package:frontend/user/home/widgets/quick_action.dart';
import 'package:frontend/user/home/widgets/recent_resouces.dart';
import 'package:frontend/user/home/widgets/stat_card.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeScreen extends StatelessWidget {
  static const String currentDateTime = '2025-03-12 16:07:10';
  static const String currentUser = 'aorfile';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  StatsGrid(),
                  SizedBox(height: 32),
                  QuickActions(),
                  SizedBox(height: 32),
                  FeaturedWorkshops(),
                  SizedBox(height: 32),
                  RecentResources(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'UTC: $currentDateTime',
                style: GoogleFonts.firaCode(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                currentUser,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'Welcome back,\n$currentUser!',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Stay updated with your workshop registrations and resources.',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}