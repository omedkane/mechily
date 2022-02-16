import 'package:mechily/AppStyle.dart';
import 'package:flutter/material.dart';

class SimpleDot extends StatelessWidget {
  final EdgeInsets padding;
  final Color color;

  const SimpleDot({Key key, this.padding, this.color = oolo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: 8,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
