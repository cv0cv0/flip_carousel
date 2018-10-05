import 'package:flutter/material.dart';

class ScrollIndicator extends StatelessWidget {
  final int count;
  final double percent;

  const ScrollIndicator({this.count, this.percent});

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: ScrollIndicatorPainter(
          count: count,
          percent: percent,
        ),
        child: Container(),
      );
}

class ScrollIndicatorPainter extends CustomPainter {
  final int count;
  final double percent;

  final Paint trackPaint;
  final Paint thumbPaint;

  ScrollIndicatorPainter({this.count, this.percent})
      : trackPaint = Paint()..color = const Color(0xff444444),
        thumbPaint = Paint()..color = Colors.white;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          Radius.circular(3.0),
        ),
        trackPaint);

    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
              size.width * percent, 0.0, size.width / count, size.height),
          Radius.circular(3.0),
        ),
        thumbPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
