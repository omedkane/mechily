import 'package:mechily/AppStyle.dart';
import 'package:flutter/material.dart';

enum SettingTileStyle { colored, inverted }

class SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget extraWidget;
  final void Function() onTap;
  final bool colorInverted;
  final bool isDisabled;
  final void Function() onDisabledTap;

  const SettingTile({
    Key key,
    this.icon,
    this.title,
    this.subtitle,
    this.onTap,
    this.extraWidget,
    this.colorInverted = false,
    this.isDisabled = false,
    this.onDisabledTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color __color = isDisabled ? Colors.grey.shade600 : shiro;
    TextStyle __textStyle = TextStyleSet(__color).szC.medfont;
    return InkWell(
      onTap: isDisabled ? onDisabledTap : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              margin: const EdgeInsets.only(right: 16),
              decoration: colorInverted
                  ? BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: __color),
                    )
                  : BoxDecoration(
                      color: __color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
              child: Icon(
                icon,
                color: __color,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: __textStyle),
                  const SizedBox(height: 4),
                  Text(subtitle, style: blackText.szA.regfontH),
                ],
              ),
            ),
            if (extraWidget != null) extraWidget,
          ],
        ),
      ),
    );
  }
}
