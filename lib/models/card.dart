import 'package:matching_cards/providers/cards_provider.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Card {
  Card(this.imageId);

  final int imageId;
  final String id = uuid.v4();
  CardState _state = CardState.hidden;
  CardState get state => _state;
  var hasFoundMatch = false;

  String get imagePath {
    return switch (state) {
      CardState.hidden => _back,
      CardState.shown => _front,
    };
  }

  String get _front {
    return "assets/card$imageId.png";
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

  static final empty = Card(-1);
}
