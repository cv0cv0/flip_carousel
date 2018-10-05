import 'package:flutter/material.dart';

import 'scroll_indicator.dart';

class IndicatorBar extends StatelessWidget {
  final int count;
  final double percent;

  const IndicatorBar({this.count, this.percent});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          children: <Widget>[
            Expanded(child: Icon(Icons.settings)),
            Expanded(
              child: Container(
                height: 5.0,
                child: ScrollIndicator(
                  count: count,
                  percent: percent,
                ),
              ),
            ),
            Expanded(child: Icon(Icons.add))
          ],
        ),
      );
}
