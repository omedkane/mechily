import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/AnimatedDialog.dart';
import 'package:mechily/Dialogs/CustomInputDialog.dart';
import 'package:mechily/Global/GlobalState.dart';
import 'package:mechily/Models/OneOrder.dart';
import 'package:mechily/Dialogs/Alert.dart';
import 'package:mechily/Models/OnePreset.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class DetailsDialogModel extends GetxController {
  final Order order;
  final bool isPreset;
  final Preset preset;
  final int presetIndex;
  final void Function() onSubmit;
  final void Function() listUpdatingCallback;
  final bool orderAuthorized;
  final bool isDelivered;
  Order tempOrder;

  int currentPresetIndex;
  bool shouldDeleteCustomPref = false;
  bool hasModifiedCondiments = false, hasModifiedRestaurants = false;

  final String totalPriceGetID = "totalPrice",
      quantityControlGetID = "qtyControl",
      restaurantsListGetID = "restos",
      condimentsListGetID = "condiments",
      unitPriceGetID = "unitary";

  DetailsDialogModel(
    Order order, {
    this.onSubmit,
    this.preset,
    this.presetIndex,
    this.listUpdatingCallback,
    bool canOrder = false,
  })  : order = order ?? preset.toOrder(),
        isPreset = preset != null,
        isDelivered = order.state == OrderState.delivered,
        orderAuthorized = (order.state == OrderState.pending) || canOrder,
        currentPresetIndex = presetIndex {
    //
    assert(isPreset == (presetIndex != null));
    //
    if (orderAuthorized) {
      tempOrder = Order(dish: order.dish, listOfTriggers: {
        OrderGetIDs.restos: () {
          if (!shouldDisplayRestaurants)
            update();
          else
            update([
              restaurantsListGetID,
              unitPriceGetID,
              quantityControlGetID,
              totalPriceGetID
            ]);
        },
        OrderGetIDs.quantity: () {
          update([quantityControlGetID, totalPriceGetID]);
        },
        OrderGetIDs.condiments: () {
          if (!shouldDisplayCondiments)
            update();
          else
            update([condimentsListGetID]);
        }
      });
      tempOrder
        ..dislikedCondiments = [...order.dislikedCondiments]
        ..preferedRestos = [...order.preferedRestos]
        ..quantity = order.quantity
        ..dateAddedToBasket = order.dateAddedToBasket
        ..fastDelivery = order.fastDelivery;
    } else
      tempOrder = order;
  }

  bool get dislikesAvailable => tempOrder.dislikedCondiments.length != 0;

  bool get preferedRestosAvailable => tempOrder.preferedRestos.length != 0;

  bool get customPrefAvailable =>
      (order.customCondimentsPreference?.length ?? 0) != 0;

  bool get shouldDisplayCondiments =>
      dislikesAvailable || (customPrefAvailable && !shouldDeleteCustomPref);

  bool get shouldDisplayRestaurants => tempOrder.preferedRestos.length != 0;

  bool get shouldOrderRatherThanModify => isPreset || isDelivered;

  bool get canAddToPreset {
    bool isQuickOrder = order.isQuickOrder;

    return !isQuickOrder &&
        (dislikesAvailable || customPrefAvailable || preferedRestosAvailable);
  }

  bool get isQuickOrder =>
      order.isQuickOrder ||
      (!dislikesAvailable && !customPrefAvailable && !preferedRestosAvailable);

  void removeCondiment(int index) {
    tempOrder.removeFromDislikes(index);
    hasModifiedCondiments = true;
  }

  void removeRestaurant(int index) {
    tempOrder.removeRestaurant(index);

    hasModifiedRestaurants = true;
  }

  void setUpCustomPreferenceDeletion() {
    shouldDeleteCustomPref = true;
    print("shouldDeleteCustomPref $shouldDeleteCustomPref");
    update([condimentsListGetID]);
  }

  void submitChanges() {
    if (isDelivered) return;

    // TODO: Condiments
    if (hasModifiedCondiments)
      order.dislikedCondiments
        ..clear()
        ..addAll(tempOrder.dislikedCondiments);
    // TODO: Custom Condiments
    if (shouldDeleteCustomPref) order.customCondimentsPreference = null;
    // TODO: Restaurants
    if (hasModifiedRestaurants) order.preferedRestos = tempOrder.preferedRestos;
    // TODO: Quantity
    order.quantity = tempOrder.quantity;

    onSubmit?.call();
    Alert.alert("Enregistrée !", onExit: () {
      Get.back();
    });
  }

  bool removePreset() {
    if (!hasAddedPreset) return false;
    bool presetRemoved = false;
    if (isPreset) {
      presetRemoved = Global.store.currentUser.removePreset(presetIndex);
      Get.back();
    } else
      presetRemoved = Global.store.currentUser.removePreset(currentPresetIndex);

    currentPresetIndex = null;

    listUpdatingCallback?.call();

    return presetRemoved;
  }

  void submitOrder() {
    Global.store.currentUser.addOrder(tempOrder);

    Alert.alert("Ajouté au panier !", type: AlertType.success);
  }

  get hasAddedPreset => currentPresetIndex != null;

  Future<bool> addPreset() async {
    await AnimatedDialog.show(
        child: CustomInputDialog(
      icon: MaterialCommunityIcons.content_save,
      isTextArea: false,
      primaryColor: amber,
      title: "Prédéfinie",
      initialText: "${tempOrder.quantity}x - ${order.dish.name}",
      textInputHint: "Saisir le nom de la commande",
      maxTextLength: 32,
      minTextLength: 5,
      notice: "Saisir un nom pour la commande prédéfinie",
      onSubmit: (text) {
        Global.store.currentUser.addPreset(text, tempOrder);
        currentPresetIndex = Global.store.currentUser.presets.length - 1;
      },
    ));
    return hasAddedPreset;
  }
}
