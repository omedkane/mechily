import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/ScreenTitle.dart';
import 'package:mechily/Components/SimpleNotice.dart';
import 'package:mechily/Global/GlobalState.dart';
import 'package:mechily/Misc/functions.dart';
import 'package:mechily/Pages/BasketScreen/BasketItem.dart';
import 'package:mechily/Pages/SettingsScreen/Subscreens/DateBox.dart';
import 'package:mechily/Pages/SettingsScreen/Subscreens/history_model.dart';

class HistoryScreen extends StatelessWidget {
  final deliveredOrders = Global.store.currentUser.deliveredOrders;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryScreenModel>(
      init: HistoryScreenModel(),
      builder: (model) {
        return Scaffold(
          body: CustomScrollView(
            // shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: AppPaddings.screen,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ScreenTitle(title: "Historique"),
                          const SizedBox(height: Spaces.titleToWidget),
                          Text("Choisir une date:",
                              style: blackText.szC.medfont),
                          Padding(
                            padding: const EdgeInsets.only(top: 4, bottom: 16),
                            child: Builder(
                              builder: (_) {
                                DateTime dateTime = DateTime.now();
                                int day = dateTime.day;
                                String weekday =
                                    DateBox.daysInFrench[dateTime.weekday];
                                String monthName =
                                    DateBox.monthsInFrench[dateTime.month];
                                return Text(
                                  "Aujourd'hui, Le $weekday $day $monthName",
                                  style: shiroText.szC.regfont,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 110,
                      child: Builder(
                        builder: (context) {
                          int lastMonth;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            clipBehavior: Clip.none,
                            itemCount: deliveredOrders.length,
                            itemBuilder: (context, index) {
                              int reversedIndex =
                                  reverseIndex(deliveredOrders, index);
                              int timestamp = model.listOfStamps[reversedIndex];
                              DateTime dateTime =
                                  DateTime.fromMillisecondsSinceEpoch(
                                      timestamp);
                              bool isSelected =
                                  reversedIndex == model.selectedIndex;
                              bool isNewMonth = lastMonth == null ||
                                  (dateTime.month != lastMonth);

                              lastMonth = dateTime.month;
                              DateBox dateBox = DateBox(
                                isSelected: isSelected,
                                date: dateTime,
                                onTap: () {
                                  model.selectDate(reversedIndex);
                                },
                              );
                              Widget displayedWidget = !isNewMonth
                                  ? dateBox
                                  : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            DateBox
                                                .monthsInFrench[dateTime.month]
                                                .capitalizeFirst,
                                            style: (isSelected
                                                    ? shiroText
                                                    : blackText)
                                                .szB
                                                .medfont),
                                        const SizedBox(height: 8),
                                        dateBox
                                      ],
                                    );
                              return Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 16,
                                      right: reversedIndex == 9 ? 16 : 0),
                                  child: displayedWidget,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SimpleNotice(
                      text: "Appuyez plus longtemps pour pouvoir commander !",
                      margin:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                    ),
                  ],
                ),
              ),
              if (model.selectedList != null)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      List orderList = model.selectedList;
                      int reversedIndex = reverseIndex(orderList, index);
                      return Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: BasketItem(
                          order: orderList[reversedIndex],
                          onTap: (order) {
                            model.showOrderDetails(order);
                          },
                          onLongPress: (order) {
                            model.showOrderDetails(order, canOrder: true);
                          },
                        ),
                      );
                    },
                    childCount: model.selectedList.length,
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
