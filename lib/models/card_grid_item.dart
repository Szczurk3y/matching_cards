import 'package:flutter/material.dart';
import 'package:matching_cards/models/card.dart' as game_card;

class CardGridItem extends StatefulWidget {
  CardGridItem({required int cardId, super.key}) {
    card = game_card.Card(cardId);
  }

  late final game_card.Card card;

  @override
  State<CardGridItem> createState() => _CardGridItemState();
}

class _CardGridItemState extends State<CardGridItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Image.asset(widget.card.imagePath),
      onTap: () {
        setState(() {
          widget.card.show();
        });
      },
    );
  }
}
