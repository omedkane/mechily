import 'package:mechily/AppStyle.dart';
import 'package:flutter/material.dart';

class RadiusButton extends StatelessWidget {
  final Color daColor;
  final String title;
  final Function onTap;
  final TextStyle daTextStyle;
  final bool rightAligned;
  final double daRadius;
  final Widget child;
  final EdgeInsetsGeometry padding;

  const RadiusButton(
      {Key key,
      this.daColor,
      this.title,
      this.onTap,
      this.daTextStyle,
      this.rightAligned = false,
      this.daRadius = 16.0,
      this.child,
      this.padding})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Material(
        color: onTap == null ? Colors.grey[400] : daColor,
        clipBehavior: Clip.hardEdge,
        borderRadius: rightAligned
            ? BorderRadius.only(
                bottomLeft: Radius.circular(daRadius),
                topRight: Radius.circular(daRadius))
            : BorderRadius.only(
                bottomRight: Radius.circular(daRadius),
                topLeft: Radius.circular(daRadius)),
        child: InkWell(
          splashColor: Colors.white,
          onTap: onTap,
          child: Container(
            padding:
                padding ?? EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: child ??
                Text(
                  title,
                  style: daTextStyle ?? whiteText.szB.medfont,
                ),
          ),
        ),
      ),
    );
  }
}
