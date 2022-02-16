import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/RadiusButton.dart';
import 'package:mechily/Components/SweetTitle.dart';
import 'package:mechily/Misc/functions.dart';
import 'package:mechily/Models/OneOrder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class BasketItem extends StatelessWidget {
  final Order order;
  final void Function(Order) onTap, onLongPress;
  final Function remover;

  const BasketItem(
      {Key key, this.order, this.onTap, this.remover, this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 154,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: gshaded,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            onTap?.call(order);
          },
          onLongPress: () {
            onLongPress?.call(order);
          },
          splashColor: shiro.withOpacity(0.2),
          child: Row(
            children: [
              FractionallySizedBox(
                heightFactor: 1,
                child: Container(
                  width: 154,
                  margin: const EdgeInsets.only(
                      left: 8, top: 8, bottom: 8, right: 16),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    boxShadow: gshaded,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/" + order.dish.image),
                  ),
                ),
              ),
              // const SizedBox(width: 16),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cutText(order.dish.name, 18),
                        style: blackText.szB.boldfont.apply(heightDelta: 0.3),
                        // softWrap: true,
                      ),

                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          Container(
                            height: 40,
                            constraints: BoxConstraints(maxWidth: 100),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(order.totalPrice.toString(),
                                  style: blackText.extSzD.boldfont),
                            ),
                          ),
                          Text("MRU", style: blackText.szB.regfont)
                        ],
                      ),
                      // const SizedBox(height: 8),
                      Row(
                        children: [
                          Text("Quantité:", style: blackText.szB.regfont),
                          const SizedBox(width: 4),
                          Text(order.quantity.toString(),
                              style: blackText.szB.boldfont),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12, top: 8),
                    child: SweetTitle(
                      text: cutText(order.dish.categories.first.name, 9),
                      primaryColor: order.dish.categories.first.color,
                    ),
                  ),
                  if (order.state == OrderState.pending)
                    RadiusButton(
                      daColor: shiro,
                      child: Icon(
                        MaterialCommunityIcons.trash_can_outline,
                        color: Colors.white,
                      ),
                      onTap: remover,
                    )
                  else if (order.state == OrderState.delivered)
                    Builder(
                      builder: (context) {
                        int hour = order.deliveryDate.hour;
                        int minute = order.deliveryDate.minute;

                        return Padding(
                          padding: const EdgeInsets.only(right: 16, bottom: 16),
                          child: Text(
                            "${hour}h : $minute",
                            style: greyText.extSzC.medfont,
                          ),
                        );
                      },
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
