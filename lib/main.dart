import 'package:flutter/material.dart';
import 'package:frontend/services/user_provider.dart';
import 'package:frontend/themes/app_theme.dart';
import 'package:frontend/themes/theme_provider.dart';
import 'package:frontend/user/auth/views/form.dart';
import 'package:frontend/user/auth/views/password_reset_screen.dart';
import 'package:frontend/user/auth/views/phone_login_screen.dart';
import 'package:frontend/user/auth/views/phone_verification_screen.dart';
import 'package:frontend/user/auth/views/sign_in_screen.dart';
import 'package:frontend/user/auth/views/sign_up_screen.dart';
import 'package:provider/provider.dart';
import 'package:frontend/user/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeNotifier = ThemeProvider();
  await themeNotifier.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeNotifier),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          home: MainScreen(),
        );
      },
    );
  }
}
