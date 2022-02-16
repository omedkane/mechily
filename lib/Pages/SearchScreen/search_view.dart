import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/HeroInput.dart';
import 'package:mechily/Components/MyInput.dart';
import 'package:mechily/Components/ScreenTitle.dart';
import 'package:mechily/Components/SweetTitle.dart';
import 'package:mechily/Misc/classes.dart';
import 'package:mechily/Misc/enums.dart';
import 'package:mechily/Models/OneDish.dart';
import 'package:mechily/Pages/FavouritesScreen/DishWidget.dart';
import 'package:mechily/Pages/FoodScreen/dish_view.dart';
import 'package:mechily/Pages/SearchScreen/search_model.dart';

class SearchScreen extends StatelessWidget {
  final Remote<AnimationController> previousHeroSearch;

  const SearchScreen({Key key, this.previousHeroSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenModel>(
      init: SearchScreenModel(previousHeroSearch),
      builder: (model) {
        print("daamn");
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: AppPaddings.screen,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScreenTitle(title: "Recherche"),
                    const SizedBox(height: 16),
                    HeroInput(
                      animateOnReady: true,
                      callback: () {
                        FocusScope.of(context).nextFocus();
                      },
                      input: MyInput(
                        hint: "Chercher un plat...",
                        icon: Icon(Icons.search, size: 20),
                        controller: model.searcher,
                        textInputAction: TextInputAction.search,
                        onSubmitted: model.searchDish,
                      ),
                    ),
                    if (model.hasSearched)
                      Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 8),
                        child: Text(
                          "Resultats de la recherche : ",
                          style: shiroText.szC.medfont,
                        ),
                      ),
                  ],
                ),
              ),
              if (model.hasSearched && model.results.length != 0)
                Flexible(
                  child: GridView.builder(
                    itemCount: model.results.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 32,
                      childAspectRatio:
                          DishWidget.width / (DishWidget.height + 10),
                    ),
                    itemBuilder: (context, index) {
                      final Dish dish = model.results[index].payload;
                      return DishWidget(
                        dish: dish,
                        onTap: () {
                          Get.to(DishScreen(
                            daDish: dish,
                          ));
                        },
                        onLongPress: () {
                          model.quickOrderDish(dish);
                        },
                      );
                    },
                  ),
                )
              else if (model.hasSearched)
                Expanded(
                  child: Center(
                    child: SweetTitle(
                      text: "Votre recherche n'a aboutit à aucun résultat !",
                      size: Sizes.normal,
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
