import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/SweetTitle.dart';
import 'package:mechily/Components/TopTabbedPageBrowser.dart';
import 'package:mechily/Global/GlobalState.dart';
import 'package:mechily/Misc/enums.dart';
import 'package:mechily/Models/OneDish.dart';
import 'package:mechily/Navigation/FrontPage.dart';
import 'package:mechily/Pages/FavouritesScreen/DishWidget.dart';
import 'package:mechily/Pages/FavouritesScreen/favourites_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouritesScreen extends StatelessWidget with FrontPage {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouritesScreenModel>(
      init: FavouritesScreenModel(),
      builder: (model) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Spaces.statusBarToTitle),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Ma", style: blackText.extSzC.medfont),
                  Text(
                    "Personalisation",
                    style: shiroText.extSzD.boldfont,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            TopTabbedPageBrowser(
              tabPages: [
                TabPage(
                  "Plats favoris",
                  GetBuilder<FavouritesScreenModel>(
                    id: model.favouritesSectionGetID,
                    builder: (_) {
                      return Global.store.currentUser.favouriteDishes.length ==
                              0
                          ? Center(
                              child: SweetTitle(
                                size: Sizes.normal,
                                text:
                                    "Aucun plat favoris, veuillez en ajouter !",
                                textAlign: TextAlign.center,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                              ),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 32,
                                childAspectRatio:
                                    DishWidget.width / (DishWidget.height + 10),
                              ),
                              itemCount: Global
                                  .store.currentUser.favouriteDishes.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                Dish dish = Global
                                    .store.currentUser.favouriteDishes[index];
                                return DishWidget(
                                  dish: dish,
                                  onTap: () {
                                    model.orderDish(index);
                                  },
                                );
                              });
                    },
                  ),
                ),
                TabPage(
                  "Prédéfinies",
                  GetBuilder<FavouritesScreenModel>(
                    id: model.presetsSectionGetID,
                    builder: (_) {
                      return Global.store.currentUser.presets.length == 0
                          ? Center(
                              child: SweetTitle(
                                size: Sizes.normal,
                                text:
                                    "Aucune commande prédéfinie, veuillez en ajouter !",
                                textAlign: TextAlign.center,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 32),
                              ),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 32,
                                childAspectRatio: 180 / 190,
                              ),
                              itemCount:
                                  Global.store.currentUser.presets.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var preset =
                                    Global.store.currentUser.presets[index];
                                return DishWidget(
                                  preset: preset,
                                  onTap: () {
                                    model.showPresetDetails(index);
                                  },
                                );
                              },
                            );
                    },
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
