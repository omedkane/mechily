import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/AnimatedDialog.dart';
import 'package:mechily/Components/RadiusButton.dart';
import 'package:mechily/Components/RoundedTitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class YesNoDialog extends StatelessWidget {
  final void Function() onYes, onNo;
  final String title;
  final String message;
  final Color color;
  final String notice;

  const YesNoDialog({
    Key key,
    this.onYes,
    this.onNo,
    this.title,
    this.message,
    this.color,
    this.notice,
  }) : super(key: key);

  static alert({
    title,
    message,
    color = shiro,
    onYes,
    onNo,
    notice,
  }) async {
    await AnimatedDialog.show(
      child: YesNoDialog(
        color: color,
        message: message,
        title: title,
        onYes: onYes,
        onNo: onNo,
        notice: notice,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyleSet textStyleSet = TextStyleSet(color);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RoundedTitle(
          daTitle: title,
          bgColor: color,
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: blackText.szC.regfont.apply(heightDelta: 0.6),
              ),
              if (notice != null) ...[
                const SizedBox(height: 16),
                Text(
                  notice,
                  style: textStyleSet.szC.regfontH,
                )
              ],
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              child: Icon(MaterialCommunityIcons.close, color: color),
              onTap: () {
                Navigator.of(context).pop();
                onNo?.call();
              },
            ),
            const SizedBox(width: 16),
            RadiusButton(
              child: Icon(MaterialCommunityIcons.check, color: Colors.white),
              onTap: () {
                Navigator.of(context).pop();
                onYes?.call();
              },
              daColor: color,
              daTextStyle: whiteText.szC.medfont,
            ),
          ],
        )
      ],
    );
  }
}
