import 'package:flutter/material.dart';
import 'package:frontend/themes/app_theme.dart';

import 'package:frontend/user/home/views/home.dart';
import 'package:frontend/user/home/views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
   

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: HomeScreen() 
    );
  }
}

