import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/AnimatedDialog.dart';
import 'package:mechily/Dialogs/Alert.dart';
import 'package:mechily/Dialogs/YesNoDialog.dart';
import 'package:mechily/Global/GlobalState.dart';
import 'package:mechily/Misc/classes.dart';
import 'package:mechily/Models/OneOrder.dart';
import 'package:mechily/Pages/BasketScreen/DetailsDialogModel.dart';
import 'package:mechily/Pages/BasketScreen/OrderDetailsDialog.dart';
import 'package:get/get.dart';

class BasketScreenModel extends GetxController {
  String orderListGetID = "orders";

  OrderState displayedOrderList = OrderState.pending;

  Map<String, OrderState> tabMap = {
    "En attente": OrderState.pending,
    "En livraison": OrderState.inDelivery,
    "Livrée": OrderState.delivered,
  };

  Map<OrderState, List<Order> Function()> orderMap = {
    OrderState.pending: () => Global.store.currentUser.orders,
    OrderState.inDelivery: () => [],
    OrderState.delivered: () => Global.store.currentUser.todayDeliveredOrders,
  };

  void setDisplayedOrderListIndex(state) {
    print(state);
    displayedOrderList = state;
    update([orderListGetID]);
  }

  void showOrderDetails(Order order) {
    DetailsDialogModel detailsDialogModel =
        DetailsDialogModel(order, onSubmit: () {
      update([orderListGetID]);
    });
    AnimatedDialog.show(
      child: OrderDetailsDialog(
        model: detailsDialogModel,
      ),
    );
  }

  void removeOrder(int index) {
    YesNoDialog.alert(
        message: "Êtes-vous sur de vouloir retirer cette commande ?",
        title: "Retirer",
        onYes: () {
          Global.store.currentUser.orders.removeAt(index);
          update([orderListGetID]);
        });
  }

  void submitAllOrders() {
    if (Global.store.currentUser.orders.length != 0) {
      YesNoDialog.alert(
        message: "Voulez-vous placer cette commande ?",
        notice:
            "Notez que le prix des plats peut changer en fonction de leur disponibilité dans les restaurants !",
        title: "Commande",
        color: midori,
        onYes: () {
          Global.store.currentUser.confirmAllOrders();
          Alert.alert(
            "Toutes vos commandes ont été confirmées !",
            onExit: () {
              update([orderListGetID]);
            },
          );
        },
      );
    } else {
      Alert.alert(
        "Vous n'avez placé aucune commande !",
        type: AlertType.failure,
      );
    }
  }

  Future<void> setTemporaryPosition() async {
    // if user decides yes;
    bool shouldProceed = false;
    await YesNoDialog.alert(
      title: "Location",
      color: aoi,
      message: "Étes-vous sûr(e) de vouloir utiliser votre location actuelle ?",
      onYes: () {
        shouldProceed = true;
      },
    );
    if (!shouldProceed) return;

    SimplePosition currentPosition = await SimplePosition.getCurrentPosition();
    if (currentPosition != null) {
      Global.store.currentUser.setTemporaryPosition(currentPosition);
      Alert.alert("Position Enregistrée");
    } else {
      Alert.alert(
        "Erreur lors du positionnement, vérifier que le GPS est allumé !",
        type: AlertType.failure,
      );
    }
  }

  Future<void> removeTemporaryPosition() async {
    Global.store.currentUser.unsetTemporaryPosition();
  }

  void switchAddress() async {
    bool gpsRecorded = Global.store.currentUser.isPositionTemporary;
    if (!gpsRecorded) {
      await setTemporaryPosition();
    } else {
      await removeTemporaryPosition();
    }
  }
}
