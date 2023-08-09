import 'package:flutter/material.dart';

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
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
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
    );
  }
}
