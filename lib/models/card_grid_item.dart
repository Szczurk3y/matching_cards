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
  var isDisplayed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Image.asset(isDisplayed ? widget.card.front : widget.card.back),
      onTap: () {
        setState(() {
          isDisplayed = true;
        });
      },
    );
  }
}
