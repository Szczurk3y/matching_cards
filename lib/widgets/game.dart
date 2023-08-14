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
    final cardsState = ref.watch(shuffledCardsProvider);
    final shuffledCards = cardsState.shuffledCards.map((card) => CardGridItem(cardId: card.id)).toList();
    final int columns = shuffledCards.length <= 8 ? 2 : 3;
    final double aspectRatio = switch (cardsState.state) {
      CardsState.eight => 1.2,
      CardsState.twelf => 0.8,
      CardsState.sixteen => 1.2,
      CardsState.eighteen => 1.2,
      _ => 1.0 // default
    };

    const double spacing = 20;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          childAspectRatio: aspectRatio,
          mainAxisSpacing: spacing,
        ),
        children: shuffledCards,
      ),
    );
  }
}
