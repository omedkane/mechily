import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/CircledIcon.dart';
import 'package:mechily/Components/SwitchIconButton.dart';
import 'package:mechily/Components/MyIconButton.dart';
import 'package:mechily/Components/QuickOption.dart';
import 'package:mechily/Components/RadiusButton.dart';
import 'package:mechily/Components/SweetTitle.dart';
import 'package:mechily/Misc/functions.dart';
import 'package:mechily/Models/OneOrder.dart';
import 'package:mechily/Models/OneResto.dart';
import 'package:mechily/Pages/BasketScreen/DetailsDialogModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class OrderDetailsDialog extends StatelessWidget {
  final DetailsDialogModel model;

  OrderDetailsDialog({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return GetBuilder<DetailsDialogModel>(
      init: model,
      builder: (model) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: screenHeight * 0.9),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 4, left: 4, right: 4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 300,
                          alignment: Alignment.topRight,
                          clipBehavior: Clip.hardEdge,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/images/" + model.order.dish.image),
                            ),
                          ),
                          child: model.canAddToPreset
                              ? SwitchIconButton(
                                  iconWhenOff: MaterialCommunityIcons
                                      .content_save_outline,
                                  iconWhenOn:
                                      MaterialCommunityIcons.content_save,
                                  boxColorWhenOn: amber,
                                  switchStateGetter: () => model.hasAddedPreset,
                                  enabler: model.addPreset,
                                  disabler: model.removePreset,
                                )
                              : null,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 16),
                                      Text(model.order.dish.name,
                                          style: blackText.extSzC.semfont),
                                      const SizedBox(height: 8),
                                      GetBuilder<DetailsDialogModel>(
                                        id: model.unitPriceGetID,
                                        builder: (_) {
                                          return Row(
                                            children: [
                                              Text(
                                                "PU: ",
                                                style: blackText.szB.regfont,
                                              ),
                                              const SizedBox(width: 8),
                                              Wrap(
                                                spacing: 4,
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.end,
                                                children: [
                                                  Text(
                                                    model.tempOrder.unitPrice
                                                        .toString(),
                                                    style: blackText
                                                        .extSzC.boldfont,
                                                  ),
                                                  Text(
                                                    "MRU",
                                                    style:
                                                        blackText.szA.regfont,
                                                  )
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const SizedBox(height: 14),
                                      SweetTitle(
                                        text: model
                                            .order.dish.categories.first.name,
                                        primaryColor: model
                                            .order.dish.categories.first.color,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text(
                                            model.isPreset
                                                ? "Créé le:"
                                                : "Ajouté le:",
                                          ),
                                          const SizedBox(width: 8),
                                          Builder(
                                            builder: (context) {
                                              var date = model.isPreset
                                                      ? model.preset.dateCreated
                                                      : model.tempOrder
                                                          .dateAddedToBasket,
                                                  day = padZero(date.day),
                                                  month = padZero(date.month),
                                                  hour = padZero(date.hour),
                                                  minute = padZero(date.minute);

                                              return Text(
                                                "$day/$month ${hour}h:$minute",
                                                style: blackText.extSzB.semfont,
                                              );
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              if (model.isQuickOrder)
                                SweetTitle(
                                  text: "Commande Rapide",
                                  primaryColor: midori,
                                  // boldColor: true,
                                ),
                              if (model.shouldDisplayCondiments)
                                GetBuilder<DetailsDialogModel>(
                                  id: model.condimentsListGetID,
                                  builder: (_) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        model.tempOrder.dislikedCondiments
                                                    .length !=
                                                0
                                            ? Text(
                                                "Vous ne voulez pas de :",
                                                style: shiroText.szC.medfont,
                                              )
                                            : Text(
                                                "Préferences :",
                                                style: orangeText.szC.medfont,
                                              ),
                                        const SizedBox(height: 12),
                                        Wrap(
                                          spacing: 16,
                                          runSpacing: 8,
                                          children: List.generate(
                                              model.tempOrder.dislikedCondiments
                                                  .length, (index) {
                                            String pref = model.tempOrder
                                                .dislikedCondiments[index].name;
                                            return QuickOption(
                                              color: shiro,
                                              title: pref,
                                              isDisabled:
                                                  !model.orderAuthorized,
                                              onIconTap: () {
                                                model.removeCondiment(index);
                                              },
                                            );
                                          }),
                                        ),
                                        if (model.tempOrder
                                                    .customCondimentsPreference !=
                                                null &&
                                            model.tempOrder
                                                    .customCondimentsPreference
                                                    .trim()
                                                    .length >
                                                0 &&
                                            !model.shouldDeleteCustomPref) ...[
                                          const SizedBox(height: 16),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: Icon(
                                                  MaterialCommunityIcons.pen,
                                                  color: Colors.deepOrange,
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 16,
                                                    bottom: 16,
                                                    left: 16,
                                                    right: 8),
                                                decoration: BoxDecoration(
                                                  color: Colors.deepOrange,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  // boxShadow: gshaded,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      model.tempOrder
                                                          .customCondimentsPreference,
                                                      style:
                                                          whiteText.szC.semfont,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    GestureDetector(
                                                      onTap: model
                                                          .setUpCustomPreferenceDeletion,
                                                      child: CircledIcon(
                                                        icon:
                                                            MaterialCommunityIcons
                                                                .close,
                                                        color:
                                                            Colors.deepOrange,
                                                        size: CircledIconSize
                                                            .small,
                                                        colorStyle:
                                                            CircledIconColorStyle
                                                                .white,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]
                                      ],
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // const SizedBox(height: 16),
                  if (model.shouldDisplayRestaurants)
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Restaurants :",
                            style: aoiText.szC.medfont,
                          ),
                          const SizedBox(height: 16),
                          GetBuilder<DetailsDialogModel>(
                            id: model.restaurantsListGetID,
                            builder: (model) {
                              return Wrap(
                                spacing: 16,
                                runSpacing: 8,
                                children: List.generate(
                                    model.tempOrder.preferedRestos.length,
                                    (index) {
                                  Resto resto =
                                      model.tempOrder.preferedRestos[index];
                                  dynamic price = model.tempOrder.dish
                                      .getPriceFrom(resto.id);
                                  price = (price != null) ? " ( $price )" : "";
                                  return QuickOption(
                                    color: aoi,
                                    title: "${index + 1} - ${resto.name}$price",
                                    isDisabled: !model.orderAuthorized,
                                    onIconTap: () {
                                      model.removeRestaurant(index);
                                    },
                                  );
                                }),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (model.orderAuthorized)
                              // * Quantity Control -->
                              GetBuilder<DetailsDialogModel>(
                                id: model.quantityControlGetID,
                                builder: (_) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      MyIconButton(
                                        boxShadow: gshaded,
                                        iconColor: Colors.black,
                                        icon:
                                            MaterialCommunityIcons.chevron_left,
                                        onTap: model.tempOrder.decreaseQty,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Text(
                                          model.tempOrder.quantity.toString(),
                                          style: blackText.extSzC.boldfont,
                                        ),
                                      ),
                                      MyIconButton(
                                        boxShadow: gshaded,
                                        iconColor: Colors.black,
                                        icon: MaterialCommunityIcons
                                            .chevron_right,
                                        onTap: model.tempOrder.increaseQty,
                                      ),
                                    ],
                                  );
                                },
                              )
                            // * -->
                            else if (model.order.state ==
                                OrderState.delivered) ...[
                              const SizedBox(width: 8),
                              Text("Quantité:",
                                  style: blackText.extSzC.regfont),
                              const SizedBox(width: 4),
                              Text(model.tempOrder.quantity.toString(),
                                  style: blackText.extSzC.semfont),
                              SizedBox(
                                width: 16,
                              )
                            ],
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: 50,
                                  minHeight: 50,
                                  maxWidth: 80,
                                ),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: GetBuilder<DetailsDialogModel>(
                                    id: model.totalPriceGetID,
                                    builder: (_) {
                                      return Text(
                                        model.tempOrder.totalPrice.toString(),
                                        style: blackText.extSzC.semfont,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Text("MRU", style: blackText.szB.regfont)
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (model.orderAuthorized)
                        if (model.shouldOrderRatherThanModify)
                          RadiusButton(
                            daColor: aoi,
                            title: "Au panier",
                            onTap: model.submitOrder,
                          )
                        else
                          RadiusButton(
                            daColor: aoi,
                            title: "Modifier",
                            onTap: model.submitChanges,
                          )
                      else if (model.order.state == OrderState.delivered)
                        Padding(
                          padding: const EdgeInsets.only(right: 16, bottom: 8),
                          child: Row(
                            children: [
                              CircledIcon(
                                color: midori,
                                icon: MaterialCommunityIcons.check_all,
                                size: CircledIconSize.medium,
                              ),
                              const SizedBox(width: 8),
                              Text("Livrée", style: midoriText.szB.medfont),
                            ],
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
