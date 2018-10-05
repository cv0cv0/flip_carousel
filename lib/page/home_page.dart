import 'package:flutter/material.dart';

import '../widget/flipper_card.dart';
import '../data/card_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          left: false,
          right: false,
          child: Column(
            children: <Widget>[
              Expanded(
                child: FlipperCard(cards),
              ),
              Container(
                width: double.infinity,
                height: 50.0,
                color: Colors.grey,
              )
            ],
          ),
        ),
      );
}
