import 'package:matching_cards/providers/cards_provider.dart';

class Card {
  Card(this.id);

  final int id;
  CardState _state = CardState.hidden;
  CardState get state => _state;

  String get imagePath {
    return switch (state) {
      CardState.hidden => _back,
      CardState.shown => _front,
    };
  }

  String get _front {
    return "assets/card$id.png";
  }

  String get _back {
    return "assets/card_hidden.png";
  }

  void show() {
    _state = CardState.shown;
  }

  void hide() {
    _state = CardState.hidden;
  }
}
