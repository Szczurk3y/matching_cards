import 'package:flutter/material.dart';
import 'package:matching_cards/models/card.dart' as game_card;

class CardGridItem extends StatelessWidget {
  CardGridItem({required int cardId, super.key}) {
    card = game_card.Card(cardId);
  }

  late game_card.Card card;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Image.asset(card.back),
      // onTap: onCardTap(card.id),
    );
  }
}
