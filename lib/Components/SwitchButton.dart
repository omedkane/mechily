import 'package:mechily/AppStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwitchButtonController extends GetxController {
  // final String showcasedText;
  final bool initiallySelected, initiallyFrozen;
  final Function onTap, onEnabled, onDisabled;

  String showcasedText;
  bool isSelected;
  bool isFrozen;

  SwitchButtonController({
    this.showcasedText,
    this.initiallySelected,
    this.initiallyFrozen,
    this.onTap,
    this.onEnabled,
    this.onDisabled,
  })  : isSelected = initiallySelected ?? false,
        isFrozen = initiallyFrozen ?? false;

  void setShowcasedText({String text}) {
    this.showcasedText = text;
    if (text != null) {
      if (!isSelected) {
        isSelected = true;
      }
    } else if (isSelected) {
      isSelected = false;
    }

    update();
  }

  void enableMe() {
    if (isSelected) return;

    isSelected = true;

    update();
    onEnabled?.call();
  }

  void disableMe() {
    if (!isSelected) return;

    isSelected = false;
    update();
    onDisabled?.call();
  }

  void switchMe() {
    if (isSelected) {
      disableMe();
    } else {
      enableMe();
    }
  }

  void freezeMe() {
    if (isFrozen) return;
    update();
    isFrozen = true;
  }

  void unfreezeMe() {
    if (!isFrozen) return;
    update();
    isFrozen = false;
  }
}

class SwitchButton extends StatelessWidget {
  final SwitchButtonController model;
  final Color bgColor;
  final Color textColor;
  final IconData daIcon;
  final String title;
  final double iconSize;

  SwitchButton({
    Key key,
    controller,
    this.bgColor,
    this.textColor,
    this.daIcon,
    this.title,
    String showcasedText,
    bool initiallySelected,
    bool initiallyFrozen,
    Function onTap,
    Function onEnabled,
    Function onDisabled,
    this.iconSize = 24,
  })  : model = controller ??
            SwitchButtonController(
              showcasedText: showcasedText,
              initiallyFrozen: initiallyFrozen,
              initiallySelected: initiallySelected,
              onTap: onTap,
              onEnabled: onEnabled,
              onDisabled: onDisabled,
            ),
        super(key: key);
  Widget build(BuildContext context) {
    return GetBuilder<SwitchButtonController>(
      init: model,
      global: false,
      builder: (model) {
        Color containerColor =
            model.isSelected ? (bgColor ?? shiro) : Colors.white;
        Color iconColor =
            model.isSelected ? textColor ?? Colors.white : Colors.grey.shade400;

        return Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                model.onTap?.call();

                if (!model.isFrozen) model.switchMe();
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 250),
                height: 72,
                width: 72,
                decoration: BoxDecoration(
                    color: containerColor,
                    boxShadow: gshaded,
                    borderRadius: BorderRadius.circular(16)),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: model.showcasedText != null
                          ? Text(
                              model.showcasedText,
                              style: TextStyleSet(iconColor).szC.boldfont,
                            )
                          : Icon(
                              daIcon,
                              color: iconColor,
                              size: iconSize,
                            ),
                    ),
                    if (model.isSelected)
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                title,
                style: (model.isSelected ? TextStyleSet(bgColor) : greyText)
                    .szA
                    .regfont,
              ),
            )
          ],
        );
      },
    );
  }
}
