import 'package:flutter/material.dart';

import '../data/card_data.dart';

class ParallaxCard extends StatelessWidget {
  final double parallax;
  final CardViewModel viewModel;

  const ParallaxCard({this.parallax = 0.0, this.viewModel});

  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FractionalTranslation(
              translation: Offset(parallax * 2.0, 0.0),
              child: OverflowBox(
                maxWidth: double.infinity,
                child: Image.asset(
                  viewModel.backdropAssetPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                viewModel.address,
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Petita',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${viewModel.minHeightInFeet} - ${viewModel.maxHeightInFeet}',
                      style: TextStyle(
                        fontSize: 140.0,
                        fontFamily: 'Petita',
                        letterSpacing: -5.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 30.0),
                      child: Text(
                        'FT',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: 'Petita',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.wb_sunny),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        '${viewModel.tempInDegrees}°',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Petita',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 50.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    viewModel.weatherType,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Petita',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.wb_cloudy),
                  ),
                  Text(
                    '${viewModel.windSpeedInMph}mph ${viewModel.cardinalDirection}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Petita',
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
}
