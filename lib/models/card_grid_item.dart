import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matching_cards/models/card.dart' as game_card;
import 'package:matching_cards/providers/cards_provider.dart';

class CardGridItem extends ConsumerStatefulWidget {
  const CardGridItem({required this.card, super.key});

  final game_card.Card card;

  @override
  ConsumerState<CardGridItem> createState() => _CardGridItemState();
}

class _CardGridItemState extends ConsumerState<CardGridItem> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  var isCardNew = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      precacheImage(widget.card.front.image, context);
      precacheImage(widget.card.back.image, context);
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        _animationController.reset();
        setState(() {
          isCardNew = false;
        });
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  Future flipCard(Future<bool> result) async {
    var cardShowingResult = await result;
    if (cardShowingResult) {
      _animationController.addListener(() {
        if (_animationController.isCompleted) {
          _animationController.reset();
        }
      });
      await _animationController.forward().then(
            (value) => widget.card.show(),
          );
    }
  }

  bool isBackImage(double angle) {
    const degrees90 = pi / 2;
    return angle <= degrees90;
  }

  Widget cardBackFlipAnimation(double angle) {
    return isBackImage(angle.abs())
        ? widget.card.back
        : Transform(
            transform: Matrix4.identity()..rotateY(pi),
            alignment: Alignment.center,
            child: widget.card.front,
          );
  }

  @override
  Widget build(BuildContext context) {
    var cardsState = ref.read(cardsProvider.notifier);

    final cardFlipTransition = InkWell(
      onTap: () {
        flipCard(cardsState.shouldShow(widget.card));
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          final angle = _animationController.value * -pi;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle);

          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child: widget.card.visibility == CardVisibility.hidden ? cardBackFlipAnimation(angle) : widget.card.front,
          );
        },
      ),
    );

    var cardSlideInTransition = SlideTransition(
      position: Tween(
        begin: const Offset(0, 0.3),
        end: const Offset(0, 0),
      ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
      ),
      child: widget.card.back,
    );

    return isCardNew ? cardSlideInTransition : cardFlipTransition;
  }
}
