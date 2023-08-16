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
    final cardsState = ref.watch(cardsStateProvider);
    final shuffledCards = cardsState.shuffledCards
        .map(
          (card) => CardGridItem(card: card),
        )
        .toList();
    // final int columns = shuffledCards.length <= 8 ? 2 : 3;
    final int columns = switch (cardsState.cardsQuantity) {
      CardsQuantity.twelf => 3,
      CardsQuantity.eighteen => 3,
      _ => 2,
    };
    final double aspectRatio = switch (cardsState.cardsQuantity) {
      CardsQuantity.eight => 1.2,
      CardsQuantity.twelf => 0.8,
      CardsQuantity.eighteen => 1.2,
      _ => 1.0
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
