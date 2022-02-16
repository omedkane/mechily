import 'package:get/get_rx/get_rx.dart';
import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/AnimatedDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

enum AlertType { success, failure, info }

mixin NoticeMixin {
  final RxString notice =
      "Veuillez vous assurer de la sûreté de votre mot de passe, il doît comprendre au moins 8 caractères"
          .obs;
  AlertType noticeType = AlertType.info;

  void setNotice([String message, AlertType type = AlertType.info]) {
    noticeType = type;
    notice.value = message;
  }
}

class Alert extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Color color;
  final String text;
  final TextStyle textStyle;
  static Map<AlertType, Map<String, dynamic>> _styleMap = {
    AlertType.success: {'icon': MaterialCommunityIcons.check, 'color': midori},
    AlertType.failure: {
      'icon': MaterialCommunityIcons.exclamation,
      'color': shiro
    },
    AlertType.info: {
      'icon': MaterialCommunityIcons.information_variant,
      'color': aoi
    },
  };

  const Alert({
    Key key,
    this.icon,
    this.text,
    this.color,
    this.iconSize = 32,
    this.textStyle,
  }) : super(key: key);

  static void alert(
    String message, {
    AlertType type = AlertType.success,
    double widthFactor,
    void Function() onExit,
  }) async {
    Map<String, dynamic> style = _styleMap[type];
    await AnimatedDialog.show(
        child: Alert(
          icon: style['icon'],
          color: style['color'],
          text: message,
        ),
        widthFactor: 0.65);
    onExit?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(
              icon ?? MaterialCommunityIcons.exclamation,
              color: color,
              size: iconSize,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Text(
              text,
              style: textStyle ?? TextStyleSet(color).szC.regfontH,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
