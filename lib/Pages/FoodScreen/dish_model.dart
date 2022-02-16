import 'package:flutter/material.dart';
import 'package:mechily/Components/AnimatedDialog.dart';
import 'package:mechily/Dialogs/OrderedSelectionDialog.dart';
import 'package:mechily/Components/OrderedSelectionController.dart';
import 'package:mechily/Components/RatersController.dart';
import 'package:mechily/Components/SwitchButton.dart';
import 'package:mechily/Global/GlobalState.dart';
import 'package:mechily/Models/OneCondiment.dart';
import 'package:mechily/Models/OneDish.dart';
import 'package:mechily/Models/OneOrder.dart';
import 'package:mechily/Dialogs/Alert.dart';
import 'package:mechily/Models/OneResto.dart';
import 'package:mechily/Pages/FoodScreen/fs_custom_pref_dialog.dart';
import 'package:mechily/Misc/classes.dart';
import 'package:get/get.dart';

class DishScreenModel extends GetxController {
  final String restoSelectionGetID = "restoSelection";
  final String orderMakerGetID = "orderMaker";

  Order daOrder;
  // * Controllers -->
  OrderedSelectionController<Resto> restoSelectionCtrl;
  RatersController ratersController = Get.put(
    RatersController(
      trueRating: 1,
      hasRated: false,
      onPublished: () {
        print("oulala");
      },
    ),
  );
  AnimatedRevealerController myCommentRevealer = AnimatedRevealerController();
  FsCustomPrefDialogController customPrefController;
  SwitchButtonController otherPrefSwitchController;
  SwitchButtonController closestRestoSwitchController;
  SwitchButtonController moreRestoSwitchController;
  Counter moreRestoSelectionCount = Counter();
  // * -->

  // * Data -->
  final Dish dish;
  int highestPrice;

  List<IO<Map<String, Condiment>>> listOfCondiments = [];

  List<OrderedSelectionMember<Resto>> popularRestos;

  List<OrderedSelectionMember<Resto>> otherRestos;

  Map<String, int> addedRestosIndexes = {};
  // * -->

  @override
  onClose() {
    daOrder.detachAllComponents();
    super.onClose();
  }

// * Constructor -->
  DishScreenModel(this.dish) {
    void Function() quantityViewUpdater = () {
      update([orderMakerGetID]);
    };
    this.daOrder = new Order(dish: dish);

    this.daOrder.attachComponents([
      OrderGetIDs.quantity,
      OrderGetIDs.unitPrice,
      OrderGetIDs.restos,
    ], quantityViewUpdater);

    this.highestPrice = dish.price;

    dish.condimentGroup?.members?.forEach((condiment) {
      listOfCondiments.add(
        IO(
          {'condiment': condiment},
          id: condiment.id,
          isSelected: true,
        ),
      );
    });

    // -> Controllers !
    this.restoSelectionCtrl = new OrderedSelectionController<Resto>(
      listOfTriggers: {
        OrderGetIDs.quantity: () {
          update([restoSelectionGetID]);
        }
      },
      onSelection: (member) {
        closestRestoSwitchController.disableMe();
        refreshTotalPrice();
        update([restoSelectionGetID]);
      },
      onUnselection: (member) {
        refreshTotalPrice();
        update([restoSelectionGetID]);
      },
      onEmptySelection: () {
        closestRestoSwitchController.enableMe();
        moreRestoSelectionCount.reset();
        updateMoreRestoSwitchButtonText();
      },
    );

    this.otherPrefSwitchController = SwitchButtonController(
        initiallySelected: false,
        initiallyFrozen: true,
        onTap: () {
          openPrefDialog(Get.context);
        });

    this.customPrefController = new FsCustomPrefDialogController(
      onExit: () {
        if (customPrefController.hasSubmitted) {
          otherPrefSwitchController.enableMe();
        } else {
          otherPrefSwitchController.disableMe();
        }
      },
    );
    this.closestRestoSwitchController = SwitchButtonController(
      initiallySelected: true,
      onEnabled: () {
        restoSelectionCtrl.disableAllSelections();
        closestRestoSwitchController.freezeMe();
      },
      onDisabled: () {
        closestRestoSwitchController.unfreezeMe();
      },
    );
    this.moreRestoSwitchController = SwitchButtonController(
      onTap: showMoreRestaurants,
      initiallyFrozen: true,
    );
    // -<

    // -> OrderedSelection !

    this.popularRestos = Global.store.topFourPopularRestos.map((Resto resto) {
      return getRestoSelectionMember(resto);
    }).toList();

    this.otherRestos = Global.store.lessPopularRestos.map((Resto resto) {
      return getRestoSelectionMember(resto);
    }).toList();
    // -<
  }

// * -->

  OrderedSelectionMember<Resto> getRestoSelectionMember(Resto resto) {
    final int price = dish.getPriceFrom(resto.id);
    final bool priceAvailable = price != null;

    // ->
    return OrderedSelectionMember<Resto>(
      controller: restoSelectionCtrl,
      payload: resto,
      isSelected: false,
      title: resto.name,
      extraWidget1: !priceAvailable
          ? null
          : (bgColor, textStyles) =>
              Text("$price", style: textStyles.extSzB.semfont),
      extraWidget2: !priceAvailable
          ? null
          : (bgColor, textStyles) =>
              Text("MRU", style: textStyles.extSzA.regfont),
    );
    // -<
  }

  void refreshTotalPrice() {
    List<OrderedSelectionMember<Resto>> selectedMembers =
        restoSelectionCtrl.getSelectedMembers();

    // int __oldHighestPrice = highestPrice;
    int __highestPrice = 0;

    selectedMembers.forEach((member) {
      int restoPrice = dish.getPriceFrom(member.payload.id);

      if (restoPrice != null && restoPrice > __highestPrice) {
        __highestPrice = restoPrice;
      }
    });

    __highestPrice = __highestPrice > 0 ? __highestPrice : dish.price;

    if (highestPrice != __highestPrice) {
      highestPrice = __highestPrice;
      update([orderMakerGetID]);
    }
  }

  get totalPrice => daOrder.quantity * highestPrice;

  // RxBool hasCommented = false.obs;

  Future openPrefDialog(daContext) async {
    await AnimatedDialog.show(
      child: FsCustomPrefDialog(
        dialogController: customPrefController,
      ),
    );
    customPrefController.onExit?.call();
  }

  void updateMoreRestoSwitchButtonText() {
    if (moreRestoSelectionCount.count > 0) {
      moreRestoSwitchController.setShowcasedText(
        text: moreRestoSelectionCount.count.toString(),
      );
    } else
      moreRestoSwitchController.setShowcasedText();
  }

  void showMoreRestaurants() async {
    await AnimatedDialog.show(
      child: OrderedSelectionDialog<DishScreenModel>(
        listOfChoices: otherRestos,
        getBuilderId: restoSelectionGetID,
        selectionCount: moreRestoSelectionCount,
      ),
    );
    updateMoreRestoSwitchButtonText();
  }

  void submitOrder() {
    daOrder..dislikedCondiments.clear()..preferedRestos.clear();

    //- TODO: Submit Custom Condiments Preferences

    daOrder.customCondimentsPreference = customPrefController.submittedText;

    //- TODO: Submit Condiments Preferences

    listOfCondiments.forEach((IO condimentIO) {
      Condiment condiment = condimentIO.data['condiment'];
      if (!condimentIO.isSelected) {
        daOrder.dislikedCondiments.add(condiment);
      }
    });

    //- TODO: Submit RestoChoice
    if (closestRestoSwitchController.isSelected)
      daOrder.fastDelivery = true;
    else {
      List<Resto> preferedRestos = [];

      restoSelectionCtrl
          .getListOrderedByRank()
          .forEach((OrderedSelectionMember resto) {
        if (resto.isSelected) {
          preferedRestos.add(resto.payload);
          print("${resto.title}: ${resto.rank}");
        }
      });
      daOrder.preferedRestos = preferedRestos;
    }
    // daOrder.refreshHighestPrice();
    daOrder.dateAddedToBasket = DateTime.now();
    daOrder.refreshHighestPrice();

    Global.store.currentUser.addOrder(daOrder);

    Alert.alert("Ajouté avec succés !");
  }
}
