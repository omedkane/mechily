import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/CircledIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class QuickOption extends StatelessWidget {
  final Color color;
  final String title;
  final Function onIconTap;
  final IconData icon;
  final bool iconToLeft;
  final bool smallSized;
  final TextStyle textStyle;
  final bool isDisabled;
  final EdgeInsetsGeometry margin;

  const QuickOption({
    Key key,
    this.color,
    this.title,
    this.onIconTap,
    this.icon,
    this.iconToLeft = false,
    this.smallSized = true,
    this.textStyle,
    this.isDisabled = false,
    this.margin,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List sizeMap = CircledIcon
        .sizeMap[smallSized ? CircledIconSize.small : CircledIconSize.medium];
    TextStyleSet primaryTextStyleSet = TextStyleSet(color);
    List<Widget> widgets = [
      Text(
        title,
        style: textStyle ??
            (smallSized
                ? primaryTextStyleSet.szB.semfont
                : primaryTextStyleSet.szB.medfont),
      ),
      if (!isDisabled)
        GestureDetector(
          onTap: onIconTap,
          child: Container(
            height: sizeMap[0],
            width: sizeMap[0],
            margin: iconToLeft
                ? const EdgeInsets.only(right: 8)
                : const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              icon ?? MaterialCommunityIcons.close,
              color: color,
              size: sizeMap[1],
            ),
          ),
        )
    ];
    List widgetToDisplay = iconToLeft ? widgets.reversed.toList() : widgets;
    return Container(
      margin: margin,
      padding: isDisabled
          ? const EdgeInsets.symmetric(vertical: 12, horizontal: 12)
          : const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color.withOpacity(0.1),
        // boxShadow: gshaded,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: widgetToDisplay,
      ),
    );
  }
}
