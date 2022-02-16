import 'package:mechily/AppStyle.dart';
import 'package:flutter/material.dart';

class DripPainter extends CustomPainter {
  final Color daColor;

  DripPainter({this.daColor = oolo});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = daColor;
    path = Path();
    path.lineTo(0, size.height * 0.42);
    path.cubicTo(0, size.height * 0.42, size.width * 0.19, size.height * 0.42,
        size.width * 0.19, size.height * 0.67);
    path.cubicTo(size.width * 0.19, size.height * 0.93, size.width * 0.42,
        size.height * 1.26, size.width * 0.45, size.height * 0.67);
    path.cubicTo(size.width * 0.49, size.height * 0.08, size.width * 0.73,
        size.height * 0.7, size.width * 0.8, size.height * 0.42);
    path.cubicTo(
        size.width * 0.86, size.height * 0.13, size.width, 0, size.width, 0);
    path.cubicTo(size.width, 0, 0, size.height * 0.42, 0, size.height * 0.42);
    path.cubicTo(
        0, size.height * 0.42, 0, size.height * 0.42, 0, size.height * 0.42);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
