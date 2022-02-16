import 'package:flutter/material.dart';
import 'package:mechily/AppStyle.dart';
import 'package:mechily/Dialogs/Alert.dart';

class SimpleNotice extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final String text;
  final AlertType type;
  final Color backgroundColor, textColor;

  const SimpleNotice({
    Key key,
    this.margin,
    @required this.text,
    this.type = AlertType.info,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyleSet textStyleSet =
        textColor != null ? TextStyleSet(textColor) : aoiText;

    return Container(
      margin: margin ?? const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.only(top: 16, bottom: 24, left: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: backgroundColor ?? aoi.withOpacity(0.1),
      ),
      child: Text(
        text,
        style: textStyleSet.szC.regfontH,
        textAlign: TextAlign.center,
      ),
    );
  }
}
