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
  seedColor: const Color.fromARGB(255, 146, 34, 74),
);

void main() {
  runApp(
    const ProviderScope(child: App()),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  static _AppState of(BuildContext context) => context.findAncestorStateOfType<_AppState>()!;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _darkMode = false;
  bool get darkMode => _darkMode;

  void setDarkMode(bool isDarkMode) {
    setState(() {
      _darkMode = isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      iconButtonTheme: IconButtonThemeData(
        style: const ButtonStyle().copyWith(
          padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
    );

    var darkTheme = ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: kDarkColorScheme,
      brightness: Brightness.dark,
      textTheme: GoogleFonts.latoTextTheme(),
      scaffoldBackgroundColor: kDarkColorScheme.background,
    );

    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _darkMode ? ThemeMode.dark : ThemeMode.light,
      home: const MatchingCards(),
    );
  }
}
