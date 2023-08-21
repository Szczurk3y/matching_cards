import 'package:flutter/widgets.dart';
import 'package:matching_cards/providers/cards_provider.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Card {
  Card(this.imageId);

  final int imageId;
  final String id = uuid.v4();
  late final Image front = Image.asset(_front);
  late final Image back = Image.asset(_back);

  CardVisibility _visibility = CardVisibility.hidden;
  CardVisibility get visibility => _visibility;
  var hasFoundMatch = false;

  String get _front {
    return "assets/card$imageId.png";
  }

  String get _back {
    return "assets/card_hidden.png";
  }

  void show() {
    _visibility = CardVisibility.shown;
  }

  void hide() {
    _visibility = CardVisibility.hidden;
  }

  static final empty = Card(-1);
}
