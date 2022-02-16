// import 'package:mechily/AppStyle.dart';
// import 'package:mechily/Components/QuantityChangingDialog.dart';
// import 'package:mechily/Components/RadiusButton.dart';
// import 'package:mechily/Global/OneBasketItem.dart';
// import 'package:mechily/Misc/misc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:get/get.dart';

// enum daOrderIs { pending, inDelivery, delivered }

// class BasketItemController {
//   final int foodPrice;
//   final RxInt foodQty;

//   BasketItemController(this.foodPrice, int daQty) : foodQty = daQty.obs;
// }

// class BasketItem extends StatelessWidget {
//   final EdgeInsetsGeometry margin;
//   final bool isModifiable;
//   final daOrderIs orderState;
//   // final int foodPrice, foodQty;
//   final OneBasketItem daItem;

//   const BasketItem({
//     Key key,
//     this.margin,
//     this.isModifiable = true,
//     this.orderState,
//     this.daItem,
//   })  : assert(isModifiable || orderState != null),
//         super(key: key);

//   Future<void> changeItemQty(BuildContext context) async {
//     QCDialogController _qcdController = QCDialogController(
//         qty: daItem.basketCtrl.foodQty.value,
//         originalPrice: daItem.basketCtrl.foodPrice);
//     await AnimatedDialog.show(
//       child: QuantityChangingDialog(
//         foodName: "Wrap Poulet",
//         daController: _qcdController,
//       ),
//     );
//     if (_qcdController.isSubmitted) {
//       daItem.basketCtrl.foodQty.value = _qcdController.daQty.value;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // double screenWidth = MediaQuery.of(context).size.width;
//     var daChild = Padding(
//       padding: EdgeInsets.only(left: 8),
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             margin: const EdgeInsets.only(top: 16, bottom: 16),
//             height: 118,
//             width: 118,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               image: DecorationImage(
//                 image: daItem.foodImage,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 16, top: 24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(daItem.foodName, style: shirotext.szB.medfont),
//                 const SizedBox(height: 16),
//                 Obx(() => Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                                 (daItem.basketCtrl.foodPrice *
//                                         daItem.basketCtrl.foodQty.value)
//                                     .toString(),
//                                 style: blacktext.extSzE.boldfont
//                                     .apply(fontSizeDelta: -8)),
//                             const SizedBox(width: 4),
//                             Text("MRU", style: blacktext.szB.regfont),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Text("QTY:", style: blacktext.szA.regfont),
//                             const SizedBox(width: 8),
//                             Text(
//                                 "x" +
//                                     daItem.basketCtrl.foodQty.value.toString(),
//                                 style: shirotext.extSzC.semfont),
//                           ],
//                         ),
//                       ],
//                     )),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Container(
//               child: Column(
//                 mainAxisAlignment: isModifiable
//                     ? MainAxisAlignment.start
//                     : MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.only(right: 8, top: 8),
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
//                     child: Text("Repas", style: mustardtext.szA.regfont),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         // color: oolo,
//                         border: Border.all(color: mustard, width: 1)),
//                   ),
//                   Padding(
//                     padding: isModifiable
//                         ? const EdgeInsets.only(right: 16, top: 24)
//                         : const EdgeInsets.only(right: 16),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text("PU: ", style: greytext.szB.regfont),
//                         Text(daItem.basketCtrl.foodPrice.toString(),
//                             style: greytext.extSzB.semfont),
//                       ],
//                     ),
//                   ),
//                   if (!isModifiable)
//                     Padding(
//                       padding: const EdgeInsets.only(right: 16, bottom: 16),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           if (orderState == daOrderIs.delivered)
//                             Text("Livrée", style: midoritext.szA.regfont)
//                           else if (orderState == daOrderIs.inDelivery)
//                             Text("En attente", style: aoitext.szA.regfont),
//                           // ------
//                           const SizedBox(width: 4),
//                           Icon(
//                             (orderState == daOrderIs.delivered)
//                                 ? MaterialCommunityIcons.check_all
//                                 : MaterialCommunityIcons.history,
//                             color: (orderState == daOrderIs.delivered)
//                                 ? midori
//                                 : aoi,
//                             size: 18,
//                           )
//                         ],
//                       ),
//                     )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//     return Center(
//       child: Container(
//         alignment: Alignment.center,
//         margin: margin,
//         height: 160,
//         // width: screenWidth - 32,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           color: Colors.white,
//           boxShadow: gshaded,
//         ),
//         child: Stack(
//           children: [
//             !isModifiable
//                 ? daChild
//                 : Material(
//                     color: Colors.white,
//                     child: InkWell(
//                       onTap: () {
//                         changeItemQty(context);
//                       },
//                       child: daChild,
//                     ),
//                   ),
//             if (isModifiable)
//               Positioned(
//                 bottom: 0,
//                 right: 0,
//                 child: RadiusButton(
//                   daColor: shiro,
//                   child: Icon(Icons.delete_outline, color: Colors.white),
//                   onTap: () {
//                     // TODO: Remove basket item
//                     print("remove basket item");
//                   },
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
