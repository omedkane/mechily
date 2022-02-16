import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/AnimatedIconOption.dart';
import 'package:flutter/material.dart';

class SpecialShowcasedFood extends StatefulWidget {
  final String imgUri;
  final bool isInCart;

  const SpecialShowcasedFood({Key key, this.imgUri, this.isInCart})
      : super(key: key);

  @override
  _SpecialShowcasedFoodState createState() => _SpecialShowcasedFoodState();
}

class _SpecialShowcasedFoodState extends State<SpecialShowcasedFood> {
  bool isInCart;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 400,
      decoration: BoxDecoration(
          color: Colors.tealAccent[700],
          borderRadius: BorderRadius.circular(24),
          boxShadow: ushaded),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image(
                width: 400,
                fit: BoxFit.cover,
                image: AssetImage("assets/images/" + widget.imgUri),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Spacer(),
                Column(
                  children: [
                    Text("Banana Split", style: whiteText.extSzC.boldfont),
                    SizedBox(
                      width: 100,
                      child: Stack(
                        alignment: Alignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("345", style: whiteText.extSzD.boldfont),
                          // const SizedBox(width: 8),
                          Positioned(
                              right: 0,
                              child:
                                  Text("MRU", style: whiteText.extSzA.medfont)),
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(top: 4, bottom: 8),
                      child: Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: gshaded),
                        child: AnimatedIconOption(
                          daController: IconOptionController(),
                          daIcon: Icons.shopping_basket,
                          onColor: Colors.deepOrange,
                        ),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
