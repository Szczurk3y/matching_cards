import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:matching_cards/screens/MatchingCards.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 96, 59, 181),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(
    MaterialApp(
      theme: theme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const MatchingCards(),
    ),
  );
}
