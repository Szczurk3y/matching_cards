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
    final int columns = shuffledCards.length <= 8 ? 2 : 3;
    final double aspectRatio = shuffledCards.length <= 6
        ? 1.0
        : shuffledCards.length <= 8
            ? 1.2
            : shuffledCards.length <= 12
                ? 0.8
                : shuffledCards.length <= 14
                    ? 1
                    : 1.2;
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
        children: shuffledCards
            .map(
              (card) => CardGridItem(cardId: card.id),
            )
            .toList(),
      ),
    );
  }
}
