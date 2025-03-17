import 'package:frontend/admin/auth/views/auth_screen.dart';
import 'package:frontend/admin/screens/create_worshop_screen.dart';

import 'package:frontend/admin/widgets/workshop_manager.dart';
import 'package:frontend/models/workshop_model.dart';
import 'package:frontend/user/auth/views/form.dart';
import 'package:frontend/user/auth/views/phone_login_screen.dart';
import 'package:frontend/user/auth/views/phone_verification_screen.dart';
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
    GoRoute(path: '/', builder: (context, state) => SignInPage()),
    GoRoute(path: '/phone', builder: (context, state) => PhoneLoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => MainScreen()),
    GoRoute(path: '/form', builder: (context, state) => FormPage()),
    GoRoute(
      path: '/admin/dashboard',
      builder: (context, state) => WorkshopManager(),
    ),
    GoRoute(
      path: '/phone/verify',
      builder: (context, state) => PhoneVerificationScreen(),
    ),
    GoRoute(
      path: '/admin/create',
      builder: (context, state) => CreateWorkshopScreen(),
    ),
    GoRoute(path: '/admin/login', builder: (context, state) => AdminAuthPage()),
    GoRoute(path: '/profile', builder: (context, state) => ProfileScreen()),
    GoRoute(path: '/login', builder: (context, state) => SignInPage()),
    GoRoute(path: '/signup', builder: (context, state) => SignInPage()),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        final Workshop workshop = state.extra as Workshop;
        return WorkshopDetailScreen(workshop: workshop);
      },
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) {
        final workshop = state.extra as Workshop?;
        if (workshop == null) {
          return const HomeScreen();
        }
        return WorkshopRegistrationScreen(workshop: workshop);
      },
    ),
  ],
);
