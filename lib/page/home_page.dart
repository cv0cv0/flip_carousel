import 'package:flutter/material.dart';

import '../data/card_data.dart';
import '../widget/flipper_card.dart';
import '../widget/indicator_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double scrollPercent = 0.0;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          left: false,
          right: false,
          child: Column(
            children: <Widget>[
              Expanded(
                child: FlipperCard(
                  cards: cards,
                  onScroll: (percent) {
                    setState(() => scrollPercent = percent);
                  },
                ),
              ),
              IndicatorBar(
                count: cards.length,
                percent: scrollPercent,
              )
            ],
          ),
        ),
      );
}
