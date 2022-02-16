import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/AnimatedTopTabBar.dart';
import 'package:mechily/Components/MyIconButton.dart';
import 'package:mechily/Components/RadiusButtonAsync.dart';
import 'package:mechily/Components/SweetTitle.dart';
import 'package:mechily/Global/GlobalState.dart';
import 'package:mechily/Misc/classes.dart';
import 'package:mechily/Misc/enums.dart';
import 'package:mechily/Models/OneOrder.dart';
import 'package:mechily/Models/OneUser.dart';
import 'package:mechily/Navigation/FrontPage.dart';
import 'package:mechily/Pages/BasketScreen/BasketItem.dart';
import 'package:mechily/Pages/BasketScreen/basket_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

// ignore: non_constant_identifier_names
FrontPage BasketScreenBuilder() {
  final BasketScreenModel model = BasketScreenModel();
  return BasketScreen(
    model: model,
  );
}

class BasketScreen extends StatelessWidget with FrontPage {
  final BasketScreenModel model;
  final Widget extraWidget;
  final revealerRemote = AnimatedRevealerController();

  BasketScreen({Key key, this.model})
      : extraWidget = MyIconButton(
          icon: MaterialCommunityIcons.check_all,
          iconColor: Colors.white,
          bgColor: midori,
          boxShadow: hoverShaded,
          onTap: model.submitAllOrders,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    print("whole shit rebuilt");
    User user = Global.store.currentUser;
    return GetBuilder<BasketScreenModel>(
      init: model,
      dispose: (_) {
        Get.delete<BasketScreenModel>();
      },
      builder: (model) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: Spaces.statusBarToTitle),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mon", style: blackText.szC.medfont),
                        Text(
                          "Panier",
                          style: shiroText.extSzD.boldfont,
                        ),
                        GetBuilder<Global>(
                          id: User.userInfoGetID,
                          builder: (_) {
                            bool gpsRecorded =
                                Global.store.currentUser.isPositionTemporary;

                            Color primaryColor =
                                gpsRecorded ? Colors.white : shiro;
                            Color secondaryColor =
                                gpsRecorded ? shiro : Colors.white;
                            TextStyleSet textStyleSet =
                                gpsRecorded ? shiroText : whiteText;

                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(top: 24),
                              padding:
                                  EdgeInsets.only(top: 16, left: 16, right: 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: ushaded,
                                color: primaryColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Adresse :",
                                      style: textStyleSet.szC.boldfont),
                                  Text(
                                    "Vérifier vos coordonnées avant de commander !",
                                    style: textStyleSet.szB.regfontH,
                                  ),
                                  Center(
                                    child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        const SizedBox(height: 16),
                                        Text(
                                          user.address,
                                          style:
                                              textStyleSet.szD.boldfont.apply(
                                            fontSizeDelta: 2,
                                            decoration: gpsRecorded
                                                ? TextDecoration.lineThrough
                                                : null,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text("+(222) ${user.phoneNumber}",
                                            style: textStyleSet.szB.medfont),
                                      ],
                                    ),
                                  ),
                                  RadiusButtonAsync(
                                    daColor: secondaryColor,
                                    // rightAligned: true,
                                    child: Icon(
                                      Icons.edit_location,
                                      color: primaryColor,
                                    ),
                                    onTap: model.switchAddress,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Text(
                              "Appuyez sur une commande pour modifier la quantité",
                              style:
                                  aoiText.szC.regfont.apply(heightDelta: 0.3),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: AnimatedTopTabBar<OrderState>(
                alignment: Alignment.topCenter,
                tabMap: model.tabMap,
                onTabChanged: model.setDisplayedOrderListIndex,
                initialPageKey: model.displayedOrderList,
              ),
            ),
            SliverToBoxAdapter(
              child: const SizedBox(height: 24),
            ),
            GetBuilder<BasketScreenModel>(
              id: model.orderListGetID,
              builder: (_) {
                var displayedList =
                    model.orderMap[model.displayedOrderList]?.call();
                return displayedList.length == 0
                    ? SliverToBoxAdapter(
                        child: Center(
                          heightFactor: 2,
                          child: SweetTitle(
                            size: Sizes.normal,
                            text: "Aucune commande, veuillez en faire !",
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(top: index == 0 ? 0 : 24),
                              child: BasketItem(
                                order: displayedList[index],
                                onTap: (order) {
                                  model.showOrderDetails(order);
                                },
                                remover: () {
                                  model.removeOrder(index);
                                },
                              ),
                            );
                          },
                          childCount: displayedList.length,
                        ),
                      );
              },
            ),
            SliverToBoxAdapter(
              child: const SizedBox(height: 100),
            ),
          ],
        );
      },
    );
  }
}
