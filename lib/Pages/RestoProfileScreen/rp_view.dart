import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/AnimatedRevealer.dart';
import 'package:mechily/Components/ColoredShowcasedFood.dart';
import 'package:mechily/Components/MyIconButton.dart';
import 'package:mechily/Components/RadiusButton.dart';
import 'package:mechily/Components/RatersController.dart';
import 'package:mechily/Components/RatingStars.dart';
import 'package:mechily/Components/RestoReview.dart';
import 'package:mechily/Components/RoundedTitle.dart';
import 'package:mechily/Components/StaticRatings.dart';
import 'package:mechily/Pages/RestoProfileScreen/rp_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

class RestoProfileScreen extends StatelessWidget {
  final model = Get.put<RpModel>(RpModel());
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: shiro,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(40)),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    SizedBox(
                      child: Image(
                          height: 440,
                          fit: BoxFit.cover,
                          alignment: Alignment(-0.8, 0),
                          image: AssetImage("assets/images/rotana.jpg")),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(
                          bottom: 16, left: 12, right: 16, top: 46),
                      height: 440,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black54],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyIconButton(
                                icon: Icons.chevron_left,
                                iconSize: 24,
                                size: 40,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text("Rotana Café",
                                    style: whiteText.szD.medfont
                                        .apply(fontSizeDelta: 4)),
                              ),
                              Column(
                                children: [
                                  Icon(Icons.star_border,
                                      color: Colors.white, size: 32),
                                  Text(
                                    "4,5",
                                    style: whiteText.extSzD.medfont,
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // height: 100,
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 16, left: 16, right: 16),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent[400],
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Adresse :",
                              style: whiteText.szB.regfont,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Ilo K, 23556",
                              style: whiteText.szB.boldfont,
                            ),
                            Text(
                              "(+222) 32 23 65 45",
                              style: whiteText.szB.boldfont,
                            ),
                          ],
                        ),
                        MyIconButton(
                          icon: MaterialCommunityIcons.heart_outline,
                          iconSize: 24,
                          size: 40,
                          // sizeScale: 1.2,
                          iconColor: shiro,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyIconButton(
                          icon: Icons.phone,
                          iconColor: aoi,
                          size: 64,
                          iconSize: 24,
                          title: "Appeler",
                          boxShadow: gshaded,
                        ),
                        MyIconButton(
                          icon: Icons.message,
                          iconColor: midori,
                          size: 64,
                          iconSize: 24,
                          title: "Message",
                          boxShadow: gshaded,
                        ),
                        MyIconButton(
                          icon: Icons.gps_fixed,
                          iconColor: shiro,
                          size: 64,
                          iconSize: 24,
                          title: "Maps",
                          boxShadow: gshaded,
                        ),
                        MyIconButton(
                          icon: Icons.email,
                          iconColor: Colors.orange,
                          size: 64,
                          iconSize: 24,
                          title: "Email",
                          boxShadow: gshaded,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Exclusifs",
                            style: blackText.extSzC.semfont
                                .apply(color: Colors.blueGrey)),
                        Text(
                            "Découvrez les plats qui ne sont disponibles qu'ici",
                            style: midoriText.szB.regfont),
                        const SizedBox(height: 24),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 330,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.90),
                itemCount: model.exclusiveFood.length,
                itemBuilder: (context, index) => Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: index == 0 ? 0 : 16),
                    child: SpecialShowcasedFood(
                      imgUri: model.exclusiveFood[index],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Revues",
                      style: blackText.extSzC.semfont
                          .apply(color: Colors.blueGrey)),
                  Text(
                      "Découvrez la réputation du resto au sein de la communauté",
                      style: midoriText.szB.regfont),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Container(
              height: 250,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 24),
              child: PageView.builder(
                  controller: PageController(viewportFraction: 0.90),
                  itemCount: model.daReviews.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: index == 0 ? 0 : 16),
                      child: RestoReview(
                        reviewer: model.daReviews[index][0],
                        daReview: model.daReviews[index][1],
                        daRating: model.daReviews[index][2],
                      ),
                    );
                  }),
            ),
            Center(
              child: GetBuilder<RatersController>(
                id: "myCommentCard",
                tag: "rpRaters",
                builder: (_) {
                  return AnimatedRevealer(
                    duration: Duration(milliseconds: 300),
                    remote: model.ratersController.daCardRemote,
                    initiallyVisible: model.ratersController.hasRated,
                    child: Container(
                      width: screenWidth * 0.87,
                      margin: const EdgeInsets.only(top: 16, bottom: 32),
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StaticRatings(
                                  offColor: Colors.black87,
                                  onColor: Colors.white,
                                  spacing: 0,
                                  enabledNb_0:
                                      model.ratersController.trueRating,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  model.ratersController.comment ??
                                      "La pizza est une recette de cuisine traditionnelle de la cuisine italienne," +
                                          " à base de galette de pâte à pain," +
                                          " garnie de divers mélanges d’ingrédients",
                                  style: whiteText.szC.medfont,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: Container(
                width: screenWidth * 0.87,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: gshaded),
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Appréciez-vous la boutique ?",
                          style: greyText.szC.regfont
                              .apply(color: Colors.grey.shade600),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Donnez une note !",
                          style: greyText.szC.regfont
                              .apply(color: Colors.grey.shade600),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    GetBuilder<RatersController>(
                      id: "ratersContainer",
                      tag: "rpRaters",
                      builder: (_) {
                        print("raters rebuilt");
                        bool hasUpdatedRating =
                            model.ratersController.hasUpdatedRating;
                        bool hasRated = model.ratersController.hasRated;
                        return Column(
                          children: [
                            FractionallySizedBox(
                              widthFactor: 0.82,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 16, bottom: 0),
                                child: Raters(
                                  daController: model.ratersController,
                                  daIcon: Icons.star,
                                  showRatingComment: true,
                                  size: 56,
                                ),
                              ),
                            ),
                            RadiusButton(
                              title: hasUpdatedRating
                                  ? "Changer"
                                  : (hasRated ? "Retirer" : "Noter"),
                              daColor: hasUpdatedRating
                                  ? aoi
                                  : (hasRated ? shiro : amber),
                              onTap: model.ratersController.canPublish
                                  ? () {
                                      if (hasUpdatedRating) {
                                        model.ratersController
                                            .changeComment(context);
                                      } else if (hasRated) {
                                        model.ratersController.deleteComment();
                                      } else
                                        model.ratersController
                                            .writeComment(context);
                                    }
                                  : null,
                              // rightAligned: true,
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
