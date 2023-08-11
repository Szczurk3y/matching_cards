import 'package:flutter/material.dart';
import 'package:matching_cards/widgets/game.dart';
import 'package:matching_cards/widgets/main_drawer.dart';

class MatchingCards extends StatefulWidget {
  const MatchingCards({super.key});

  @override
  State<MatchingCards> createState() => _MatchingCardsState();
}

class _MatchingCardsState extends State<MatchingCards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Matching Cards"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.remove),
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Game(),
    );
  }
}
