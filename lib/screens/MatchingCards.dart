import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matching_cards/providers/cards_provider.dart';
import 'package:matching_cards/widgets/game.dart';
import 'package:matching_cards/widgets/main_drawer.dart';

class MatchingCards extends ConsumerStatefulWidget {
  const MatchingCards({super.key});

  @override
  ConsumerState<MatchingCards> createState() => _MatchingCardsState();
}

class _MatchingCardsState extends ConsumerState<MatchingCards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Matching Cards"),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(cardsStateProvider.notifier).add();
            },
            icon: const Icon(Icons.add),
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
          IconButton(
            onPressed: () {
              ref.read(cardsStateProvider.notifier).remove();
            },
            icon: const Icon(Icons.remove),
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Center(
        heightFactor: double.infinity,
        child: Game(),
      ),
    );
  }
}
