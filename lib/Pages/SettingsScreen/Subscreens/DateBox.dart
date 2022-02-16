import 'package:flutter/material.dart';
import 'package:mechily/AppStyle.dart';

class DateBox extends StatelessWidget {
  final bool isSelected;
  final DateTime date;
  final void Function() onTap;

  const DateBox({Key key, this.isSelected = false, this.date, this.onTap})
      : super(key: key);

  static const Map<int, String> daysInFrench = {
    DateTime.sunday: "Dimanche",
    DateTime.monday: "Lundi",
    DateTime.tuesday: "Mardi",
    DateTime.wednesday: "Mercredi",
    DateTime.thursday: "Jeudi",
    DateTime.friday: "Vendredi",
    DateTime.saturday: "Samedi",
  };

  static const Map<int, String> monthsInFrench = {
    DateTime.january: "janvier",
    DateTime.february: "février",
    DateTime.march: "mars",
    DateTime.april: "avril",
    DateTime.may: "mai",
    DateTime.june: "juin",
    DateTime.july: "juillet",
    DateTime.august: "août",
    DateTime.september: "septembre",
    DateTime.october: "octobre",
    DateTime.november: "novembre",
    DateTime.december: "décembre",
  };

  @override
  Widget build(BuildContext context) {
    Color bgColor = isSelected ? shiro : greyish;
    TextStyleSet textStyleSet = isSelected ? whiteText : blackText;
    String dayName = daysInFrench[date.weekday];
    List<BoxShadow> shadow = isSelected ? coloredShade(bgColor) : gshaded;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        constraints: const BoxConstraints(minWidth: 80),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: shadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(dayName, style: textStyleSet.szC.regfont),
            Text(date.day.toString(), style: textStyleSet.extSzD.boldfont),
          ],
        ),
      ),
    );
  }
}
