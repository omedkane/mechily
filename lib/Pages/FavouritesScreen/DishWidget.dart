import 'package:mechily/AppStyle.dart';
import 'package:mechily/Misc/functions.dart';
import 'package:mechily/Models/OneDish.dart';
import 'package:mechily/Models/OnePreset.dart';
import 'package:flutter/material.dart';

class DishWidget extends StatelessWidget {
  final Dish dish;
  final Preset preset;
  final void Function() onTap, onLongPress;

  static const double height = 180;
  static const double width = 180;

  const DishWidget(
      {Key key, this.dish, this.preset, this.onTap, this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Dish daDish = preset?.dish ?? dish;

    Color firstColor = daDish.categories.first.color;
    final String shortName = cutText((preset?.name ?? dish.name), 12);
    final bool isPreset = preset != null;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: height,
              width: width,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                boxShadow: gshaded,
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/" + daDish.image),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(shortName,
                    style: mustardText.extSzA.semfont.apply(color: firstColor)),
                Wrap(
                  spacing: 4,
                  children: [
                    Text(
                        (isPreset ? preset.totalPrice : daDish.price)
                            .toString(),
                        style: blackText.extSzA.semfont),
                    Text("MRU", style: blackText.extSzA.regfont),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
