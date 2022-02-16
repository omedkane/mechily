import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/QuickOption.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  final Color color;
  final EdgeInsetsDirectional margin;

  const ScreenTitle({Key key, this.title, this.color = shiro, this.margin})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TextStyleSet __textStyleSet =
        color != null ? TextStyleSet(color) : shiroText;
    return QuickOption(
      color: color,
      margin: margin,
      icon: MaterialCommunityIcons.chevron_left,
      title: title,
      iconToLeft: true,
      smallSized: false,
      textStyle: __textStyleSet.szC.regfont,
      onIconTap: () {
        Get.back();
      },
    );
  }
}
