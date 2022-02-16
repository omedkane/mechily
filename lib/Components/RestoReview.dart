import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/AnimatedDialog.dart';
import 'package:mechily/Dialogs/CustomInputDialog.dart';
import 'package:mechily/Components/RadiusButton.dart';
import 'package:mechily/Components/RoundedTitle.dart';
import 'package:mechily/Components/StaticRatings.dart';
import 'package:mechily/Dialogs/TextDisplayDialog.dart';
import 'package:flutter/material.dart';

class RestoReview extends StatelessWidget {
  final String reviewer;
  final String daReview;
  final int daRating;

  const RestoReview({Key key, this.reviewer, this.daReview, this.daRating})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // print(DateTime.now().toString());
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTooLong = daReview.length > 150;
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 216,
        width: screenWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: gshaded,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: RoundedTitle(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    bgColor: amber,
                    daWidget: StaticRatings(
                      enabledNb_0: daRating,
                      spacing: 0,
                      size: 20,
                      offColor: Colors.black45,
                      onColor: Colors.white,
                    ),
                    pairedWidget: Text(
                      // TODO: Timestamp or DateTime Whichever
                      "Il y'a 15 heures",
                      style: charcoalText.szB.semfont,
                    ),
                    // rightAligned: true,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: !isTooLong
                            ? null
                            : () {
                                openTextReadingDialog();
                              },
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 16, bottom: 8, left: 16, right: 16),
                          child: !isTooLong
                              ? Text(daReview,
                                  style: blackText.szC.regfontH.apply(
                                      heightDelta: 0.1, color: Colors.black54))
                              : RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      TextSpan(
                                        text: daReview.substring(0, 150),
                                        style: blackText.szB.regfontH.apply(
                                            heightDelta: 0.1,
                                            color: Colors.black54),
                                      ),
                                      TextSpan(
                                          text: "...    Voir la suite",
                                          style: midoriText.szA.medfont
                                              .apply(fontSizeDelta: -1))
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ),
                    // const SizedBox(height: 8),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(reviewer, style: amberText.szC.boldfont),
                  RadiusButton(
                    child: Icon(
                      Icons.flag,
                      color: Colors.white,
                      // size: 20,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    // rightAligned: true,
                    daColor: shiro,
                    onTap: () {
                      AnimatedDialog.show(
                          child: CustomInputDialog(
                        icon: Icons.outlined_flag,
                        primaryColor: shiro,
                        notice:
                            "Précisez s'il y'a profanations ou autres de la sorte !",
                        title: "Signalement",
                        textInputHint: "Signalez ici...",
                      ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
