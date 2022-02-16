import 'package:get/get.dart';
import 'package:mechily/Components/AnimatedDialog.dart';
import 'package:mechily/Global/GlobalState.dart';
import 'package:mechily/Models/OneOrder.dart';
import 'package:mechily/Pages/BasketScreen/DetailsDialogModel.dart';
import 'package:mechily/Pages/BasketScreen/OrderDetailsDialog.dart';

class HistoryScreenModel extends GetxController {
  final Map deliveredOrders = Global.store.currentUser.deliveredOrders;
  // final String orderListGetID = "orders";
  // final String dateListGetID = "orders";
  final List<int> listOfStamps =
      Global.store.currentUser.deliveredOrders.keys.toList();

  int selectedIndex = Global.store.currentUser.deliveredOrders.length - 1;

  List<Order> get selectedList => deliveredOrders[listOfStamps[selectedIndex]];

  void selectDate(int index) {
    selectedIndex = index;
    update();
  }

  void showOrderDetails(Order order, {canOrder = false}) async {
    DetailsDialogModel controller =
        DetailsDialogModel(order, canOrder: canOrder);

    await AnimatedDialog.show(
      child: OrderDetailsDialog(model: controller),
    );
  }
}
