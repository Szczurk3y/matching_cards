import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matching_cards/models/card.dart';

enum CardsQuantityState { four, six, eight, twelf, eighteen, refresh }

enum CardState { hidden, shown }

extension CardsStateExtension on CardsQuantityState {
  int get number {
    return switch (this) {
      CardsQuantityState.four => 4,
      CardsQuantityState.six => 6,
      CardsQuantityState.eight => 8,
      CardsQuantityState.twelf => 12,
      CardsQuantityState.eighteen => 18,
      CardsQuantityState.refresh => 0,
    };
  }
}

class _CardsStateProvider {
  const _CardsStateProvider({required this.cardsQuantityState, required this.shuffledCards});

  final CardsQuantityState cardsQuantityState;
  final List<Card> shuffledCards;
}

class CardsQuantityNotifier extends StateNotifier<CardsQuantityState> {
  CardsQuantityNotifier() : super(CardsQuantityState.four);

  void add() {
    if (state == CardsQuantityState.values.last) return;
    state = CardsQuantityState.values.elementAt(CardsQuantityState.values.indexOf(state) + 1);
  }

  void remove() {
    if (state == CardsQuantityState.values.first) return;
    state = CardsQuantityState.values.elementAt(CardsQuantityState.values.indexOf(state) - 1);
  }

  void refresh() {
    var oldState = state;
    state = CardsQuantityState.refresh;
    state = oldState;
  }
}

final cardsQuantityStateProvider = StateNotifierProvider<CardsQuantityNotifier, CardsQuantityState>(
  (ref) => CardsQuantityNotifier(),
);

final shuffledCardsProvider = Provider<_CardsStateProvider>((ref) {
  final cardsQuantityState = ref.watch(cardsQuantityStateProvider);
  List<Card> cardsSet = [
    for (var id = 1; id <= cardsQuantityState.number / 2; id++) Card(id),
  ];
  var shuffledCards = cardsSet + List.of(cardsSet);
  shuffledCards.shuffle();
  return _CardsStateProvider(cardsQuantityState: cardsQuantityState, shuffledCards: shuffledCards);
});
