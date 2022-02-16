import 'package:mechily/Models/OneCondiment.dart';
import 'package:mechily/Models/OneDish.dart';
import 'package:mechily/Models/OneOrder.dart';
import 'package:flutter/material.dart';
import 'package:mechily/Models/OneResto.dart';

class Preset with OrderDetails implements OrderDetails {
  // ignore: unused_field
  final String _id;
  final String name;
  final String customCondimentsPreference;
  final List<Condiment> dislikedCondiments;
  final List<Resto> preferedRestos;
  final Dish dish;
  final int quantity;
  final DateTime dateCreated;

  Preset({
    id,
    @required this.dish,
    @required this.name,
    @required this.quantity,
    @required this.customCondimentsPreference,
    @required this.dislikedCondiments,
    @required this.preferedRestos,
    @required this.dateCreated,
  }) : _id = id ?? "preset" + DateTime.now().millisecondsSinceEpoch.toString() {
    refreshHighestPrice();
  }

  Preset.fromOrder(this.name, Order order)
      : assert(!order.isQuickOrder),
        assert(order.quantity >= 1),
        _id = "preset" + DateTime.now().millisecondsSinceEpoch.toString(),
        dish = order.dish,
        customCondimentsPreference = order.customCondimentsPreference,
        dislikedCondiments = [...order.dislikedCondiments],
        preferedRestos = [...order.preferedRestos],
        quantity = order.quantity,
        dateCreated = DateTime.now() {
    refreshHighestPrice();
  }

  Order toOrder() {
    Order order = Order(
      quantity: quantity,
      dish: dish,
      customCondimentsPreference: customCondimentsPreference,
      dislikes: [...dislikedCondiments],
      preferedRestos: [...preferedRestos],
    );

    return order;
  }

  get totalPrice {
    return quantity * unitPrice;
  }
}
