import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matching_cards/models/card.dart' as game_card;
import 'package:matching_cards/providers/cards_provider.dart';

class CardGridItem extends ConsumerStatefulWidget {
  const CardGridItem({required this.card, super.key});

  final game_card.Card card;

  @override
  ConsumerState<CardGridItem> createState() => _CardGridItemState();
}

class _CardGridItemState extends ConsumerState<CardGridItem> {
  @override
  Widget build(BuildContext context) {
    var cardsState = ref.read(cardsProvider.notifier);
    return InkWell(
      child: Image.asset(widget.card.imagePath),
      onTap: () {
        cardsState.show(widget.card);
      },
    );
  }
}
