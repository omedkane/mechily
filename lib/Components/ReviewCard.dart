import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/RoundedTitle.dart';
import 'package:mechily/Components/StaticRatings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ReviewCard extends StatelessWidget {
  final int rating;
  final String comment;

  const ReviewCard({Key key, this.rating, this.comment}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * WidthFactors.dialog,
      decoration: BoxDecoration(
        color: amber,
        boxShadow: gshaded,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundedTitle(
            daTitle: "Votre revue",
            textColorWeight: amberText,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StaticRatings(
                  offColor: Colors.black87,
                  onColor: Colors.white,
                  daIcon: FontAwesome5Solid.hamburger,
                  spacing: 4,
                  enabledNb_0: rating,
                  // enabledNb_0: ratersController.trueRating,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 24),
                  child: Text(
                    comment ??
                        "La pizza est une recette de cuisine traditionnelle de la cuisine italienne," +
                            " à base de galette de pâte à pain," +
                            " garnie de divers mélanges d’ingrédients",
                    style: whiteText.szC.medfont,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
