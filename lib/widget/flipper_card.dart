import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../data/card_data.dart';
import '../widget/parallax_card.dart';

class FlipperCard extends StatefulWidget {
  final List<CardViewModel> cards;
  final Function(double percent) onScroll;

  const FlipperCard({this.cards, this.onScroll});

  @override
  _FlipperCardState createState() => _FlipperCardState();
}

class _FlipperCardState extends State<FlipperCard>
    with SingleTickerProviderStateMixin {
  double scrollPercent = 0.0;
  Offset startDrag;
  double startDragScrollPercent;
  double finishScrollStartPercent;
  double finishScrollEndPercent;
  AnimationController finishScrollController;

  @override
  void initState() {
    super.initState();
    finishScrollController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    )..addListener(() => setState(() {
          scrollPercent = lerpDouble(finishScrollStartPercent,
              finishScrollEndPercent, finishScrollController.value);

          if (widget.onScroll != null) {
            widget.onScroll(scrollPercent);
          }
        }));
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onHorizontalDragStart: _onHorizontalDragStart,
        onHorizontalDragUpdate: _onHorizontalDragUpdate,
        onHorizontalDragEnd: _onHorizontalDragEnd,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: widget.cards
              .asMap()
              .map((index, viewModel) =>
                  MapEntry(index, _buildCard(index, viewModel)))
              .values
              .toList(),
        ),
      );

  @override
  void dispose() {
    finishScrollController.dispose();
    super.dispose();
  }

  Widget _buildCard(int index, CardViewModel viewModel) {
    final count = widget.cards.length;
    final scrollPercentForIndex = scrollPercent / (1 / count);
    final parallax = scrollPercent - index / count;

    return FractionalTranslation(
      translation: Offset(index - scrollPercentForIndex, 0.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Transform(
          transform: _buildCardProjection(scrollPercentForIndex - index),
          child: ParallaxCard(
            parallax: parallax,
            viewModel: viewModel,
          ),
        ),
      ),
    );
  }

  Matrix4 _buildCardProjection(double percent) {
    final perspective = 0.002;
    final radius = 1.0;
    final angle = percent * pi / 8;
    final horizontalTranslation = 0.0;

    Matrix4 projection = Matrix4.identity()
      ..setEntry(0, 0, 1 / radius)
      ..setEntry(1, 1, 1 / radius)
      ..setEntry(3, 2, -perspective)
      ..setEntry(2, 3, -radius)
      ..setEntry(3, 3, perspective * radius + 1.0);

    projection *= Matrix4.translationValues(
            horizontalTranslation + 300.0, 0.0, 0.0) *
        Matrix4.rotationY(angle) *
        Matrix4.translationValues(0.0, 0.0, radius) *
        Matrix4.translationValues(-300.0, 0.0, 0.0);

    return projection;
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    startDrag = details.globalPosition;
    startDragScrollPercent = scrollPercent;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final distance = details.globalPosition.dx - startDrag.dx;
    final percent = distance / context.size.width;

    final count = widget.cards.length;
    setState(() {
      scrollPercent = (startDragScrollPercent - percent / count)
          .clamp(0.0, 1.0 - 1 / count);

      if (widget.onScroll != null) {
        widget.onScroll(scrollPercent);
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final count = widget.cards.length;
    finishScrollStartPercent = scrollPercent;
    finishScrollEndPercent = (scrollPercent * count).round() / count;
    finishScrollController.forward(from: 0.0);

    setState(() {
      startDrag = null;
      startDragScrollPercent = null;
    });
  }
}
