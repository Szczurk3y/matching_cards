import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matching_cards/models/card.dart';

enum CardsQuantityState { four, six, eight, twelf, eighteen }

enum CardState { hidden, shown }

extension CardsStateExtension on CardsQuantityState {
  int get number {
    return switch (this) {
      CardsQuantityState.four => 4,
      CardsQuantityState.six => 6,
      CardsQuantityState.eight => 8,
      CardsQuantityState.twelf => 12,
      CardsQuantityState.eighteen => 18,
    };
  }
}

class _CardsStateProvider {
  const _CardsStateProvider({required this.cardsQuantityState, required this.shuffledCards});

  final CardsQuantityState cardsQuantityState;
  final List<Card> shuffledCards;
}

class CardsNotifier extends StateNotifier<CardsQuantityState> {
  CardsNotifier() : super(CardsQuantityState.four);

  void add() {
    if (state == CardsQuantityState.values.last) return;
    state = CardsQuantityState.values.elementAt(CardsQuantityState.values.indexOf(state) + 1);
  }

  void remove() {
    if (state == CardsQuantityState.values.first) return;
    state = CardsQuantityState.values.elementAt(CardsQuantityState.values.indexOf(state) - 1);
  }
}

final cardsStateProvider = StateNotifierProvider<CardsNotifier, CardsQuantityState>(
  (ref) => CardsNotifier(),
);

final shuffledCardsProvider = Provider<_CardsStateProvider>((ref) {
  final cardsState = ref.watch(cardsStateProvider);
  List<Card> cardsSet = [
    for (var id = 1; id <= cardsState.number / 2; id++) Card(id),
  ];
  var shuffledCards = cardsSet + List.of(cardsSet);
  shuffledCards.shuffle();
  return _CardsStateProvider(cardsQuantityState: cardsState, shuffledCards: shuffledCards);
});
