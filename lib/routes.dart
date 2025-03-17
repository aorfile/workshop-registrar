import 'package:flutter/material.dart';
import 'package:frontend/admin/screens/create_worshop_screen.dart';
import 'package:frontend/admin/screens/dashboard_screen.dart';
import 'package:frontend/admin/widgets/workshop_manager.dart';
import 'package:frontend/models/workshop_model.dart';
import 'package:frontend/user/auth/views/sign_in_screen.dart';
import 'package:frontend/user/home/home.dart';
import 'package:frontend/user/home/screens/main_screen.dart';
import 'package:frontend/user/home/screens/profile_screen.dart';
import 'package:frontend/user/home/screens/register_screen.dart';
import 'package:frontend/user/home/screens/workshop_detail_screen.dart';
import 'package:go_router/go_router.dart';

// Import all screens

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>  WorkshopManager(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfileScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => SignInPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => SignInPage(),
    ),
    GoRoute(
      path: '/register',
      builder:  (context, state) {
     final workshop = state.extra as Workshop?;
        if (workshop == null) {
          // Handle null case, perhaps redirect to home or show error
          return const HomeScreen();
        }
        return WorkshopRegistrationScreen(workshop: workshop);
  },
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) {
    final Workshop workshop = state.extra as Workshop; // Extract object
    return WorkshopDetailScreen(workshop: workshop);
  },
    ),
    
  ],
);
