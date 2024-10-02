import 'package:expense_tracker_app/database/db_helper.dart';
import 'package:expense_tracker_app/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: const HomePage(),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF4aee1f8),
        primary: const Color(0xFF4aee1f8),
        secondary: const Color(0xFFaee1f8),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFaee1f8),
        foregroundColor: Colors.black87,
      ),
      textTheme: GoogleFonts.notoSansAdlamTextTheme(),
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
    );
  }
}
