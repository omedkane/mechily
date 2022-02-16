import 'package:mechily/AppStyle.dart';
import 'package:flutter/material.dart';

class ShowcasedFood extends StatelessWidget {
  final int daId;
  final String title;
  final int pixi;
  final String imageUri;
  final TextStyleSet primaryColor;
  final EdgeInsetsGeometry margin;
  final String daTag;
  final Function onTap;

  const ShowcasedFood(
      {Key key,
      this.daId,
      this.title,
      this.pixi,
      this.imageUri,
      this.primaryColor,
      this.margin,
      this.daTag,
      this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        height: 250,
        width: 220,
        margin: margin ?? EdgeInsets.only(left: daId == 0 ? 28 : 32),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: gshaded),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FractionallySizedBox(
                widthFactor: 0.85,
                child: daTag == null
                    ? Image(
                        image: AssetImage(imageUri),
                        fit: BoxFit.cover,
                      )
                    : Hero(
                        tag: daTag, child: Image(image: AssetImage(imageUri)))),
            Column(
              children: <Widget>[
                Text(
                  title,
                  style: (primaryColor ?? shiroText).szB.boldfont,
                ),
                const SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    Spacer(),
                    Text(
                      pixi.toString(),
                      style: blackText.extSzD.boldfont,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          "MRU",
                          style: blackText.szA.medfont,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
