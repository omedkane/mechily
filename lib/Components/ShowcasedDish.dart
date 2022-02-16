import 'package:mechily/AppStyle.dart';
import 'package:mechily/Models/OneDish.dart';
import 'package:mechily/Pages/FoodScreen/dish_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/route_manager.dart';

class ShowcasedDish extends StatelessWidget {
  final Dish dish;
  final EdgeInsets margin;
  final String heroTag;
  static const double height = 250;
  static const double width = 248;
  static Map getShowcased(image, name, price) => {
        'image': image,
        'name': name,
        'price': price,
      };
  const ShowcasedDish({Key key, this.margin, this.heroTag, this.dish})
      : super(key: key);
  Widget build(BuildContext context) {
    Widget daImage = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("assets/images/" + dish.image),
          fit: BoxFit.cover,
        ),
      ),
    );
    return GestureDetector(
      onTap: () {
        Get.to(DishScreen(daDish: dish));
      },
      child: Container(
        height: height,
        width: width,
        margin: margin,
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          // boxShadow: gshaded,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: heroTag != null
                  ? Hero(tag: heroTag, child: daImage)
                  : daImage,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dish.name, style: shiroText.szB.boldfont),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(dish.price.toString(),
                              style: blackText.extSzC.boldfont),
                          const SizedBox(width: 4),
                          Text(
                            "MRU",
                            style: blackText.extSzB.regfont,
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        AntDesign.star,
                        color: amber,
                      ),
                      Text(
                        "4.5",
                        style: amberText.szC.boldfont,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
