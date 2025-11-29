import 'package:flutter/material.dart';

import '../features/places/presentation/pages/place_list_page.dart';

class TurkTripApp extends StatelessWidget {
  const TurkTripApp({super.key});

  // TripAdvisor Green Color
  static const Color tripAdvisorGreen = Color(0xFF00AA6C);
  static const Color tripAdvisorGreenDark = Color(0xFF008A5A);
  static const Color tripAdvisorGreenLight = Color(0xFF34E0A1);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TurkTrip',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: tripAdvisorGreen,
          primary: tripAdvisorGreen,
          secondary: tripAdvisorGreenDark,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: tripAdvisorGreen, width: 2),
          ),
        ),
      ),
      home: const PlaceListPage(),
    );
  }
}
