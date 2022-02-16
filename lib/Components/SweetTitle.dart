import 'package:mechily/AppStyle.dart';
import 'package:flutter/material.dart';
import 'package:mechily/Misc/enums.dart';

class SweetTitle extends StatelessWidget {
  final String text;
  final Color primaryColor;
  final IconData iconData;
  final bool withIcon;
  final bool boldColor;
  final EdgeInsets padding;
  final Sizes size;
  final TextAlign textAlign;
  final EdgeInsets margin;
  final double borderRadius;
  static Map<Sizes, Map> _sizeToStyle = {
    Sizes.normal: {
      'padding': const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      'textStyle': whiteText.szC.medfont,
      'borderRadius': 16.0,
    },
    Sizes.small: {
      'padding': const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      'textStyle': whiteText.szB.medfont,
      'borderRadius': 8.0,
    },
  };

  const SweetTitle({
    Key key,
    this.text,
    this.primaryColor = shiro,
    this.iconData,
    this.boldColor = false,
    this.padding,
    this.size = Sizes.small,
    this.textAlign = TextAlign.start,
    this.margin,
    this.borderRadius,
  })  : withIcon = iconData != null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bgColor = boldColor ? primaryColor : primaryColor.withOpacity(0.1);
    Color iconColor = boldColor ? Colors.white : primaryColor;
    TextStyleSet __textStyleSet = (boldColor
        ? _sizeToStyle[size]['textStyle']
        : TextStyleSet(primaryColor));

    EdgeInsets __padding = padding ?? _sizeToStyle[size]['padding'];
    double __borderRadius = borderRadius ?? _sizeToStyle[size]['borderRadius'];

    Widget textWidget = Text(
      text,
      style: (__textStyleSet).szC.medfont,
      textAlign: textAlign,
    );
    return Container(
      padding: __padding,
      margin: margin,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(__borderRadius),
      ),
      child: withIcon
          ? Row(
              children: [
                Icon(
                  iconData,
                  color: iconColor,
                ),
                textWidget
              ],
            )
          : textWidget,
    );
  }
}
