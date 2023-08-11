import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:matching_cards/screens/MatchingCards.dart';

var kColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: const Color.fromARGB(255, 100, 223, 205),
  background: const Color.fromARGB(255, 100, 223, 205),
);
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
  background: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  var lightTheme = ThemeData().copyWith(
    useMaterial3: true,
    colorScheme: kColorScheme,
    brightness: Brightness.light,
    textTheme: GoogleFonts.latoTextTheme(),
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: const Color.fromARGB(255, 100, 223, 205),
      foregroundColor: const Color.fromARGB(255, 144, 40, 73),
    ),
    scaffoldBackgroundColor: kColorScheme.background,
  );

  var darkTheme = ThemeData().copyWith(
    useMaterial3: true,
    colorScheme: kDarkColorScheme,
    brightness: Brightness.dark,
    textTheme: GoogleFonts.latoTextTheme(),
  );

  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: const MatchingCards(),
      ),
    ),
  );
}
