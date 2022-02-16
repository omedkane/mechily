import 'package:flutter/material.dart';

// bluetext.wA.medfont

String extFont = "Gilroy";

class OneFont {
  OneFont(daColor, double size, {isExt = false})
      : regfont = TextStyle(
            height: isExt ? null : 1,
            fontFamily: isExt ? extFont : null,
            fontSize: size,
            color: daColor),
        regfontH = TextStyle(
          fontFamily: isExt ? extFont : null,
          fontSize: size,
          color: daColor,
          height: 1.4,
        ),
        medfont = TextStyle(
            height: isExt ? null : 1,
            fontFamily: isExt ? extFont : null,
            fontSize: size,
            color: daColor,
            fontWeight: FontWeight.w500),
        semfont = TextStyle(
            height: isExt ? null : 1,
            fontFamily: isExt ? extFont : null,
            fontSize: size,
            color: daColor,
            fontWeight: FontWeight.w600),
        boldfont = TextStyle(
            height: isExt ? null : 1,
            fontFamily: isExt ? extFont : null,
            fontSize: size,
            color: daColor,
            fontWeight: FontWeight.bold);

  TextStyle regfont, regfontH, medfont, boldfont, semfont;
}

class TextStyleSet {
  TextStyleSet(this.daColor)
      : szA = OneFont(daColor, 16),
        szB = OneFont(daColor, 17),
        szC = OneFont(daColor, 19),
        szD = OneFont(daColor, 22),
        szE = OneFont(daColor, 48),
        extSzA = OneFont(daColor, 16, isExt: true),
        extSzB = OneFont(daColor, 17, isExt: true),
        extSzC = OneFont(daColor, 19, isExt: true),
        extSzD = OneFont(daColor, 24, isExt: true),
        extSzE = OneFont(daColor, 48, isExt: true);
  // daColor = daColor;
  final Color daColor;
  final OneFont szA, extSzA, szB, extSzB, szC, extSzC, szD, extSzD, szE, extSzE;
  OneFont cSz(double fontSize) => OneFont(this.daColor, fontSize);
}

// Colors
const Color midori = Color(0xff00cb53),
    mustard = Color(0xffC7AA00),
    oolo = Color(0xffFFE74C),
    shiro = Color(0xfff50057),
    greyish = Color(0xffF4F4F4),
    amber = Color(0xffffa000),
    charcoal = Colors.blueGrey,
    deepOrange = Colors.deepOrange,
    aoi = Color(0xff40c4ff);

const TextStyle casualFont = TextStyle(
  color: Colors.black,
  height: 1.4,
  fontSize: 19,
  fontWeight: FontWeight.w400,
);
// FontStyles aoitext = FontStyles(Color(0xff59ADFF)),
TextStyleSet aoiText = TextStyleSet(Color(0xff35A7FF)),
    whiteText = TextStyleSet(Colors.white),
    mustardText = TextStyleSet(Color(0xffC7AA00)),
    blackText = TextStyleSet(Color(0xff242038)),
    greyText = TextStyleSet(Colors.grey),
    midoriText = TextStyleSet(Color(0xff00cb53)),
    amberText = TextStyleSet(amber),
    charcoalText = TextStyleSet(charcoal),
    shiroText = TextStyleSet(shiro),
    orangeText = TextStyleSet(deepOrange);

TextStyle sectionTitle(TextStyleSet fontStyle) => fontStyle.extSzC.semfont;

const daScales = <double>[8, 16, 24, 32, 40, 48, 56, 64, 72, 80];

const List<BoxShadow> ushaded = [
  BoxShadow(
      color: Color(0xffdadada),
      offset: Offset(0, 8),
      blurRadius: 10,
      spreadRadius: -4)
];
const List<BoxShadow> gshaded = [
  BoxShadow(
      color: Color.fromRGBO(154, 154, 154, 0.35),
      offset: Offset(0, 2),
      blurRadius: 5,
      spreadRadius: 0)
];

List<BoxShadow> coloredShade(Color color) => [
      BoxShadow(
          color: color, offset: Offset(0, 2), blurRadius: 5, spreadRadius: -2)
    ];

List<BoxShadow> greyShaded = [
  BoxShadow(blurRadius: 4, offset: Offset(0, 2), color: Colors.grey.shade300)
];

const List<BoxShadow> hoverShaded = [
  BoxShadow(blurRadius: 16, color: Colors.black26, offset: Offset(0, 8))
];

const List<BoxShadow> matShade = [
  BoxShadow(blurRadius: 4, offset: Offset(0, 2), color: Colors.black45)
];

abstract class WidthFactors {
  static double dialog = 0.95;
}

abstract class AppPaddings {
  static const screen =
      const EdgeInsets.only(top: Spaces.statusBarToTitle, left: 16, right: 16);
}

abstract class Spaces {
  static const double titleToWidget = 24;
  static const double statusBarToTitle = 48;
}
