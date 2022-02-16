import 'package:mechily/AppStyle.dart';
import 'package:flutter/material.dart';

class RoundedTitle extends StatelessWidget {
  final String daTitle;
  final Color bgColor;
  final TextStyleSet textColorWeight;
  final Widget pairedWidget;
  final bool rightAligned;
  final double daRadius;
  final Widget daWidget;
  final EdgeInsetsGeometry padding;

  const RoundedTitle(
      {Key key,
      this.daTitle,
      this.bgColor,
      this.pairedWidget,
      this.textColorWeight,
      this.daRadius = 16.0,
      this.rightAligned = false,
      this.daWidget,
      this.padding})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (pairedWidget != null && rightAligned) pairedWidget,
        if (pairedWidget == null && rightAligned) SizedBox(),
        Container(
          padding:
              padding ?? EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
              // boxShadow: gshaded,
              color: bgColor ?? Colors.white,
              borderRadius: rightAligned
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(daRadius),
                      topRight: Radius.circular(daRadius))
                  : BorderRadius.only(
                      bottomRight: Radius.circular(daRadius),
                      topLeft: Radius.circular(daRadius))),
          child: (daWidget != null)
              ? daWidget
              : Text(daTitle,
                  style: (textColorWeight ?? whiteText).szC.medfont),
        ),
        if (pairedWidget != null && !rightAligned) pairedWidget
      ],
    );
  }
}
