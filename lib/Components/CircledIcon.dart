import 'package:flutter/material.dart';

enum CircledIconColorStyle { white, light, bold, inverted }
enum CircledIconSize { big, medium, small }

class CircledIcon extends StatelessWidget {
  final Color color;
  final IconData icon;
  final CircledIconSize size;
  final CircledIconColorStyle colorStyle;
  static Map<CircledIconSize, List<double>> sizeMap = {
    CircledIconSize.big: [48, 24],
    CircledIconSize.medium: [40, 24],
    CircledIconSize.small: [28, 18],
  };

  const CircledIcon({
    Key key,
    this.color,
    this.icon,
    this.colorStyle = CircledIconColorStyle.light,
    this.size = CircledIconSize.big,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color boxColor, iconColor;
    Border border;
    double boxSize = sizeMap[size][0], iconSize = sizeMap[size][1];

    switch (colorStyle) {
      case CircledIconColorStyle.light:
        boxColor = color.withOpacity(0.1);
        iconColor = color;
        break;
      case CircledIconColorStyle.white:
        boxColor = Colors.white;
        iconColor = color;
        break;
      case CircledIconColorStyle.inverted:
        boxColor = Colors.white;
        iconColor = color;
        border = Border.all(width: 1, color: color);
        break;
      default:
        boxColor = color;
        iconColor = Colors.white;
        break;
    }

    return Container(
      height: boxSize,
      width: boxSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: boxColor,
        border: border,
      ),
      child: Icon(icon, color: iconColor, size: iconSize),
    );
  }
}
