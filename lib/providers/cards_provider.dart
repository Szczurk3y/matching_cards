import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matching_cards/models/card.dart';

enum CardsState { four, six, eight, twelf, sixteen, eighteen }

extension CardsStateExtension on CardsState {
  int get number {
    return switch (this) {
      CardsState.four => 4,
      CardsState.six => 6,
      CardsState.eight => 8,
      CardsState.twelf => 12,
      CardsState.sixteen => 16,
      CardsState.eighteen => 18,
    };
  }
}

class CardsNotifier extends StateNotifier<CardsState> {
  CardsNotifier() : super(CardsState.four);

  void add() {
    if (state == CardsState.values.last) return;
    state = CardsState.values.elementAt(CardsState.values.indexOf(state) + 1);
  }

  void remove() {
    if (state == CardsState.values.first) return;
    state = CardsState.values.elementAt(CardsState.values.indexOf(state) - 1);
  }
}

final cardsStateProvider = StateNotifierProvider<CardsNotifier, CardsState>(
  (ref) => CardsNotifier(),
);

final shuffledCardsProvider = Provider((ref) {
  final cardsState = ref.watch(cardsStateProvider);
  List<Card> shuffledCards = [for (var id = 1; id <= cardsState.number; id++) Card(id)];
  shuffledCards.shuffle();
  return shuffledCards;
});
