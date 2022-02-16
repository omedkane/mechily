import 'package:flutter/material.dart';
import 'package:mechily/AppStyle.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Color color;
  final Color textColor;
  final double height;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final void Function() onTap;

  const MyButton({
    Key key,
    this.title,
    this.color = aoi,
    this.textColor,
    this.onTap,
    this.margin,
    this.padding,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyleSet textStyleSet =
        textColor != null ? TextStyleSet(color) : whiteText;
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.hardEdge,
      elevation: 1,
      shadowColor: Colors.white54,
      child: InkWell(
        splashColor: Colors.white70,
        onTap: onTap,
        child: Container(
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Text(
            title,
            style: textStyleSet.szC.medfont,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
