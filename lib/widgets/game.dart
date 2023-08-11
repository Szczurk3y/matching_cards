import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matching_cards/models/card_grid_item.dart';
import 'package:matching_cards/providers/cards_provider.dart';

class Game extends ConsumerStatefulWidget {
  const Game({super.key});

  @override
  ConsumerState<Game> createState() => _GameState();
}

class _GameState extends ConsumerState<Game> {
  @override
  Widget build(BuildContext context) {
    final shuffledCards = ref.watch(shuffledCardsProvider);
    final int columns = shuffledCards.length <= 8 ? shuffledCards.length ~/ 2 : 4;
    return GridView(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: 5 / 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      children: shuffledCards
          .map(
            (card) => CardGridItem(),
          )
          .toList(),
    );
  }
}
