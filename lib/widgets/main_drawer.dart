import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  var darkTheme = false;

  @override
  Widget build(BuildContext context) {
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
                Icons.sunny,
                color: darkTheme ? Colors.black87 : Colors.amber,
              ),
              const SizedBox(width: 10),
              Text(
                "Dark Mode",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(width: 10),
              Switch(
                value: darkTheme,
                onChanged: (value) {
                  setState(() {
                    darkTheme = !darkTheme;
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
