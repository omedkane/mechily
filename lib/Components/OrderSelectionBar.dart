import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/OrderedSelectionController.dart';
import 'package:flutter/material.dart';

class OrderSelectionBar extends StatelessWidget {
  final double width;
  final Color color;
  final void Function() onEnabled, onDisabled;
  final OrderedSelectionMember selectionMember;
  final String price;

  const OrderSelectionBar({
    Key key,
    this.color,
    this.width,
    this.onEnabled,
    this.onDisabled,
    @required this.selectionMember,
    this.price,
  }) : super(key: key);

  Widget build(BuildContext context) {
    TextStyleSet textStyles = selectionMember.isSelected ? whiteText : greyText;
    Color bgColor = selectionMember.isSelected ? color : Colors.white;
    Color borderColor =
        selectionMember.isSelected ? color : Colors.grey.shade400;
    Color iconColor = selectionMember.isSelected ? color : Colors.transparent;

    return GestureDetector(
      onTap: () {
        selectionMember.switchMe();
        if (selectionMember.isSelected)
          onEnabled();
        else
          onDisabled();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: width,
        decoration: BoxDecoration(
          boxShadow: selectionMember.isSelected
              ? coloredShade(color.withOpacity(0.6))
              : gshaded,
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          // border: Border.all(color: borderColor, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 16, top: 16, bottom: 16),
                    child: Container(
                      alignment: Alignment.center,
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: borderColor, width: 1),
                      ),
                      child: Text(
                        selectionMember.rank.toString(),
                        style: whiteText.szC.semfont.apply(color: iconColor),
                      ),
                    ),
                  ),
                  Text(
                    selectionMember.title,
                    style: textStyles.szB.semfont,
                  )
                ],
              ),
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
          ),
        ),
      ),
    );
  }
}
