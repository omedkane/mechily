import 'package:flutter/material.dart';
import 'package:mechily/AppStyle.dart';
import 'package:mechily/Dialogs/Alert.dart';

class Notice extends StatefulWidget {
  final EdgeInsetsGeometry margin;
  final String text;
  final AlertType type;

  const Notice({
    Key key,
    this.margin,
    @required this.text,
    this.type = AlertType.info,
  }) : super(key: key);

  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> with TickerProviderStateMixin {
  final duration = Duration(milliseconds: 300);
  static Map<AlertType, dynamic> _styleMap = {
    AlertType.success: {'bgColor': midori, 'textColor': null},
    AlertType.failure: {'bgColor': shiro, 'textColor': null},
    AlertType.info: {'bgColor': aoi.withOpacity(0.1), 'textColor': aoi},
  };
  @override
  Widget build(BuildContext context) {
    Color bgColor = _styleMap[widget.type]['bgColor'];
    Color textColor = _styleMap[widget.type]['textColor'];
    TextStyleSet textStyleSet =
        textColor != null ? TextStyleSet(textColor) : whiteText;

    return AnimatedContainer(
      duration: duration,
      margin: widget.margin ?? const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.only(top: 16, bottom: 24, left: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: bgColor,
      ),
      child: AnimatedSize(
        vsync: this,
        duration: duration,
        child: Text(
          widget.text,
          style: textStyleSet.szC.regfontH,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
