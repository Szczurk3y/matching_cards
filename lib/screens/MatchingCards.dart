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
  void refresh() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Matching Cards"),
        actions: [
          IconButton(
            onPressed: refresh,
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              ref.read(cardsStateProvider.notifier).add();
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              ref.read(cardsStateProvider.notifier).remove();
            },
            icon: const Icon(Icons.remove),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: const Center(
        heightFactor: double.infinity,
        child: Game(),
      ),
    );
  }
}
