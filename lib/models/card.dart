class Card {
  const Card(this.id);

  String? get front {
    return "assets/card$id.png";
  }

  String? get back {
    return "assets/card_hidden.png";
  }

  final int id;
}
