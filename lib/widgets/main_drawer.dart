import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:matching_cards/main.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  late var isDarkMode;

  @override
  Widget build(BuildContext context) {
    isDarkMode = App.of(context).darkMode;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withOpacity(0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Image.asset(
                  "assets/icon.png",
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  'Matching Cards',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              Icon(
                isDarkMode ? Icons.nightlight_round_outlined : Icons.sunny,
                color: isDarkMode ? Colors.white60 : Colors.amber,
              ),
              const SizedBox(width: 10),
              Text(
                "Dark Mode",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
              ),
              const SizedBox(width: 10),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = !isDarkMode;
                    App.of(context).setDarkMode(isDarkMode);
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
