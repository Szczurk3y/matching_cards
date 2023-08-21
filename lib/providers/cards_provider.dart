import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matching_cards/models/card.dart';

enum CardsQuantity { four, six, eight, twelf, eighteen }

enum DisplayedCardsResult { same, different }

enum CardVisibility { hidden, shown }

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
  _CardsState({required this.cardsQuantity}) {
    _cards = _createCardsSet();
  }

  _CardsState.fromState(_CardsState cardsState) {
    _cards = cardsState._cards;
    _shuffled = cardsState._shuffled;
    cardsQuantity = cardsState.cardsQuantity;
  }

  late final CardsQuantity cardsQuantity;
  var _shuffled = false;
  late final List<Card> _cards;
  List<Card> get shuffledCards {
    if (!_shuffled) {
      _cards.shuffle();
      _shuffled = true;
    }
    return _cards;
  }

  List<Card> _createCardsSet() => [
        for (var id = 1; id <= cardsQuantity.number / 2; id++) Card(id),
        for (var id = 1; id <= cardsQuantity.number / 2; id++) Card(id),
      ];
}

class CardsNotifier extends StateNotifier<_CardsState> {
  CardsNotifier() : super(_CardsState(cardsQuantity: CardsQuantity.four));

  var lastShownCard = Card.empty;
  var shouldNextCardWait = false;

  void add() {
    if (state.cardsQuantity == CardsQuantity.values.last) return;
    final newCardsQuantity = CardsQuantity.values.elementAt(CardsQuantity.values.indexOf(state.cardsQuantity) + 1);
    state = _CardsState(cardsQuantity: newCardsQuantity);
    shouldNextCardWait = false;
  }

  void remove() {
    if (state.cardsQuantity == CardsQuantity.values.first) return;
    final newCardsQuantity = CardsQuantity.values.elementAt(CardsQuantity.values.indexOf(state.cardsQuantity) - 1);
    state = _CardsState(cardsQuantity: newCardsQuantity);
    shouldNextCardWait = false;
  }

  void refresh() {
    var cardsQuantity = state.cardsQuantity;
    var newState = _CardsState(cardsQuantity: cardsQuantity);
    lastShownCard = Card.empty;
    state = newState;
    shouldNextCardWait = false;
  }

  /* 
    this function handles displaying cards to a user.
    returns true if card was shown to a user and false otherwise.
  */
  Future<bool> shouldShow(Card currentCard) async {
    // if user taps already displayed card or they should wait for the two different cards to hide - we do nothing.
    if (currentCard.hasFoundMatch || shouldNextCardWait) return false;

    // if no cards are displayed we show the clicked card and updates it as the last shown card.
    if (lastShownCard == Card.empty) {
      lastShownCard = currentCard;
      return true;
    }
    /* 
      Below code executes if two cards are displayed to a user. 
      It compares two cards and check them whether they are the same or different.
    */
    DisplayedCardsResult? result;
    if (lastShownCard.imageId == currentCard.imageId && lastShownCard.id != currentCard.id) {
      result = DisplayedCardsResult.same;
    } else if (lastShownCard.imageId != currentCard.imageId && lastShownCard != Card.empty) {
      result = DisplayedCardsResult.different;
    }
    switch (result!) {
      case DisplayedCardsResult.same:
        {
          state._cards.where((c) => c.imageId == currentCard.imageId).forEach((c) {
            c.hasFoundMatch = true;
          });
          lastShownCard = Card.empty;
          state = _CardsState.fromState(state);
        }
      case DisplayedCardsResult.different:
        {
          shouldNextCardWait = true;
          Future.delayed(const Duration(seconds: 1)).then((value) {
            state._cards.elementAt(state._cards.indexOf(lastShownCard)).hide();
            state._cards.elementAt(state._cards.indexOf(currentCard)).hide();
            lastShownCard = Card.empty;
            state = _CardsState.fromState(state);
            shouldNextCardWait = false;
          });
        }
    }
    return true;
  }
}

final cardsProvider = StateNotifierProvider<CardsNotifier, _CardsState>(
  (ref) => CardsNotifier(),
);

final cardsStateProvider = Provider<_CardsState>((ref) {
  return ref.watch(cardsProvider);
});
