import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matching_cards/models/card.dart';

const _minCards = 2;
const _maxCards = 8;

class CardsNotifier extends StateNotifier<List<Card>> {
  CardsNotifier() : super(const [Card(1), Card(2)]);

  void add() {
    if (state.length < _maxCards) {
      final nextCardId = state.length + 1;
      state = [
        ...state,
        Card(nextCardId),
      ];
    }
  }

  void remove() {
    if (state.length > _minCards) {
      final newState = List.of(state);
      newState.removeLast();
      state = newState;
    }
  }
}

final cardsProvider = StateNotifierProvider<CardsNotifier, List<Card>>(
  (ref) => CardsNotifier(),
);

final shuffledCardsProvider = Provider((ref) {
  final cards = ref.watch(cardsProvider);
  var shuffledSet = List.of(cards + cards);
  shuffledSet.shuffle();
  return shuffledSet;
});
