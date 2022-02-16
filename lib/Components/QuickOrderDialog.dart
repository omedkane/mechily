import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/MyIconButton.dart';
import 'package:mechily/Components/RadiusButton.dart';
import 'package:mechily/Components/SwitchIconButton.dart';
import 'package:mechily/Global/GlobalState.dart';
import 'package:mechily/Models/OneDish.dart';
import 'package:mechily/Models/OneOrder.dart';
import 'package:mechily/Pages/FoodScreen/dish_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class QuickOrderDialog extends StatelessWidget {
  final Dish dish;
  final int indexOfFavourite;
  final bool isFavourite;
  final Color primaryColor;
  final TextStyleSet primaryFontStyle;
  final RxInt quantity = 1.obs;
  final RxBool hasOrdered = false.obs;
  final void Function() listUpdatingCallback;

  QuickOrderDialog({
    Key key,
    this.dish,
    this.indexOfFavourite,
    this.listUpdatingCallback,
  })  : isFavourite = indexOfFavourite != null,
        primaryColor = dish.categories.first.color,
        primaryFontStyle = TextStyleSet(dish.categories.first.color),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * WidthFactors.dialog,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 300,
            alignment: Alignment.topRight,
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              image: DecorationImage(
                image: AssetImage("assets/images/" + dish.image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyIconButton(
                  icon: MaterialCommunityIcons.open_in_new,
                  iconColor: primaryColor,
                  onTap: () {
                    Get.to(DishScreen(
                      daDish: dish,
                    ));
                  },
                ),
                if (isFavourite)
                  SwitchIconButton(
                    iconWhenOn: MaterialCommunityIcons.heart,
                    iconWhenOff: MaterialCommunityIcons.heart_outline,
                    switchStateGetter: () =>
                        Global.store.currentUser.isDishFavourite(dish),
                    enabler: () {
                      bool hasAdded =
                          Global.store.currentUser.addFavouriteDish(dish);
                      if (hasAdded) listUpdatingCallback();
                    },
                    disabler: () {
                      bool hasRemoved = false;
                      hasRemoved = Global.store.currentUser
                          .removeFavouriteDish(index: indexOfFavourite);

                      if (hasRemoved) listUpdatingCallback?.call();
                    },
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dish.name,
                          style: blackText.extSzB.semfont,
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 4,
                          children: [
                            Text(dish.price.toString(),
                                style: blackText.extSzC.boldfont),
                            Text("MRU", style: blackText.extSzA.regfont),
                          ],
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: primaryColor.withOpacity(0.1),
                      ),
                      child: Text(dish.categories.first.name,
                          style: primaryFontStyle.extSzB.semfont),
                    )
                  ],
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 16, left: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyIconButton(
                      icon: Icons.keyboard_arrow_left,
                      sizeScale: 1.2,
                      boxShadow: gshaded,
                      iconColor: primaryColor,
                      onTap: () {
                        if (quantity.value > 1) quantity.value--;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        height: 24,
                        width: 25,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Obx(() => Text(
                                quantity.value.toString(),
                                style: primaryFontStyle.extSzD.boldfont,
                              )),
                        ),
                      ),
                    ),
                    MyIconButton(
                      icon: Icons.keyboard_arrow_right,
                      sizeScale: 1.2,
                      boxShadow: gshaded,
                      iconColor: primaryColor,
                      onTap: () {
                        quantity.value++;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Wrap(
                  spacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    SizedBox(
                      height: 53,
                      width: 100,
                      child: FittedBox(
                        alignment: Alignment.centerRight,
                        fit: BoxFit.scaleDown,
                        child: Obx(() => Text(
                            (quantity.value * dish.price).toString(),
                            style: primaryFontStyle.extSzE.boldfont)),
                      ),
                    ),
                    Text("MRU", style: primaryFontStyle.extSzB.regfont),
                  ],
                ),
              ),
              SizedBox(
                // width: 72,
                child: RadiusButton(
                  daColor: primaryColor,
                  child: Obx(
                    () => hasOrdered.value
                        ? Icon(
                            MaterialCommunityIcons.check,
                            color: Colors.white,
                          )
                        : Wrap(
                            spacing: 4,
                            children: [
                              Icon(Icons.shopping_basket, color: Colors.white),
                              Text("1", style: whiteText.extSzA.boldfont)
                            ],
                          ),
                  ),
                  onTap: () {
                    if (hasOrdered.value) return;

                    Order order = Order(dish: dish);

                    order.quantity = quantity.value;

                    Global.store.currentUser.addOrder(order);
                    hasOrdered.value = true;
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
