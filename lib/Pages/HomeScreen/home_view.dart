import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/HeroInput.dart';
import 'package:mechily/Components/QuickAnimatedSize.dart';
import 'package:mechily/Components/QuickyBox.dart';
import 'package:mechily/Components/MyInput.dart';
import 'package:mechily/Components/MyListView.dart';
import 'package:mechily/Components/ShowcasedDish.dart';
import 'package:mechily/Components/ShowcasedFood.dart';
import 'package:mechily/Models/OneDish.dart';
import 'package:mechily/Models/OneQuicky.dart';
import 'package:mechily/Navigation/FrontPage.dart';
import 'package:mechily/Pages/HomeScreen/home_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechily/Pages/SearchScreen/search_view.dart';

class HomeScreen extends StatelessWidget with FrontPage {
  @override
  Widget build(BuildContext context) {
    debugPrint('rebuilt');

    // FocusScope.of(context).unfocus();

    return GetBuilder<HomeCtrl>(
      init: HomeCtrl(),
      builder: (model) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: AppPaddings.screen,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Salut,", style: blackText.szC.medfont),
                    Text(
                      "Henry",
                      style: shiroText.extSzD.boldfont,
                    ),
                    const SizedBox(height: 24),
                    HeroInput(
                      remote: model.heroSearchController,
                      input: const MyInput(
                        hint: "Chercher un plat...",
                        icon: Icon(Icons.search, size: 20),
                        isEnabled: false,
                      ),
                      callback: () {
                        Get.to(SearchScreen(
                          previousHeroSearch: model.heroSearchController,
                        ));
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Que voulez-vous déguster aujourd'hui ?",
                      style: casualFont,
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              GetBuilder<HomeCtrl>(
                id: model.quickySectionGetID,
                builder: (_) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            model.quickyList.length,
                            (index) {
                              Quicky quicky = model.quickyList[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: (index == 0) ? 16 : 24),
                                child: QuickyBox(
                                  categoryId: quicky.id,
                                  icon: quicky.icon,
                                  title: quicky.name,
                                  onTap: () {
                                    model.setselectedQuicky(quicky);
                                  },
                                  isActive:
                                      quicky.id == model.selectedQuicky.id,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // -> Quicky Members !
                      Builder(
                        builder: (context) {
                          final bool __dishesAvailable =
                              (model.selectedQuicky?.members?.length ?? 0) > 0;

                          const EdgeInsetsGeometry __padding =
                              EdgeInsets.symmetric(vertical: 16);

                          final double __height = __dishesAvailable
                              ? ShowcasedDish.height + __padding.vertical
                              : 80;

                          return AnimatedContainer(
                            duration: QuickAnimatedSize.defaultDuration,
                            height: __height,
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            padding: __padding,
                            decoration: BoxDecoration(
                              color: shiro,
                              borderRadius: BorderRadius.horizontal(
                                left:
                                    Radius.circular(__dishesAvailable ? 32 : 0),
                              ),
                            ),
                            child: AnimatedSwitcher(
                              duration: QuickAnimatedSize.defaultDuration,
                              child: !__dishesAvailable
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        "Aucun plat disponible pour le moment",
                                        style: shiroText.szC.regfont,
                                      ),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          model.selectedQuicky.members.length,
                                      itemBuilder: (context, index) {
                                        Dish dish =
                                            model.selectedQuicky.members[index];

                                        const EdgeInsetsGeometry
                                            firstDishMargin =
                                            const EdgeInsets.only(left: 16);
                                        const EdgeInsetsGeometry midDishMargin =
                                            const EdgeInsets.only(left: 20);
                                        const EdgeInsetsGeometry
                                            lastDishMargin =
                                            const EdgeInsets.only(
                                                right: 16, left: 20);

                                        int memberCount =
                                            model.selectedQuicky.members.length;

                                        EdgeInsetsGeometry dishMargin =
                                            index == 0
                                                ? firstDishMargin
                                                : (index == memberCount - 1
                                                    ? lastDishMargin
                                                    : midDishMargin);

                                        return ShowcasedDish(
                                          heroTag: dish.id,
                                          margin: dishMargin,
                                          dish: dish,
                                        );
                                      },
                                    ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),

              // -<
              Padding(
                padding: const EdgeInsets.only(
                    top: 40, left: 16, right: 32, bottom: 32),
                child: Text(
                  "Voulez-vous gouter à quelque chose de nouveaux ?",
                  style: casualFont,
                ),
              ),
              MyListView(
                children: List.generate(
                    5,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ShowcasedFood(
                            daId: index,
                            margin: EdgeInsets.only(left: index == 0 ? 16 : 32),
                            imageUri: "assets/images/wrapchicken.png",
                            pixi: 250,
                            title: "Wrap Poulet",
                            primaryColor: mustardText,
                          ),
                        )),
              ),
              SizedBox(
                height: 60,
              )
            ],
          ),
        );
      },
    );
  }
}
