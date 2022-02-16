import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/OrderedSelectionController.dart';
import 'package:flutter/material.dart';

class OrderedSelectionBox extends StatelessWidget {
  final OrderedSelectionMember selectionMember;
  final IconData daIcon;
  final Color bgColor;
  final Color textColor;
  final Function onSelected;
  final Function onUnselected;

  const OrderedSelectionBox({
    Key key,
    this.daIcon,
    this.bgColor = shiro,
    this.textColor = Colors.white,
    this.onSelected,
    this.onUnselected,
    @required this.selectionMember,
  }) : super(key: key);

  void selectMe() {
    selectionMember.selectMe();
    onSelected?.call();
    print("just selected");
  }

  void unselectMe() {
    selectionMember.unselectMe();
    onUnselected?.call();
  }

  void selectMeOrNot() {
    if (!selectionMember.isSelected) {
      // When activating
      selectMe();
    } else {
      // When deactivating
      unselectMe();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectionMember.isSelected;
    TextStyleSet textStyles = isSelected ? TextStyleSet(bgColor) : greyText;
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: selectMeOrNot,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            height: 72,
            width: 72,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? (bgColor ?? shiro) : Colors.white,
              boxShadow: gshaded,
              shape: BoxShape.circle,
            ),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: isSelected
                  ? Text(
                      selectionMember.rank.toString(),
                      style: TextStyleSet(textColor).szC.medfont,
                    )
                  : Icon(daIcon, color: Colors.grey.shade400),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          selectionMember.title,
          style: textStyles.szA.regfont,
        ),
        if (selectionMember.extraWidget1 != null ||
            selectionMember.extraWidget2 != null)
          const SizedBox(height: 4),
        // -
        if (selectionMember.extraWidget1 != null &&
            selectionMember.extraWidget2 != null)
          Row(
            children: [
              selectionMember.extraWidget1(bgColor, textStyles),
              const SizedBox(width: 4),
              selectionMember.extraWidget2(bgColor, textStyles),
            ],
          )
        else if (selectionMember.extraWidget1 != null)
          selectionMember.extraWidget1(bgColor, textStyles)
        else if (selectionMember.extraWidget2 != null)
          selectionMember.extraWidget2(bgColor, textStyles)
      ],
    );
  }
}
