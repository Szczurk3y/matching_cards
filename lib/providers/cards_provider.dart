import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matching_cards/models/card.dart';

enum CardsQuantity { four, six, eight, twelf, eighteen }

enum CardState { hidden, shown }

extension CardsStateExtension on CardsQuantity {
  int get number {
    return switch (this) {
      CardsQuantity.four => 4,
      CardsQuantity.six => 6,
      CardsQuantity.eight => 8,
      CardsQuantity.twelf => 12,
      CardsQuantity.eighteen => 18
    };
  }
}

class _CardsState {
  _CardsState({required this.cardsQuantity});

  final CardsQuantity cardsQuantity;
  late final List<Card> _cards = _createCardsSet();
  List<Card> get shuffledCards {
    var cardsSet = _cards + _cards;
    cardsSet.shuffle();
    return cardsSet;
  }

  List<Card> _createCardsSet() => [
        for (var id = 1; id <= cardsQuantity.number / 2; id++) Card(id),
      ];
}

class CardsNotifier extends StateNotifier<_CardsState> {
  CardsNotifier() : super(_CardsState(cardsQuantity: CardsQuantity.four));

  void add() {
    if (state.cardsQuantity == CardsQuantity.values.last) return;
    final newCardsQuantity = CardsQuantity.values.elementAt(CardsQuantity.values.indexOf(state.cardsQuantity) + 1);
    state = _CardsState(cardsQuantity: newCardsQuantity);
  }

  void remove() {
    if (state.cardsQuantity == CardsQuantity.values.first) return;
    final newCardsQuantity = CardsQuantity.values.elementAt(CardsQuantity.values.indexOf(state.cardsQuantity) - 1);
    state = _CardsState(cardsQuantity: newCardsQuantity);
  }

  void refresh() {
    var cardsQuantity = state.cardsQuantity;
    var newState = _CardsState(cardsQuantity: cardsQuantity);
    newState._cards.forEach((element) {
      element.hide();
    });
    state = newState;
  }
}

final cardsProvider = StateNotifierProvider<CardsNotifier, _CardsState>(
  (ref) => CardsNotifier(),
);

final cardsStateProvider = Provider<_CardsState>((ref) {
  return ref.watch(cardsProvider);
});
