import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/AnimatedRevealer.dart';
import 'package:mechily/Components/OrderedSelectionBox.dart';
import 'package:mechily/Components/MyIconButton.dart';
import 'package:mechily/Components/MyListView.dart';
import 'package:mechily/Components/OrderedSelectionController.dart';
import 'package:mechily/Components/SimpleDot.dart';
import 'package:mechily/Components/SweetTitle.dart';
import 'package:mechily/Components/SwitchButton.dart';
import 'package:mechily/Components/RadiusButton.dart';
import 'package:mechily/Components/RatersController.dart';
import 'package:mechily/Components/RatingStars.dart';
import 'package:mechily/Components/ReviewCard.dart';
import 'package:mechily/Components/SwitchIconButton.dart';
import 'package:mechily/Global/GlobalState.dart';
import 'package:mechily/Misc/classes.dart';
import 'package:mechily/Models/OneCategory.dart';
import 'package:mechily/Models/OneCondiment.dart';
import 'package:mechily/Models/OneDish.dart';
import 'package:mechily/Pages/FoodScreen/dish_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class DishScreen extends StatelessWidget {
  static const double imgContHeight = 370.0;
  final String heroTag;
  final Dish daDish;

  const DishScreen({Key key, this.heroTag, @required this.daDish})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Color firstCategoryColor = daDish?.categories?.first?.color ?? shiro;
    TextStyleSet textStyleSet = TextStyleSet(firstCategoryColor);
    return GetBuilder<DishScreenModel>(
      init: DishScreenModel(daDish),
      builder: (model) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // const SizedBox(height: 72),
                    Hero(
                      tag: daDish.id,
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                        height: 380,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(64),
                          ),
                          boxShadow: ushaded,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/" + daDish.image),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyIconButton(
                              icon: Icons.chevron_left,
                              iconColor: shiro,
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            SwitchIconButton(
                              iconWhenOn: MaterialCommunityIcons.heart,
                              iconWhenOff: MaterialCommunityIcons.heart_outline,
                              switchStateGetter: () => Global.store.currentUser
                                  .isDishFavourite(daDish),
                              enabler: () {
                                Global.store.currentUser
                                    .addFavouriteDish(daDish);
                              },
                              disabler: () {
                                Global.store.currentUser
                                    .removeFavouriteDish(dish: daDish);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 16,
                                children: [
                                  // Container(
                                  //   padding: EdgeInsets.symmetric(
                                  //       vertical: 8, horizontal: 8),
                                  //   decoration: BoxDecoration(
                                  //     color: shiro.withOpacity(0.1),
                                  //     borderRadius: BorderRadius.circular(8),
                                  //   ),
                                  //   child: Text(daDish.name,
                                  //       style: shiroText.szB.semfont
                                  //           .apply(fontFamily: "Gilroy")),
                                  // ),
                                  Text(
                                    daDish.name,
                                    style: textStyleSet.szC.medfont,
                                  ),
                                  if (daDish?.categories?.first?.color != null)
                                    SimpleDot(
                                      color: daDish.categories.first.color,
                                    ),
                                  ...List.generate(daDish.categories?.length,
                                      (index) {
                                    Category category =
                                        daDish.categories[index];
                                    return SweetTitle(
                                      text: category.name,
                                      primaryColor: category.color,
                                      // style: shiroText.szB.boldfont,
                                    );
                                  })
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.star, color: amber),
                                  Text(daDish.rating.toString(),
                                      style: amberText.extSzC.boldfont)
                                ],
                              )
                            ],
                          ),

                          const SizedBox(height: 16),
                          Text(
                            "La pizza est une recette de cuisine traditionnelle de la cuisine italienne," +
                                " à base de galette de pâte à pain," +
                                " garnie de divers mélanges d’ingrédients",
                            style: blackText.szC.regfontH
                                .apply(heightDelta: 0.2, fontSizeDelta: -1),
                          ),
                          const SizedBox(height: 32),

                          // End of the road
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text("Pourrait contenir : ",
                              style: sectionTitle(mustardText)),
                        ),
                        MyListView(
                          children: [
                            ...List.generate(
                              model.listOfCondiments.length,
                              (index) {
                                IO condimentIO = model.listOfCondiments[index];
                                Condiment condiment =
                                    condimentIO.data['condiment'];

                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: index == 0 ? 16 : 0,
                                      bottom: index == 0 ? 16 : 0,
                                      left: index == 0 ? 16 : 32),
                                  child: SwitchButton(
                                    daIcon: condiment.icon,
                                    iconSize: 32,
                                    bgColor: condiment.color,
                                    title: condiment.name,
                                    initiallySelected: condimentIO.isSelected,
                                    onEnabled: condimentIO.selectMe,
                                    onDisabled: condimentIO.unselectMe,
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 32),
                              child: SwitchButton(
                                daIcon: Icons.textsms,
                                bgColor: aoi,
                                title: "Autre",
                                controller: model.otherPrefSwitchController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 24),
                          child: Text("Disponible dans ces restos  : ",
                              style: sectionTitle(mustardText)),
                        ),
                        GetBuilder<DishScreenModel>(
                          id: model.restoSelectionGetID,
                          builder: (_) {
                            return MyListView(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 16),
                                SwitchButton(
                                  daIcon: MaterialCommunityIcons.truck_fast,
                                  bgColor: midori,
                                  title: "Plus Rapide",
                                  controller:
                                      model.closestRestoSwitchController,
                                ),
                                ...List.generate(
                                  model.popularRestos.length,
                                  (index) {
                                    OrderedSelectionMember selection =
                                        model.popularRestos[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 32),
                                      child: OrderedSelectionBox(
                                        daIcon: Icons.restaurant,
                                        bgColor: aoi,
                                        selectionMember: selection,
                                      ),
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 32),
                                  child: SwitchButton(
                                    daIcon: Icons.exposure_plus_1,
                                    bgColor: amber,
                                    initiallySelected: false,
                                    controller: model.moreRestoSwitchController,
                                    title: "Autre",
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16, top: 16),
                          child: Text("Revues  : ",
                              style: sectionTitle(mustardText)),
                        ),
                        const SizedBox(height: 32),
                        Center(
                          child: GetBuilder<RatersController>(
                            id: RatersController.commentCardGetID,
                            builder: (_) {
                              print("ccard rebuilt");
                              return AnimatedRevealer(
                                duration: Duration(milliseconds: 300),
                                remote: model.ratersController.daCardRemote,
                                initiallyVisible:
                                    model.ratersController.hasRated,
                                child: ReviewCard(
                                  rating: model.ratersController.trueRating,
                                  comment: model.ratersController.comment,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 32),
                        Center(
                          child: Container(
                            width: screenWidth * 0.9,
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
                                  id: RatersController.ratersGetID,
                                  builder: (_) {
                                    print("raters rebuilt");
                                    bool hasUpdatedRating =
                                        model.ratersController.hasUpdatedRating;
                                    bool hasRated =
                                        model.ratersController.hasRated;
                                    return Column(
                                      children: [
                                        FractionallySizedBox(
                                          widthFactor: 0.9,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16, bottom: 0),
                                            child: Raters(
                                              daController:
                                                  model.ratersController,
                                              daIcon:
                                                  FontAwesome5Solid.hamburger,
                                              showRatingComment: true,
                                              size: 48,
                                            ),
                                          ),
                                        ),
                                        RadiusButton(
                                          title: hasUpdatedRating
                                              ? "Changer"
                                              : (hasRated
                                                  ? "Retirer"
                                                  : "Noter"),
                                          daColor: hasUpdatedRating
                                              ? aoi
                                              : (hasRated ? shiro : amber),
                                          onTap: model
                                                  .ratersController.canPublish
                                              ? () {
                                                  if (hasUpdatedRating) {
                                                    model.ratersController
                                                        .changeComment(context);
                                                  } else if (hasRated) {
                                                    model.ratersController
                                                        .deleteComment();
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
                      ],
                    ),
                    SizedBox(
                      height: 132,
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 80,
                  // width: screenWidth * 0.8,
                  margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                  padding: EdgeInsets.only(left: 8, right: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 8,
                            color: Colors.black12,
                            offset: Offset(0, 2))
                      ],
                      borderRadius: BorderRadius.circular(8.0)),
                  child: GetBuilder<DishScreenModel>(
                    id: model.orderMakerGetID,
                    builder: (_) {
                      print("wassssuuuup !");
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              MyIconButton(
                                iconColor: mustard,
                                bgColor: Colors.white,
                                iconSize: 32,
                                onTap: model.daOrder.decreaseQty,
                                icon: Icons.chevron_left,
                                boxShadow: gshaded,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Text(
                                  model.daOrder.quantity.toString(),
                                  style: mustardText.szD.boldfont,
                                ),
                              ),
                              MyIconButton(
                                iconColor: mustard,
                                bgColor: Colors.white,
                                onTap: model.daOrder.increaseQty,
                                iconSize: 32,
                                icon: Icons.chevron_right,
                                boxShadow: gshaded,
                              ),
                            ],
                          ),
                          // const SizedBox(width: 40),
                          Wrap(
                            spacing: 4,
                            crossAxisAlignment: WrapCrossAlignment.end,
                            children: <Widget>[
                              SizedBox(
                                width: 80,
                                height: 48,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    "${model.totalPrice}",
                                    style: mustardText.extSzE.boldfont
                                        .apply(fontSizeDelta: 4),
                                  ),
                                ),
                              ),
                              Text(
                                "MRU",
                                style: mustardText.szB.medfont,
                              )
                            ],
                          ),
                          MyIconButton(
                            bgColor: aoi,
                            boxShadow: gshaded,
                            iconColor: Colors.white,
                            onTap: () {
                              model.submitOrder();
                            },
                            icon: MaterialCommunityIcons.check_all,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
