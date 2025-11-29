import 'package:flutter/material.dart';

import '../features/places/presentation/pages/place_list_page.dart';

class TurkTripApp extends StatelessWidget {
  const TurkTripApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TurkTrip',
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const PlaceListPage(),
    );
  }
}
