import 'package:flutter/material.dart';
import 'package:mechily/AppStyle.dart';

class FormInput extends StatelessWidget {
  final String title;
  final Widget widget;
  final Widget leadingWidget, trailingWidget;
  final Widget trailingWidgetTitle;
  final bool isRequired;
  final String notice;
  final Color noticeColor;

  const FormInput({
    Key key,
    this.title,
    this.widget,
    this.leadingWidget,
    this.trailingWidget,
    this.trailingWidgetTitle,
    this.isRequired = false,
    this.notice,
    this.noticeColor = aoi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasLeadingWidget = leadingWidget != null;
    bool hasTrailingWidget = trailingWidget != null;
    bool hasNotice = notice != null;

    Widget titleText = isRequired
        ? Row(
            children: [
              Text(
                "$title :",
                style: blackText.szC.regfont,
              ),
              const SizedBox(width: 8),
              Text(
                "(Requis)",
                style: aoiText.szB.boldfont,
              ),
            ],
          )
        : Text(
            "$title :",
            style: blackText.szC.regfont,
          );

    Widget inputWidget;

    // -> ${1:Message} !
    Widget titleWidget;
    Widget mainWidget;
    // -<

    inputWidget = widget;

    titleWidget = Padding(
      padding: const EdgeInsets.only(top: 28, bottom: 16, left: 4),
      child: hasTrailingWidget
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                titleText,
                trailingWidgetTitle,
              ],
            )
          : titleText,
    );

    mainWidget = (hasLeadingWidget || hasTrailingWidget)
        ? Row(
            children: [
              if (hasLeadingWidget) ...[
                leadingWidget,
                const SizedBox(width: 16),
              ],
              Flexible(child: inputWidget),
              if (hasTrailingWidget) ...[
                const SizedBox(width: 16),
                trailingWidget,
              ],
            ],
          )
        : inputWidget;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget,
        mainWidget,
        if (hasNotice) const SizedBox(height: 8),
        if (hasNotice)
          Text(
            notice,
            style: TextStyleSet(noticeColor).szB.regfontH,
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
